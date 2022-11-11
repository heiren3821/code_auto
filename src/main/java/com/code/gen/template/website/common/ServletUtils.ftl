package ${packagePrefix}.util;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import ${packagePrefix}.common.Constants;
import ${packagePrefix}.common.util.StringUtil;

/**
 * auto generate code.
 * @author james
 *
 */
public class ServletUtils {
	private static Logger logger = LoggerFactory.getLogger(ServletUtils.class);
	private ServletUtils() {
	}

	/**
	 * Get specific cookie
	 * 
	 * @param request
	 * @param cookieName
	 * @return
	 */
	public static Cookie getCookie(HttpServletRequest request, String cookieName) {
		String cn = StringUtils.trim(cookieName);
		Cookie[] cookies = request.getCookies();
		if (cookies != null && cn != null) {
			for (int i = 0; i < cookies.length; i++) {
				if (cn.equals(cookies[i].getName())) {
					return cookies[i];
				}
			}
		}
		return null;
	}

	/**
	 * Remove specific cookie
	 * 
	 * @param request
	 * @param response
	 * @param cookieName
	 */
	public static void forgotCookie(HttpServletRequest request, HttpServletResponse response, String cookieName) {
		Cookie cookie = ServletUtils.getCookie(request, cookieName.trim());
		if (cookie != null) {
			cookie.setMaxAge(0);
			cookie.setPath("/");
			response.addCookie(cookie);
			response.addHeader("P3P", "CP=\"IDC DSP COR ADM DEVi TAIi PSA PSD IVAi IVDi CONi HIS OUR IND CNT\"");
		}
	}

	/**
	 * Remove specific cookie under specific domain
	 * 
	 * @param request
	 * @param response
	 * @param domain
	 * @param cookieName
	 */
	public static void forgotCookie(HttpServletRequest request, HttpServletResponse response, String cookieName,
			String domain) {
		Cookie cookie = ServletUtils.getCookie(request, cookieName.trim());
		if (cookie != null) {
			cookie.setDomain(domain);
			cookie.setPath("/");
			cookie.setMaxAge(0);
			response.addCookie(cookie);
			response.addHeader("P3P", "CP=\"IDC DSP COR ADM DEVi TAIi PSA PSD IVAi IVDi CONi HIS OUR IND CNT\"");
		}
	}

	/**
	 * Set the cookie 
	 * 
	 * @param response
	 * @param cookieName
	 */
	public static void setCookie(HttpServletResponse response, String cookieName, String cookieValue) {
		Cookie cookie = new Cookie(cookieName.trim(), cookieValue);
		cookie.setPath("/");
		response.addCookie(cookie);
		response.addHeader("P3P", "CP=\"IDC DSP COR ADM DEVi TAIi PSA PSD IVAi IVDi CONi HIS OUR IND CNT\"");
	}
	
	/**
	 * Set the cookie with expire time
	 * 
	 * @param response
	 * @param cookieName
	 * @param cookieValue
	 */
	public static void setCookie(HttpServletResponse response, String cookieName, String cookieValue, int expireTime) {
		Cookie cookie = new Cookie(cookieName.trim(), cookieValue);
		cookie.setPath("/");
		cookie.setMaxAge(expireTime);
		response.addCookie(cookie);
		response.addHeader("P3P", "CP=\"IDC DSP COR ADM DEVi TAIi PSA PSD IVAi IVDi CONi HIS OUR IND CNT\"");
	}

	/**
	 * set cookie, allow set domain and expire time
	 * 
	 * @param response
	 * @param name
	 * @param value
	 * @param rootDomain
	 * @param expireTime
	 */
	public static void setCookie(HttpServletResponse response, String name, String value, String rootDomain,
			int expireTime) {
		Cookie cookie = new Cookie(name.trim(), value);
		cookie.setPath("/");
		cookie.setDomain(rootDomain);
		cookie.setMaxAge(expireTime);
		response.addCookie(cookie);
		response.addHeader("P3P", "CP=\"IDC DSP COR ADM DEVi TAIi PSA PSD IVAi IVDi CONi HIS OUR IND CNT\"");
	}

	/**
	 * set cookie, just allow set domain
	 * 
	 * @param response
	 * @param name
	 * @param value
	 * @param rootDomain
	 */
	public static void setCookie(HttpServletResponse response, String name, String value, String rootDomain) {
		Cookie cookie = new Cookie(name.trim(), value);
		cookie.setPath("/");
		cookie.setDomain(rootDomain);
		cookie.setMaxAge(3600 * 24 * 30);
		response.addCookie(cookie);
		response.addHeader("P3P", "CP=\"IDC DSP COR ADM DEVi TAIi PSA PSD IVAi IVDi CONi HIS OUR IND CNT\"");
	}

	/**
	 * Write strings to response
	 * 
	 * @param response
	 * @param out
	 */
	public static void writeResponse(HttpServletResponse response, String out) {
		response.setHeader("Cache-Control", "no-cache");
		response.setContentType("application/json; charset=UTF-8");
		// For 3-party cookie in IE
		response.setHeader("P3P", "CP='IDC DSP COR ADM DEVi TAIi PSA PSD IVAi IVDi CONi HIS OUR IND CNT'");
		PrintWriter pw = null;
		try {
			pw = response.getWriter();
			pw.write(out);
		} catch (IOException e) {
			logger.error("Failed to write response.");
		} finally {
			if (pw != null) {
				pw.flush();
				pw.close();
			}
		}
	}

	/**
	 * Write JSONP callback response
	 * 
	 * @param response
	 * @param out
	 * @param callback
	 */
	public static void writeCallbackResponse(HttpServletResponse response, String out, String callback) {
		String fullOutput = "";
		if (!StringUtils.isEmpty(callback)) {
			fullOutput = callback + "(" + out + ")";
		} else {
			fullOutput = out;
		}
		writeResponse(response, fullOutput);
	}

	/**
	 * 获取请求参数。
	 * 
	 * @param request
	 * @param param
	 * @return
	 */
	public static String getParam(HttpServletRequest request, String param) {
		String value = request.getParameter(param);
		return StringUtils.defaultIfEmpty(value, "");
	}
	
	public static String getUserName(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		if (session != null) {
			Object userName = session.getAttribute(Constants.SESSIION_USER_NAME);
			if (userName != null && StringUtils.isNotBlank(userName.toString())) {
				return userName.toString();
			}
		}
		Cookie cookie = getCookie(request, Constants.COOKIE_USER_NAME);
		if (cookie != null) {
			return StringUtil.base64Decode(cookie.getValue());
		}
		return "";
	}
	
	public static void setUserName(HttpServletRequest request, String userName) {
		if (StringUtils.isBlank(userName)) {
			return;
		}
		HttpSession session = request.getSession(true);
		session.setAttribute(Constants.SESSIION_USER_NAME, userName);
	}

	public static void setCookieUserName(HttpServletResponse response, String userName) {
		if (StringUtils.isBlank(userName)) {
			return;
		}
		setCookie(response, Constants.COOKIE_USER_NAME, StringUtil.base64Encode(userName));
	}
}
