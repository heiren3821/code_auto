package com.lianwifi.sms.dao.merchant;

import org.springframework.stereotype.Repository;

import com.lianwifi.sms.dao.MainDaoBase;
import com.lianwifi.sms.model.merchant.Template;

/**
 * ### auto generate code.
 *
 */
@Repository
public class TemplateDao extends MainDaoBase<Template, Integer> {

	public TemplateDao() {
		super(Template.class);
	}
}