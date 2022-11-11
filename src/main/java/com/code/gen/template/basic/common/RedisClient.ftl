package ${packagePrefix}.service.cache;

import java.util.concurrent.TimeUnit;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.data.redis.core.ValueOperations;

public class RedisClient implements CacheClient {
	
	@Resource(name="${projectPrefix?uncap_first}BasicRedisTemplate")
	protected StringRedisTemplate redisTemplate;
	
	protected ValueOperations<String, String> valueOps;
	
	@PostConstruct
	public void init() {
		valueOps = redisTemplate.opsForValue();
	}

	@Override
	public String get(String key) {
		return valueOps.get(key);
	}

	@Override
	public void set(String key, String value) {
		if (StringUtils.isBlank(key) || StringUtils.isBlank(value)) {
			return;
		}
		valueOps.set(key, value);
	}

	@Override
	public void set(String key, String value, int expiredMins) {
		set(key, value);
		if(expiredMins>0) {
			redisTemplate.expire(key, expiredMins, TimeUnit.MINUTES);
		}
	}

	@Override
	public void del(String key) {
		redisTemplate.delete(key);

	}

	@Override
	public long size() {
		return 0;
	}

}
