package ${packagePrefix}.service.cache;

import java.util.concurrent.TimeUnit;

import com.google.common.cache.Cache;
import com.google.common.cache.CacheBuilder;

public class MemoryClient implements CacheClient {
	
	private int expiredMins = 720;
	
	private Cache<String, String> caches = CacheBuilder.newBuilder().expireAfterWrite(expiredMins, TimeUnit.MINUTES).initialCapacity(200).build();

	public MemoryClient() {
	}
	
	public MemoryClient(int expiredMins) {
		this.expiredMins = expiredMins;
	}
	
	@Override
	public String get(String key) {
		return caches.getIfPresent(key);
	}

	@Override
	public void set(String key, String value) {
		caches.put(key, value);

	}

	@Override
	public void set(String key, String value, int expiredMins) {
		set(key, value);
	}

	@Override
	public void del(String key) {
		caches.invalidate(key);
	}

	public int getExpiredMins() {
		return expiredMins;
	}

	public void setExpiredMins(int expiredMins) {
		this.expiredMins = expiredMins;
	}

	@Override
	public long size() {
		return caches.size();
	}
	
}
