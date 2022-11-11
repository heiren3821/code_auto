package ${packagePrefix}.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import ${packagePrefix}.common.util.StringUtil;
import ${packagePrefix}.model.${projectPrefix?cap_first}UserInfo;
import ${packagePrefix}.util.ServletUtils;

/**
 * ### auto generate code.
 *
 */
@Controller
@RequestMapping("${projectPrefix}")
public class SsoController extends BaseController {
	
	private Logger logger = LoggerFactory.getLogger(SsoController.class);

	@RequestMapping(value = { "login", "/" }, method = RequestMethod.GET)
	public String login(HttpServletRequest request, Model mode) {
		String userName = getUserName(request);
		logger.info("userName {} login in system ", getUserName(request));
		return StringUtils.isBlank(userName) ? "login" : "redirect:dashboard";
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(${projectPrefix?cap_first}UserInfo userInfo, HttpServletRequest request, HttpServletResponse response, Model model) {
		if (StringUtils.isBlank(userInfo.getUserName()) || StringUtils.isBlank(userInfo.getPassword())) {
			model.addAttribute("errorMessage", "用户名和密码不能为空");
			logger.info("AUTH FAILURE: user name and password should not be null");
			return "login";
		}
		${projectPrefix?cap_first}UserInfo tempUserInfo = ${projectPrefix?uncap_first}UserInfoService.getByAccount(userInfo.getUserName());
		if (!StringUtils.equalsIgnoreCase(tempUserInfo.getPassword(),
				StringUtil.getMD5Hex(userInfo.getPassword() + tempUserInfo.getSalt()))) {
			model.addAttribute("errorMessage", "密码错误");
			logger.info("AUTH FAILURE: wrong passwd");
			return "login";
		}
		ServletUtils.setUserName(request, userInfo.getUserName());
		if (userInfo.isRememberMe()) {
			ServletUtils.setCookieUserName(response, userInfo.getUserName());
		}
		return "redirect:dashboard";
	}
	
	@RequestMapping("logout")
	public String logout(HttpServletRequest request, Model mode) {
	logger.info("userName {} login out system ",getUserName(request));
		request.getSession().invalidate();
		return "redirect:login";
	}
	
	@RequestMapping("autherror")
	public String authError(HttpServletRequest request, Model mode) {
		request.getSession().invalidate();
		return "authError";
	}
	
	/**
	 * @return
	 */
	@RequestMapping("dashboard")
	public String dashboard(Model model) {
		return "dashboard";
	}
}
