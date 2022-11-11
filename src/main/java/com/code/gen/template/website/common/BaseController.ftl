package ${packagePrefix}.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.alibaba.fastjson.JSONObject;
import ${packagePrefix}.model.${projectPrefix?cap_first}UserInfo;
import ${packagePrefix}.service.${projectPrefix?cap_first}UserInfoService;

/**
 * ## auto generate code.
 * @author james.chen
 *
 */
public class BaseController {
	
	protected Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	protected ${projectPrefix?cap_first}UserInfoService ${projectPrefix}UserInfoService;
	
	public String getUserName(HttpServletRequest request) {
		return "";
	}
	
	public ${projectPrefix?cap_first}UserInfo getUser(HttpServletRequest request) {
		return ${projectPrefix}UserInfoService.getByAccount(getUserName(request));
	}

	public int getUserId(HttpServletRequest request) {
		return getUser(request).getId();
	}
	
	protected JSONObject result(String retCode, String message) {
		JSONObject json = new JSONObject();
		json.put("retCode", retCode);
		json.put("retMsg", message);
		return json;
	}
	
	protected boolean isSuccess(JSONObject temp) {
		return "0".equals(temp.getString("retCode"));
	}
	
	protected Map<String, String> getParamsMap(HttpServletRequest request) {
		Map<String, String> params = new HashMap<String, String>();
		for (Object param : request.getParameterMap().keySet()) {
			params.put(param.toString(), request.getParameter(param.toString()));
		}
		return params;
	}
}
