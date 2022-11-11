package ${packagePrefix}.common.web.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


public class XssFilter implements Filter {
	private static final Logger log = LoggerFactory.getLogger(XssFilter.class);
	
	private String noFilterUrl;

	@Override
	public void init(FilterConfig config) throws ServletException {
		noFilterUrl = config.getInitParameter("noFilterUrl");
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		try{
			HttpServletRequest newHttpRequest = (HttpServletRequest) request;
//			newHttpRequest.setCharacterEncoding("utf-8");
//			System.out.println(newHttpRequest.getQueryString());
			String uri = newHttpRequest.getRequestURI();
			if(noFilterUrl != null && noFilterUrl.indexOf(uri) >= 0){
				chain.doFilter(newHttpRequest, response);
			}else{
				XssHttpServletRequestWrapper xssRequest = new XssHttpServletRequestWrapper(newHttpRequest);
				chain.doFilter(xssRequest, response);
			}
		}catch(Exception e){
			log.error("xss Filter 异常！",e);
			chain.doFilter(request, response);
		}



//		chain.doFilter(request, response);
	}

	@Override
	public void destroy() {

	}

}
