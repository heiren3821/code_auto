package ${packagePrefix}.common.web.action;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 404 500异常错误页
 *
 */
@Controller
public class ErrorAction {
	private static final Logger log = LoggerFactory.getLogger("400500.log");

	@RequestMapping(value="/error.htm")
	public String error(ModelMap model){
		log.error("unknown error!");
		return "/exception/error";
	}
	
	@RequestMapping(value="/error500.htm")
	public String error500(ModelMap model){
		log.error("500 error!");
		return "/exception/error";
	}
	
	@RequestMapping(value="/error400.htm")
	public String error400(ModelMap model){
		log.error("400 error!");
		return "/exception/error";
	}
	
	@RequestMapping(value="/error403.htm")
	public String error403(ModelMap model){
		log.error("403 error!");
		return "/exception/error";
	}
	
	@RequestMapping(value="/error404.htm")
	public String error404(ModelMap model){
		log.error("404 error!");
		return "/exception/error";
	}
}
