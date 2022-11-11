package com.code.gen.process;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang3.RandomStringUtils;
import org.apache.commons.lang3.RandomUtils;

import com.code.gen.process.configuration.Config;
import com.code.gen.process.model.ProcessBean;
import com.code.gen.process.util.PackageUtil;

/**
 * @author chenweixiong
 *
 */
public class BeanProcessor extends Processor {
	
	private ProcessBean bean;
	
	public BeanProcessor(String suffix) {
		super(suffix);
	}
	
	public BeanProcessor(String suffix, boolean other) {
		super(suffix, other);
	}

	public ProcessBean getBean() {
		return bean;
	}

	public void setBean(ProcessBean bean) {
		this.bean = bean;
	}

	@Override
	protected Map<String, Object> getProcessData() {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("beanName", bean.getBeanName());
		params.put("beanNick", bean.getBeanNick());
		params.put("projectName", bean.getProjectName());
		params.put("projectPrefix", bean.getProjectPrefix());
		params.put("packagePrefix", bean.getPackagePrefix());
		params.put("packageSuffix", bean.getPackageSuffix());
		params.put("tableName", bean.getTableName());
		params.put("menuName", bean.getMenuName());
		params.put("tableComment", bean.getTableComment());
		params.put("moduleName", bean.getModuleName());
		params.put("serialId", RandomUtils.nextInt(1, 10) + RandomStringUtils.randomNumeric(17));
		params.put("fields", bean.getFields());
		params.put("outBeans", bean.getOutBeans());
		params.put("hasDate", bean.hasDateType());
		params.put("excludesFields", bean.getExcludesFields());
		params.put("modules", bean.getModules());
		params.put("processBeans", bean.getProcessBeans());
		params.put("projectDesc", bean.getProjectDesc());
		return params;
	}
	
	@Override
	protected String getStoreParentPath() {
		return PackageUtil.amendFilePath(Config.getOutResultPath(),bean.getProjectName(),bean.getModuleName());
	}

	@Override
	protected Map<String, String> getFileNameParams() {
		Map<String, String> params = super.getFileNameParams();
		params.put("beanName", bean.getBeanName());
		params.put("projectPrefix", bean.getProjectPrefix());
		params.put("projectName", bean.getProjectName());
		return params;
	}

	@Override
	protected Map<String, String> getStoreParams() {
		Map<String, String> params = new HashMap<String, String>();
		params.put("packagePrefix", bean.getPackagePrefix());
		params.put("packageSuffix", bean.getPackageSuffix());
		params.put("beanlowName", bean.getBeanLowName());
		params.put("projectName", bean.getProjectName());
		return params;
	}
	
}
