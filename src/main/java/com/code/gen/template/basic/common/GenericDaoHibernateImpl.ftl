package ${packagePrefix}.dao;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import ${packagePrefix}.common.Constants;


/**
 * Implement GenericDao using Hibernate session factory.
 * 
 * @author James
 * 
 * @param <T>
 * @param <PK>
 */
@SuppressWarnings("unchecked")
@Transactional(readOnly = true)
public class GenericDaoHibernateImpl<T, PK extends Serializable> implements
        GenericDao<T, PK> {
	public static final String MAXRESULT = Constants.MAXRESULT;
	public static final String FIRSTRESULT = Constants.FIRSTRESULT;
	public static final String PARAM_LIST = Constants.PARAM_LIST;
	public static final String PARAM_LIKE = Constants.PARAM_LIKE;
	public static final String SORT_ASC_PREFIX = Constants.SORT_ASC_PREFIX;
	public static final String SORT_DESC_PREFIX = Constants.SORT_DESC_PREFIX;

    protected Logger log = LoggerFactory.getLogger(this.getClass());

    private Class<T> type;
    private String pkName;
    @Autowired
    private SessionFactory sessionFactory;
    
    public GenericDaoHibernateImpl() { }
    
    public GenericDaoHibernateImpl(Class<T> type) {
        this.type = type;
        this.pkName = "id";
    }
    
    public GenericDaoHibernateImpl(Class<T> type, String pkName) {
        this.type = type;
        this.pkName = pkName;
    }

    public GenericDaoHibernateImpl(Class<T> type, String pkName,
            SessionFactory sessionFactory) {
        this.type = type;
        this.pkName = pkName;
        this.sessionFactory = sessionFactory;
    }

	@Transactional(readOnly = false)
    public PK create(T o) {
        return (PK) getSession().save(o);
    }

    public T read(PK id) {
        return (T) getSession().get(type, id);
    }

	@Transactional(readOnly = false)
    public void update(T o) {
        getSession().update(o);
    }
    
    @Transactional(readOnly = false)
    public void saveOrUpdate(T o) {
        getSession().saveOrUpdate(o);
    }
    @Transactional(readOnly = false)
	public int update(Map<String, Object> modifiers, Map<String, Object> matchers) {
		if (modifiers != null && !modifiers.isEmpty()) {
			Query query = createUpdateHqlQuery("", modifiers, matchers);
			return query.executeUpdate();
		}
		return 0;
	}
	@Transactional(readOnly = false)
	public void updateFields(String fields, Map<String, Object> matchers) {
		if (StringUtils.isNotBlank(fields)) {
			Query query = createUpdateHqlQuery(fields, new HashMap<String, Object>(), matchers);
			query.executeUpdate();
		}
	}
	@Transactional(readOnly = false)
    public void update(Map<String, Object> modifiers, PK id) {
        Map<String, Object> matchers = new HashMap<String, Object>();
        matchers.put(pkName, id);
        update(modifiers, matchers);
    }

    public List<T> query(Map<String, Object> matchers) {
        Query query = createQueryHqlQuery(type, matchers,1);
        List<T> results = (List<T>) query.list();
        if (results == null) {
            results = new ArrayList<T>();
        }
        return results;
    }
    
	public List<PK> queryIds(Map<String, Object> matchers) {
		Query query = createQueryHqlQuery(type, matchers, 3);
		List<PK> results = (List<PK>) query.list();
		if (results == null) {
			results = new ArrayList<PK>();
		}
		return results;
	}
    
    public int queryCount(Map<String, Object> matchers) {
    	Query query = createQueryHqlQuery(type, matchers,2);
    	return ((Long)query.uniqueResult()).intValue();
    }

	@Transactional(readOnly = false)
    public void delete(T o) {
        getSession().delete(o);
    }

	@Transactional(readOnly = false)
    public void delete(PK id) {
        String hql = "DELETE FROM " + type.getName() + " WHERE " + pkName + "=" + id;
        getSession().createQuery(hql).executeUpdate();
    }
    
    @Transactional(readOnly = false)
    public void merge(T transientObject) {
        getSession().merge(transientObject);
    }
    
    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    protected Session getSession() {
        return sessionFactory.getCurrentSession();
    }
    
    protected <E> Query createUpdateHqlQuery(String updateFields, 
            Map<String, Object> modifiers, Map<String, Object> matchers) {
        
        assert (modifiers != null && !modifiers.isEmpty()) || StringUtils.isNotBlank(updateFields);
        
		StringBuilder hqlUpdate = new StringBuilder("UPDATE " + type.getName() + " SET ");
		if (StringUtils.isNotBlank(updateFields)) {
			hqlUpdate.append(updateFields);
			if (modifiers != null && !modifiers.isEmpty()) {
				hqlUpdate.append(",");
			}
		}
        // Append the modifiers in SET clause
        hqlUpdate.append(createHqlFromMap(modifiers, ", "));

        // Append the matchers in WHERE clause
        if (matchers != null && !matchers.isEmpty()) {
            hqlUpdate.append(" WHERE ");
            hqlUpdate.append(createHqlFromMap(matchers, " and "));
        }
        
        Query query = getSession().createQuery(hqlUpdate.toString());
        setQueryParameters(query, modifiers);
        setQueryParameters(query, matchers);

        if (log.isDebugEnabled()) {
            log.debug("Update " + type.getName() + ": " + hqlUpdate.toString());
        }
        return query;
    }
    
	protected <E> Query createQueryHqlQuery(Class<E> targetType,
			Map<String, Object> matchers, int type) {
		StringBuilder hqlUpdate = new StringBuilder(getHeadSqlByType(type) + "FROM " + targetType.getName());
		// Append the matchers in WHERE clause
		if (!isEmpty(matchers)) {
			hqlUpdate.append(" WHERE ");
			hqlUpdate.append(createHqlFromMap(matchers, " and "));
		}
		// add order by infos if not count(*) query set order info.
		if (type != 2) {
			hqlUpdate.append(createOrderHqls(matchers));
		}
        Query query = getSession().createQuery(hqlUpdate.toString());
        if (matchers.containsKey(Constants.MAXRESULT)) {
			if (type != 2) {
				query.setMaxResults((Integer) matchers.get(MAXRESULT));
			}
            matchers.remove(MAXRESULT);
        }
        if (matchers.containsKey(FIRSTRESULT)) {
			if (type != 2) {
				query.setFirstResult((Integer) matchers.get(FIRSTRESULT));
			}
            matchers.remove(FIRSTRESULT);
        }
        setQueryParameters(query, matchers);
        
        if (log.isDebugEnabled()) {
            log.debug("Query " + targetType.getName() + ": " + hqlUpdate.toString());
        }
        
        return query;
    }
	
	private boolean isEmpty(Map<String, Object> matchers) {
		if (matchers == null || matchers.isEmpty()) {
			return true;
		}
		Set<String> keys = new HashSet<String>(matchers.keySet());
		keys.remove(FIRSTRESULT);
		keys.remove(MAXRESULT);
		for (String temp : keys) {
			if (!StringUtils.startsWithAny(temp, SORT_ASC_PREFIX,
					SORT_DESC_PREFIX)) {
				return false;
			}
		}
		return true;
	}
	
	private String createOrderHqls(Map<String, Object> matchers) {
		List<String> sorts = new ArrayList<String>();
		for (String key : matchers.keySet()) {
			if (!StringUtils.startsWithAny(key, SORT_ASC_PREFIX, SORT_DESC_PREFIX)) {
				continue;
			}
			//TODO if multi order propertis, will sort it and readd.int num = NumberUtils.toInt(entry.getValue().toString());
			sorts.add(key);
		}
		if (sorts.isEmpty()) {
			return "";
		}
		StringBuffer sb = new StringBuffer(" order by ");
		for (int i = 0; i < sorts.size(); i++) {
			String sort = sorts.get(i);
			if (StringUtils.isBlank(sort)) {
				continue;
			}
			String[] temps = StringUtils.split(sort, "_");
			if (temps.length != 2) {
				continue;
			}
			sb.append(" ").append(i == 0 ? "" : ",").append(temps[1]).append(" ").append(temps[0]);
		}
		return sb.toString();
	}
	
	/**
	 * 1 for all 2 for count 3 for id
	 * @param type
	 * @return
	 */
	private String getHeadSqlByType(int type) {
		switch (type) {
		case 1:
			return "";
		case 2:
			return "select count(*) ";
		case 3:
			return "select " + pkName+" ";
		default:
			return "";
		}
	}

    /*
     * Build the HQL statement from names and values in the map
     */
    private String createHqlFromMap(Map<String, Object> map,
            String delimiter) {
        assert map != null && !map.isEmpty();
        StringBuilder hql = new StringBuilder();
        Set<String> keys = new HashSet<String>(map.keySet());
        keys.remove(FIRSTRESULT);
        keys.remove(MAXRESULT);
		Iterator<String> it = keys.iterator();
		int count = 0;
		while (it.hasNext()) {
			String itStr = it.next();
			if (StringUtils.startsWithAny(itStr, SORT_ASC_PREFIX, SORT_DESC_PREFIX)) {
				continue;
			}
			if (count > 0) {
				hql.append(delimiter);
			}
			//if the value is blank,only need to add key itself.
			if (StringUtils.isBlank(map.get(itStr).toString())) {
				hql.append(itStr);
				count++;
				continue;
			}
			String temp = "=";
			String end = "";
			if (StringUtils.endsWith(itStr, ">=")) {
				itStr = StringUtils.substringBefore(itStr, ">=");
				temp = " >= ";
				end = "1";
			}else if (StringUtils.endsWith(itStr, "<>")) {
				itStr = StringUtils.substringBefore(itStr, "<>");
				temp = " <> ";
				end = "5";
			} else if (StringUtils.endsWith(itStr, ">")) {
				itStr = StringUtils.substringBefore(itStr, ">");
				temp = "> ";
				end = "2";
			}else if (StringUtils.endsWith(itStr, "<=")) {
				itStr = StringUtils.substringBefore(itStr, "<=");
				temp = " <= ";
				end = "3";
			}else if (StringUtils.endsWith(itStr, "<")) {
				itStr = StringUtils.substringBefore(itStr, "<");
				temp = " < ";
				end = "4";
			} else if(StringUtils.endsWith(itStr, PARAM_LIST)) {
				itStr = StringUtils.substringBefore(itStr, PARAM_LIST);
				temp = " in (";
				end = ")";
			} else if(StringUtils.endsWith(itStr, PARAM_LIKE)) {
				itStr = StringUtils.substringBefore(itStr, PARAM_LIKE);
				temp = " like ";
			}
			itStr = StringUtils.trim(itStr);
			hql.append(itStr + temp + ":" + StringUtils.remove(itStr, ".") + end);
			count++;
		}
        return hql.toString();
    }
    
    private void setQueryParameters(Query query, Map<String, Object> map) {
        
		assert query != null;
		if (map != null && !map.isEmpty()) {
			Iterator<Map.Entry<String, Object>> it = map.entrySet().iterator();
			while (it.hasNext()) {
				Map.Entry<String, Object> entry = (Map.Entry<String, Object>) it.next();
				if (StringUtils.startsWithAny(entry.getKey(), SORT_ASC_PREFIX, SORT_DESC_PREFIX)) {
					continue;
				}
				//if value is blank no need handle .
				if(StringUtils.isBlank(entry.getValue().toString())) {
					continue;
				}
				if (entry.getKey().endsWith(PARAM_LIST)) {
					String key = StringUtils.substringBefore(entry.getKey(), PARAM_LIST);
					query.setParameterList(StringUtils.remove(key,"."), (List<Integer>) entry.getValue());
				} else {
					String temp = entry.getKey();
					String end = "";
					if (StringUtils.endsWith(temp, ">=")) {
						temp = StringUtils.substringBefore(temp, ">=");
						end = "1";
					} else if (StringUtils.endsWith(temp, "<>")) {
						temp = StringUtils.substringBefore(temp, "<>");
						end = "5";
					} else if (StringUtils.endsWith(temp, ">")) {
						temp = StringUtils.substringBefore(temp, ">");
						end = "2";
					} else if (StringUtils.endsWith(temp, "<=")) {
						temp = StringUtils.substringBefore(temp, "<=");
						end = "3";
					} else if (StringUtils.endsWith(temp, "<")) {
						temp = StringUtils.substringBefore(temp, "<");
						end = "4";
					} else if (StringUtils.endsWith(temp, PARAM_LIKE)) {
						temp = StringUtils.substringBefore(temp, PARAM_LIKE);
					}
					query.setParameter(StringUtils.remove(temp, ".") + end, entry.getValue());
				}
			}
		}
    }
    
    public void setType(Class<T> type) {
        this.type = type;
    }
    
    public void setPkName(String pkName) {
        this.pkName = pkName;
    }
    
    public List<T> nameQuery(String queryName , Map<String, Object> map) {
        if (StringUtils.isBlank(queryName)) {
            return new ArrayList<T>();
        }
        Query query = getSession().getNamedQuery(queryName);
        if (map == null || map.isEmpty()) {
            return (List<T>) query.list();
        }
        if (map.containsKey(MAXRESULT)) {
            query.setMaxResults((Integer) map.get(MAXRESULT));
            map.remove(MAXRESULT);
        }
        if (map.containsKey(FIRSTRESULT)) {
            query.setFirstResult((Integer) map.get(FIRSTRESULT));
            map.remove(FIRSTRESULT);
        }
        setQueryParameters(query, map);
        return (List<T>) query.list();
    }
}
