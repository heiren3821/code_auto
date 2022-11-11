package com.lianwifi.sms.service.merchant;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lianwifi.sms.dao.MainDaoBase;
import com.lianwifi.sms.dao.merchant.TemplateDao;
import com.lianwifi.sms.model.merchant.Template;
import com.lianwifi.sms.redis.RedisService;

/**
 * ###
 * ### auto generate code.
 *
 */
@Service
@Transactional(readOnly = true)
public class TemplateService extends RedisService<Integer, Template> {
	
	@Autowired
	private TemplateDao templateDao;

	@Override
	protected MainDaoBase<Template, Integer> getMainDao() {
		return templateDao;
	}
}
