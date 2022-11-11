package com.code.gen.process.model;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;

import com.code.gen.process.configuration.Config;
import com.code.gen.process.util.PackageUtil;

public class ProjectBean {

	private String projectName;
	
	private String packagePrefix;
	
	private String projectDesc;
	private List<ProcessBean> processBeans = new ArrayList<ProcessBean>();

	public String getProjectName() {
		return projectName;
	}

	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}
	
	public String getPackagePrefix() {
		return packagePrefix;
	}

	public void setPackagePrefix(String packagePrefix) {
		this.packagePrefix = packagePrefix;
	}
	public String getProjectDesc() {
		return projectDesc;
	}

	public void setProjectDesc(String projectDesc) {
		this.projectDesc = projectDesc;
	}

	public String getProjectPrefix() {
		if (StringUtils.isBlank(projectName)) {
			return "";
		}
		String[] temps = StringUtils.split(projectName, "_");
		return temps.length > 1 ? temps[0] : projectName;
	}
	
	public String getBeanPackagePrefix() {
		return PackageUtil.getPackageName(packagePrefix, getProjectPrefix());
	}
	
	public String getModuleName(String suffix) {
		String temp = StringUtils.isBlank(projectName) ? "" : projectName;
		String[] temps = StringUtils.split(temp, "_");
		return (temps.length < 2 ? projectName : temps[0]) + "-" + StringUtils.substringBefore(suffix, "/");
	}
	
	public List<String> getModules() {
		List<String> modules = new ArrayList<String>();
		for (String suffix : Config.getSortedModuleSuffixs()) {
			modules.add(getModuleName(suffix));
		}
		return modules;
	}
	
	public String getDestStatisPath(String moduleSuffix) {
		return String.format(Config.getOutResultPath() + "/%s/%s/src/main/webapp/static", projectName,
				getModuleName(moduleSuffix));
	}
	
	public String getDestJspCommonPath(String moduleSuffix) {
		return String.format(Config.getOutResultPath() + "/%s/%s/src/main/webapp/WEB-INF/jsp/common", projectName,
				getModuleName(moduleSuffix));
	}

	public List<ProcessBean> getProcessBeans() {
		return processBeans;
	}

	public void setProcessBeans(List<ProcessBean> processBeans) {
		this.processBeans = processBeans;
	}
	
	public void addProcessBean(ProcessBean processBean) {
		processBeans.add(processBean);
	}
}
