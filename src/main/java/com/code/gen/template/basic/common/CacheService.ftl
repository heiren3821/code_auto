package ${packagePrefix}.service;

import java.lang.reflect.ParameterizedType;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.math.NumberUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import ${packagePrefix}.common.Constants;
import ${packagePrefix}.dao.MainDaoBase;
import ${packagePrefix}.model.Entity;
import ${packagePrefix}.model.Pagination;
import ${packagePrefix}.service.cache.CacheClient;
import ${packagePrefix}.service.cache.MemoryClient;

/**
 * ##auto generate code.
 *
 */
@SuppressWarnings("unchecked")
@Transactional(readOnly = true)
public abstract class CacheService<PK extends Number,E extends Entity<PK>>{
	protected Logger logger = LoggerFactory.getLogger(this.getClass());
    
	protected CacheClient cacheClient = new MemoryClient();
	
	protected abstract MainDaoBase<E, PK> getMainDao();
	
	protected E get(PK id) {
		E e = getCacheEntity(id);
		if (e == null) {
			e = getMainDao().read(id);
			set(getCacheKey(id), e);
		}
		return e;
	}
	
	protected E amendEntity(E e) {
		return e;
	}
	
	protected List<E> amendEntities(List<E> es) {
		for (E e : es) {
			amendEntity(e);
		}
		return es;
	}
	
	/**get realted entitys by ids.
	 * @param ids
	 * @return
	 */
	public List<E> getByIds(List<PK> ids) {
		List<E> result = new ArrayList<E>();
		if (ids.isEmpty()) {
			return result;
		}
		for (PK id : ids) {
			E e = get(id);
			if (e != null) {
				result.add(amendEntity(e));
			}
		}
		return result;
	}
	
	public E getById(PK id) {
		E e = get(id);
		return amendEntity(e == null ? getEntityObject() : e);
	}
	
	public E getEntityObject() {
		E e = null;
		try {
			e = getEntityClass().newInstance();
		} catch (Exception ex) {
			logger.error("getById errro", e);
		}
		return e;
	}

	protected void invalidEntity(PK id) {
		cacheClient.del(getCacheKey(id));
	}
	
	public List<E> getEntitys(Map<String, Object> params) {
		return getByIds(getMainDao().queryIds(params));
	}
	
	protected E getBySingleDb(String param, Object value) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put(param, value);
		List<E> entitys = getEntitys(params);
		return entitys.size() > 0 ? entitys.get(0) : getEntityObject();
	}
	
	public E getBySingleKey(String param, Object value) {
		String codeKey = getProjectKey(param, value.toString());
		Integer id = getInt(codeKey);
		if (id > 0) {
			return getById((PK) id);
		}
		E entity = amendEntity(getBySingleDb(param, value));
		if (entity.isPersist()) {
			setStr(codeKey, String.valueOf(entity.getId()));
		}
		return entity;
	}
	
	public List<E> queryEntitys(Map<String, Object> params) {
		return getMainDao().query(params);
	}
	
	public Pagination<E> getPagination(Pagination<E> pagination) {
		pagination.setCount(queryCount(pagination.getParams()));
		pagination.setItems(getEntitys(pagination.getParams()));
		return pagination;
	}
	
	public int queryCount(Map<String,Object> params) {
		return getMainDao().queryCount(params);
	}
	
	public List<PK> getIds(Map<String, Object> params) {
		return getMainDao().queryIds(params);
	}
	
	protected String getSimplePrefix() {
		return this.getClass().getSimpleName();
	}
	
	protected void set(PK id, E e) {
		set(getCacheKey(id), e);
	}
	
	private void set(String key, E e) {
		setStr(key, JSONObject.toJSONString(e));
	}
	
	protected void setStr(String key, String value) {
		setStr(key, value, getExpiredHour());
	}
	
	protected void setStr(String key, String value, int expiredHour) {
		setExpireMinsStr(key, value, expiredHour * 60);
	}
	
	protected void delStr(String key) {
		cacheClient.del(key);
	}
	
	/**this method will record relateKey,when entry will be removed,the list will be deleted too.
	 * @param key
	 * @param value
	 */
	protected void setFixExpireMins(String key, String value) {
		setExpireMinsStr(key, value, 10);
	}

	protected void setExpireMinsStr(String key, String value, int expiredMins) {
		cacheClient.set(key, value, expiredMins);
	}
	
	protected String getStr(String key) {
		return cacheClient.get(key);
	}
	
	protected int getInt(String key) {
		return NumberUtils.toInt(getStr(key));
	}

	protected long getLong(String key) {
		return NumberUtils.toLong(getStr(key));
	}
	
	protected List<Integer> getIntList(String key) {
		String result = getStr(key);
		return StringUtils.isBlank(result) ? new ArrayList<Integer>()
				: Arrays.asList(JSONArray.parseArray(getStr(key)).toArray(new Integer[1]));
	}
	
	protected int getExpiredHour() {
		return 24;
	}

	private E getCacheEntity(PK id) {
		if (id.intValue() == 0) {
			return getEntityObject();
		}
		String entity = cacheClient.get(getCacheKey(id));
		return StringUtils.isBlank(entity) ? null
				: JSONObject.toJavaObject((JSONObject) JSONObject.parse(entity), getEntityClass());
	}

	public String getCachePrefix() {
		return getCacheKey(Constants.REDIS_PROJECT, "ENTITY", getSimplePrefix());
	}

	private String getCacheKey(PK id) {
		return getCachePrefix() + id;
	}
	
	@Transactional(readOnly = false)
	public void saveOrUpdate(E e) {
		invalidEntity(e.getId());
		getMainDao().saveOrUpdate(e);
	}
	
	@Transactional(readOnly = false)
	public boolean updateById(Map<String, Object> params, PK id) {
		params.put("updateTime", new Date());
		invalidEntity(id);
		getMainDao().update(params, id);
		return true;
	}
	
	private String getCacheKey(String... params) {
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < params.length; i++) {
			if (i == 0) {
				sb.append(params[i]);
			} else {
				sb.append(Constants.REDIS_SPLIT).append(params[i]);
			}
		}
		return sb.toString();
	}
	
	protected String getProjectKey(String... params) {
		List<String> temps = new ArrayList<String>();
		temps.add(Constants.REDIS_PROJECT);
		temps.add(getSimplePrefix());
		temps.addAll(Arrays.asList(params));
		return getCacheKey(temps.toArray(new String[] {}));
	}
	
	protected Class<E> getEntityClass() {
		return (Class<E>) ((ParameterizedType) getClass().getGenericSuperclass()).getActualTypeArguments()[1];
	}
}
