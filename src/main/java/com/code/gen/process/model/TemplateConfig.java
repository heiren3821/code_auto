package com.code.gen.process.model;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.apache.commons.lang3.StringUtils;

public class TemplateConfig {

	private String templateName = "";
	private String fileName = "";
	private String path = "";
	private List<String> modules =new ArrayList<String>();
	
	public TemplateConfig() {
		
	}
	
	public TemplateConfig(String templateName, String fileName, String path, String modules) {
		this.templateName = templateName;
		this.fileName = fileName;
		this.path = path;
		if (StringUtils.isNotBlank(modules)) {
			this.modules = Arrays.asList(StringUtils.split(modules, ","));
		}
	}
	public String getTemplateName() {
		return templateName;
	}
	public void setTemplateName(String templateName) {
		this.templateName = templateName;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public List<String> getModules() {
		return modules;
	}
	public void setModules(List<String> modules) {
		this.modules = modules;
	}
	
	public boolean contain(String module) {
		return modules.contains(module);
	}
	@Override
	public String toString() {
		return "TemplateConfig [templateName=" + templateName + ", fileName=" + fileName + ", path=" + path
				+ ", modules=" + modules + "]";
	}
}
