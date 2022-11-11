package com.lianwifi.sms.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.lianwifi.sms.model.Field;
import com.lianwifi.sms.model.merchant.Template;
import com.lianwifi.sms.service.merchant.TemplateService;

/**
 * ### auto generate code.
 *
 */
@Controller
@RequestMapping("manage/template")
public class TemplateController extends BaseController {
	private static String FOLDER = "template/";
	
	@Autowired
	private TemplateService templateService;
	
	protected String validate(Template template) {
		List<Field> fields = new ArrayList<Field>();
		return validate(fields);
	}
}
