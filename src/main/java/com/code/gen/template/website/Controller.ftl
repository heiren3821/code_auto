package ${packagePrefix}.controller${packageSuffix};


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.stereotype.Controller;

import ${packagePrefix}.model${packageSuffix}.${beanName};
import ${packagePrefix}.service${packageSuffix}.${beanName}Service;
<#if 0<packageSuffix?length >
import ${packagePrefix}.controller.BaseManageController;
</#if>

/**
 * ### auto generate code.
 *
 */
@Controller
@RequestMapping("manage/${beanName?lower_case}")
public class ${beanName}Controller extends BaseManageController<Integer, ${beanName}> {	
	@Autowired
	private ${beanName}Service ${beanNick}Service;
	
	@Override
	protected ${beanName}Service getService() {
		return ${beanNick}Service;
	}

	@Override
	protected String validate(${beanName} ${beanNick}) {
		return validate(${beanNick}.getFields());
	}
}
