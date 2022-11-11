package com.code.gen.process.model;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;

import com.code.gen.process.util.PackageUtil;

public class ProcessBean {
	
	private ProjectBean projectBean;
	private String moduleName;
	private String packageSuffix;
	private String storeParentPath;
	private String beanName;
	private String tableName;
	private String menuName;
	private String tableComment;
	private List<FieldInfo> fields = new ArrayList<FieldInfo>();
	private List<String> excludesFields = PackageUtil.getExcludeFields();
	
	public ProcessBean() {
	}
	
	public ProcessBean(ProjectBean projectBean, String suffix) {
		setProjectBean(projectBean, suffix);
	}

	public void setProjectBean(ProjectBean projectBean, String suffix) {
		this.projectBean = projectBean;
		this.moduleName = projectBean.getModuleName(suffix);
	}
	
	public String getPackageSuffix() {
		return packageSuffix;
	}

	public void setPackageSuffix(String packageSuffix) {
		if (StringUtils.isBlank(packageSuffix)) {
			this.packageSuffix = "";
		} else {
			this.packageSuffix = (StringUtils.startsWith(packageSuffix, ".") ? "" : ".") + packageSuffix;
		}
	}
	public String getBeanName() {
		return beanName;
	}
	
	public String getBeanLowName() {
		return StringUtils.isBlank(beanName) ? "" : beanName.toLowerCase();
	}
	public void setBeanName(String beanName) {
		this.beanName = beanName;
	}
	
	public String getTableName() {
		return tableName;
	}
	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	public List<FieldInfo> getFields() {
		return fields;
	}

	public void setFields(List<FieldInfo> fields) {
		this.fields = fields;
	}
	
	public List<String> getOutBeans() {
		List<String> beanNames = new ArrayList<String>();
		for (FieldInfo field : fields) {
			if (field.isOutBean()) {
				beanNames.add(field.getOutSideBean());
			}
		}
		return beanNames;
	}

	public String getMenuName() {
		return menuName;
	}
	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}
	public void addFiledInfo(FieldInfo fieldInfo) {
		if(StringUtils.isNotBlank(fieldInfo.getFieldName())) {
			fields.add(fieldInfo);
		}
	}
	
	public List<String> getExcludesFields() {
		return excludesFields;
	}
	public void setExcludesFields(List<String> excludesFields) {
		this.excludesFields = excludesFields;
	}
	
	public String getProjectName() {
		return projectBean==null?"":projectBean.getProjectName();
	}
	
	public String getProjectPrefix() {
		if (StringUtils.isBlank(getProjectName())) {
			return "";
		}
		String[] temps = StringUtils.split(getProjectName(), "_");
		return temps.length > 1 ? temps[0] : getProjectName();
	}
	
	public String getPackagePrefix() {
		return projectBean == null ? "" : projectBean.getPackagePrefix();
	}

	public String getModuleName() {
		return moduleName;
	}
	public void setModuleName(String moduleName) {
		this.moduleName = moduleName;
	}
	
	public String getStoreParentPath() {
		return storeParentPath;
	}
	public void setStoreParentPath(String storeParentPath) {
		this.storeParentPath = storeParentPath;
	}
	
	public String getTableComment() {
		return tableComment;
	}
	public void setTableComment(String tableComment) {
		this.tableComment = tableComment;
	}

	public String getBeanNick() {
		if (StringUtils.isBlank(beanName)) {
			return "";
		}
		return StringUtils.substring(beanName, 0, 1).toLowerCase()
				+ StringUtils.substring(beanName, 1, beanName.length());
	}

	public boolean hasDateType() {
		for (FieldInfo fieldInfo : fields) {
			if(excludesFields.contains(fieldInfo.getFieldName())) {
				continue;
			}
			if (fieldInfo.isDateType()) {
				return true;
			}
		}
		return false;
	}
	
	public List<String> getModules() {
		return projectBean == null ? new ArrayList<String>() : projectBean.getModules();
	}

	public List<ProcessBean> getProcessBeans() {
		return projectBean == null ? new ArrayList<ProcessBean>() : projectBean.getProcessBeans();
	}
	
	public String getProjectDesc() {
		return projectBean == null ? "" : projectBean.getProjectDesc();
	}
}
