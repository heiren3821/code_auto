package ${packagePrefix}.service.cache;

public interface CacheClient {

	String get(String key);
	
	void set(String key,String value);
	
	void set(String key, String value, int expiredMins);
	
	void del(String key);
	
	long size();
}
