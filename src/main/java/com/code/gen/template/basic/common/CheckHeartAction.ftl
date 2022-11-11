package ${packagePrefix}.common.web.action;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * ##auto generate code.
 *
 */
@Controller
public class CheckHeartAction {
	
	@RequestMapping(value = "/checkHeart.htm")
	@ResponseBody
	public String test() {
		return "ok!";
	}

}
