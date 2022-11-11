package ${packagePrefix}.dao;

import java.io.Serializable;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.transaction.annotation.Transactional;


/**
 * Implement GenericDao using Hibernate session factory.
 * 
 *  ##auto generate code.
 * 
 * @param <T>
 * @param <PK>
 */
public class MainDaoBase<T, PK extends Serializable> extends GenericDaoHibernateImpl<T, PK> {
    
    public MainDaoBase() { }
    
    public MainDaoBase(Class<T> type) {
        super(type);
    }
    
    public MainDaoBase(Class<T> type, String pkName) {
        super(type, pkName);
    }

    public MainDaoBase(Class<T> type, String pkName, SessionFactory sessionFactory) {
        super(type, pkName, sessionFactory);
    }

    @Override
    @Transactional(readOnly = false)
    public PK create(T o) {
        return super.create(o);
    }

    @Override
    @Transactional(readOnly = true)
    public T read(PK id) {
        return super.read(id);
    }

    @Override
    @Transactional(readOnly = false)
    public void update(T o) {
        super.update(o);
    }

    @Override
    @Transactional(readOnly = false)
    public void saveOrUpdate(T o) {
        super.saveOrUpdate(o);
    }

    @Override
    @Transactional(readOnly = false)
    public int update(Map<String, Object> modifiers,
            Map<String, Object> matchers) {
        return super.update(modifiers, matchers);
    }
    
    @Override
    @Transactional(readOnly = false)
	public void updateFields(String updateFields, Map<String, Object> matchers) {
		super.updateFields(updateFields,matchers);
	}
    

    @Override
    @Transactional(readOnly = false)
    public void update(Map<String, Object> modifiers, PK id) {
        super.update(modifiers, id);
    }

    @Override
    @Transactional(readOnly = true)
    public List<T> query(Map<String, Object> matchers) {
        return super.query(matchers);
    }
    
    @Override
    @Transactional(readOnly = true)
    public List<PK> queryIds(Map<String, Object> matchers) {
        return super.queryIds(matchers);
    }

    @Override
    @Transactional(readOnly = false)
    public void delete(T o) {
        super.delete(o);
    }

    @Override
    @Transactional(readOnly = false)
    public void delete(PK id) {
        super.delete(id);
    }

    @Override
    @Transactional(readOnly = false)
    public void merge(T transientObject) {
        super.merge(transientObject);
    }

    @Transactional(readOnly = true)
    public long getNameQueryCount(String queryName , Map<String, Object> parameterMap) {
        if (StringUtils.isBlank(queryName)) {
            return 0;
        }
        Query query = getSession().getNamedQuery(queryName);
        setQueryParameters(query, parameterMap);
        return (Long) query.uniqueResult();
    }

    private void setQueryParameters(Query query , Map<String, Object> map) {
        assert query != null;
        if (map != null && !map.isEmpty()) {
            Iterator<Map.Entry<String, Object>> it = map.entrySet().iterator();
            while (it.hasNext()) {
                Map.Entry<String, Object> entry = (Map.Entry<String, Object>) it.next();
                query.setParameter(entry.getKey(), entry.getValue());
            }
        }
    }
}
