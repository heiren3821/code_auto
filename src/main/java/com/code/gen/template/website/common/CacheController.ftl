package ${packagePrefix}.controller;

import java.net.InetAddress;
import java.net.NetworkInterface;
import java.util.Enumeration;
import java.util.concurrent.TimeUnit;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.math.NumberUtils;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import ${packagePrefix}.service.cache.CacheClient;
import ${packagePrefix}.service.cache.MemoryClient;

@Controller
public class CacheController extends BaseController {

	private static String cacheToken = "${projectPrefix}Cache~";
	
	private CacheClient  cacheClient = new MemoryClient();

	@RequestMapping("manage/cache/query.do")
	@ResponseBody
	public JSONObject query(String key, String token, HttpServletRequest request) {
		logger.info("userId {} query key{},token {}", getUserId(request), key, token);
		return result(key, getByToken(key, token));
	}
	
	private boolean isValidToken(String token) {
		return cacheToken.equals(token);
	}
	
	@RequestMapping("manage/cache/del.do")
	@ResponseBody
	public JSONObject delete(String key, String token, HttpServletRequest request) {
		logger.info("userId {} delete key{},token {}", getUserId(request), key, token);
		if (isValidToken(token)) {
			cacheClient.del(key);
		}
		return result(key, getByToken(key, token));
	}
	
	@RequestMapping("manage/checkip.do")
	@ResponseBody
	public JSONObject checkIp() {
		JSONObject result = new JSONObject();
		try {
			Enumeration<NetworkInterface> Interfaces = NetworkInterface.getNetworkInterfaces();
			while (Interfaces.hasMoreElements()) {
				NetworkInterface Interface = (NetworkInterface) Interfaces.nextElement();
				Enumeration<InetAddress> Addresses = Interface.getInetAddresses();
				while (Addresses.hasMoreElements()) {
					InetAddress address = (InetAddress) Addresses.nextElement();
					result.put(address.getHostAddress(), "1");
				}
			}
			result.put("2",InetAddress.getLocalHost().getHostAddress());
		} catch (Exception e) {
			logger.error("error",e);
		}
		return result;
	}
	
	private String getByToken(String key,String token) {
		return isValidToken(token) ? cacheClient.get(key) : "";
	}
	
	@RequestMapping("manage/cache/set.do")
	@ResponseBody
	public JSONObject set(String key, String value, String expiredMins, String token, HttpServletRequest request) {
		logger.info("userId {} delete key{} value {} expiredMins {},token {}", getUserId(request), key, value,
				expiredMins, token);
		if (isValidToken(token)) {
			int tempMins = StringUtils.isBlank(expiredMins) ? 30 : NumberUtils.toInt(expiredMins);
			cacheClient.set(key, value, tempMins);
		}
		return result(key, getByToken(key, token));
	}
	
	@RequestMapping("manage/cache/size")
	@ResponseBody
	public JSONObject size(String token, HttpServletRequest request) {
		logger.info("userId {}  ,token {}", getUserId(request), token);
		long size = 0;
		if (isValidToken(token)) {
			size = cacheClient.size();
		}
		return result("size", String.valueOf(size));
	}
}
