package ${packagePrefix}.interceptor;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.MethodParameter;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.method.support.HandlerMethodReturnValueHandler;
import org.springframework.web.method.support.ModelAndViewContainer;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.alibaba.fastjson.JSONObject;
import ${packagePrefix}.model.${projectPrefix?cap_first}UserInfo;
import ${packagePrefix}.service.${projectPrefix?cap_first}UserInfoService;
import ${packagePrefix}.util.ServletUtils;

/**
 * ### auto generate code
 *
 */
public class AuthCheckInterceptor extends HandlerInterceptorAdapter implements HandlerMethodReturnValueHandler {

	protected Logger logger = LoggerFactory.getLogger(AuthCheckInterceptor.class);
	
	@Autowired
	private ${projectPrefix?cap_first}UserInfoService ${projectPrefix}UserInfoService;

	private static String MANAGE_URI_LOCAL = ".*/manage/.*.do$";
	private static String IGNORE_URI_LOCAL = ".*/api/.*$";
	private static String CURRENT_KEY = "current_start";

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
			request.setAttribute(CURRENT_KEY, System.currentTimeMillis());
		if (!isIgnoreUri(request.getRequestURI())) {
			${projectPrefix?cap_first}UserInfo userInfo = genUser(request);
			if (!userInfo.isAdmin()&&isManageUri(request.getRequestURI())) {
				request.getSession().invalidate();
				response.sendRedirect(request.getContextPath() + "/${projectPrefix}/autherror.do");
				return false;
			}
		request.setAttribute("USER_ROLES", userInfo.getRoleNames());
		}
		return super.preHandle(request, response, handler);
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		long start = (Long) request.getAttribute(CURRENT_KEY);
		long end = System.currentTimeMillis();
		logger.info("requestUrl {} params{} cost{}", request.getRequestURI(), getParamsMap(request),end - start);
		super.afterCompletion(request, response, handler, ex);
	}

	public boolean isManageUri(String requestUri) {
		return Pattern.matches(MANAGE_URI_LOCAL, requestUri);
	}
	
	public boolean isIgnoreUri(String requestUri) {
		return Pattern.matches(IGNORE_URI_LOCAL, requestUri);
	}
	
	private ${projectPrefix?cap_first}UserInfo genUser(HttpServletRequest request) {
		String loginName = ServletUtils.getUserName(request);
		return StringUtils.isBlank(loginName)?new ${projectPrefix?cap_first}UserInfo():${projectPrefix}UserInfoService.getByAccount(loginName);
	}
	
	protected Map<String, String> getParamsMap(HttpServletRequest request) {
		Map<String, String> params = new HashMap<String, String>();
		for (Object param : request.getParameterMap().keySet()) {
			params.put(param.toString(), request.getParameter(param.toString()));
		}
		return params;
	}

	@Override
	public boolean supportsReturnType(MethodParameter returnType) {
		return returnType.getParameterType() == JSONObject.class;
	}

	@Override
	public void handleReturnValue(Object returnValue, MethodParameter returnType, ModelAndViewContainer mavContainer,
			NativeWebRequest webRequest) throws Exception {
		logger.info("requestUrl {} returnValue{}", webRequest.getContextPath(), returnValue);
	}
}
