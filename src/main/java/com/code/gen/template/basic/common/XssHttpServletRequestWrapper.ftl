package ${packagePrefix}.common.web.filter;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


public class XssHttpServletRequestWrapper extends HttpServletRequestWrapper {

	private static final Logger logger = LoggerFactory.getLogger(XssHttpServletRequestWrapper.class);
	HttpServletRequest orgRequest = null;
//	private HTMLFilter htmlFilter;
//
//
//
//	public HTMLFilter getHtmlFilter() {
//		if (htmlFilter == null){
//			htmlFilter = new HTMLFilter();
//		}
//		return htmlFilter;
//	}

	public XssHttpServletRequestWrapper(HttpServletRequest request) {
		super(request);
		orgRequest = request;
	}

	/**
	* 覆盖getParameter方法，将参数名和参数值都做xss过滤。<br/>
	* 如果需要获得原始的值，则通过super.getParameterValues(name)来获取<br/>
	* getParameterNames,getParameterValues和getParameterMap也可能需要覆盖
	*/
	@Override
	public String getParameter(String name) {
		String value = super.getParameter(filter(name));
		if (value != null) {
			value = filter(value);
		}
		return value;
	}

	@Override
	public String[] getParameterValues(String name) {
		try{
			if (name != null && filter(name) != null && super.getParameterValues(filter(name))!=null){
				List<String> values = Arrays.asList(super.getParameterValues(filter(name)));
				List<String> returnList = new ArrayList<String>();
				for(String value :values){
					if (value != null) {
						value = filter(value);
						returnList.add(value);
					}

				}
				return (String[]) returnList.toArray(new String[returnList.size()]);
			}

			return null;



		}catch(Exception e){
			logger.error("xss http servlet request wrapper error!",e);
			return null;
		}

	}



	/**
	* 覆盖getHeader方法，将参数名和参数值都做xss过滤。<br/>
	* 如果需要获得原始的值，则通过super.getHeaders(name)来获取<br/>
	* getHeaderNames 也可能需要覆盖
	*/
	@Override
	public String getHeader(String name) {

		String value = super.getHeader(filter(name));
		if (value != null) {
			value = filter(value);
		}
		return value;
	}



	@Override
	public String getQueryString() {
		String value = super.getQueryString();
		if (value != null){
			value = filter(value);
		}
		return value;
	}

	private String filter(String value){
		value = value.replaceAll("%3E", ">");
		value = value.replaceAll("%3C", "<");
		value = value.replaceAll("%22", "");
		value = value.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
        value = value.replaceAll("\\(", "&#40;").replaceAll("\\)", "&#41;");
        value = value.replaceAll("'", "&#39;");
        value = value.replaceAll("eval\\((.*)\\)", "");
        value = value.replaceAll("[\\\"\\\'][\\s]*javascript:(.*)[\\\"\\\']", "\"\"");
        value = value.replaceAll("script", "");
        return value;

		//return getHtmlFilter().filter(value);
	}

	/**
	* 获取最原始的request
	*
	* @return
	*/
	public HttpServletRequest getOrgRequest() {
		return orgRequest;
	}
	/**
	* 获取最原始的request的静态方法
	*
	* @return
	*/
	public static HttpServletRequest getOrgRequest(HttpServletRequest req) {
		if(req instanceof XssHttpServletRequestWrapper){
			return ((XssHttpServletRequestWrapper)req).getOrgRequest();
		}

		return req;
	}

}
