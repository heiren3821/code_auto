package com.code.gen.process;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.math.NumberUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.code.gen.process.configuration.Config;
import com.code.gen.process.model.FieldInfo;
import com.code.gen.process.model.ModuleSuffixConfig;
import com.code.gen.process.model.ProcessBean;
import com.code.gen.process.model.ProjectBean;
import com.code.gen.process.util.PackageUtil;

/**
 * generate project Bean Process.
 * @author chenweixiong
 *
 */
public class ProjectProcessor extends Processor {
	private static Logger logger = LoggerFactory.getLogger(ProjectProcessor.class);
	
	private ProjectBean projectBean;

	private List<String> moduleSuffixs = Config.getSortedModuleSuffixs();
	
	private ProjectProcessor(String suffix) {
		super(suffix);
		this.projectBean = parseProjectBeans();
	}

	public static void handle() {
		ProjectProcessor projectProcessor = new ProjectProcessor("");
		ProjectBean temp = projectProcessor.getProjectBean();
		//1.handle project related template file.
		projectProcessor.process();
		for (ModuleSuffixConfig moduleSuffix : Config.getModuleSuffixs()) {
			String tempSuffix = moduleSuffix.getSuffix();
			ProcessBean defaultBean = new ProcessBean(temp,tempSuffix);
			//3 handel bean.
			if (moduleSuffix.isProcessBean()) {
				for (ProcessBean bean : temp.getProcessBeans()) {
					bean.setProjectBean(temp, tempSuffix);
					projectProcessor.handleModuleSuffix(bean, tempSuffix, false);
				}
				if (temp.getProcessBeans().isEmpty()) {
					projectProcessor.handleModuleSuffix(defaultBean, tempSuffix, true);
				}
			}
			// 4. handle module related template file.
			if (moduleSuffix.isProcessCommon()) {
				projectProcessor.handleModuleSuffix(defaultBean, tempSuffix + "/common", true);
			}
			//5.copy static file.
			if (moduleSuffix.isCopyStatic()) {
				try {
					FileUtils.copyDirectory(new File(PackageUtil.getStaticPath()),
							new File(temp.getDestStatisPath(tempSuffix)));
					FileUtils.copyDirectory(new File(PackageUtil.getFilePath("jsp/common")),
							new File(temp.getDestJspCommonPath(tempSuffix)));
				} catch (Exception e) {
					logger.error("copy file error=" + moduleSuffix, e);
				}
			}
		}
	}

	@Override
	protected Map<String, String> getFileNameParams() {
		Map<String, String> params = super.getFileNameParams();
		params.put("projectPrefix", getProjectBean().getProjectPrefix());
		return super.getFileNameParams();
	}

	@Override
	protected String getStoreParentPath() {
		return PackageUtil.amendFilePath(super.getStoreParentPath(), projectBean.getProjectName());
	}

	@Override
	protected Map<String, Object> getProcessData() {
		Map<String, Object> processData = new HashMap<String, Object>();
		processData.put("packagePrefix", projectBean.getPackagePrefix());
		processData.put("projectPrefix", projectBean.getProjectPrefix());
		processData.put("modules", projectBean.getModules());
		processData.put("projectName", projectBean.getProjectName());
		processData.put("processBeans", projectBean.getProcessBeans());
		return processData;
	}
	
	public void handleModuleSuffix(ProcessBean bean, String suffix, boolean other) {
		BeanProcessor codeProcessor = new BeanProcessor(suffix, other);
		bean.setProjectBean(projectBean, suffix);
		codeProcessor.setBean(bean);
		codeProcessor.process();
	}
	
	private ProjectBean parseProjectBeans() {
		File file = new File(Config.getCodeDefPath());
		BufferedReader br = null;
		String s = "";
		ProjectBean projectBean = new ProjectBean();
		List<ProcessBean> processBeans = new ArrayList<ProcessBean>();
		try {
			ProcessBean bean = null;
			br = new BufferedReader(new InputStreamReader(new FileInputStream(file), "UTF8"));
			while ((s = br.readLine()) != null) {
				if (PackageUtil.isCommentLine(s)) {
					continue;
				} else if (PackageUtil.isProjectLine(s)) {
					if (StringUtils.isBlank(projectBean.getProjectName())) {
						projectBean = filleProject(s);
					}
				} else if (PackageUtil.isBeanLine(s)) {
					if (bean != null) {
						processBeans.add(bean);
						bean = null;
					}
					bean = genBean(s);
					if (StringUtils.isBlank(bean.getBeanName())) {
						continue;
					}
				} else if (PackageUtil.isFieldLine(s)) {
					if (bean == null) {
						continue;
					}
					bean.addFiledInfo(genFieldInfo(s, bean.getBeanNick()));
				}
			}
			if (bean != null) {
				processBeans.add(bean);
			}
		} catch (Exception e) {
			logger.error("met exception error", e);
		} finally {
			try {
				br.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		projectBean.setProcessBeans(processBeans);
		return projectBean;
	}
	
	private ProjectBean filleProject(String s) {
		ProjectBean projectBean = new ProjectBean();
		if (!PackageUtil.isProjectLine(s)) {
			return projectBean;
		}
		String[] temps = StringUtils.split(StringUtils.substring(s, 1, s.length()), ",");
		if (temps.length != 3) {
			return projectBean;
		}
		projectBean.setProjectName(temps[0]);
		projectBean.setPackagePrefix(temps[1]);
		projectBean.setProjectDesc(temps[2]);
		return projectBean;
	}
	
	private ProcessBean genBean(String s) {
		ProcessBean bean = new ProcessBean();
		if (!PackageUtil.isBeanLine(s)) {
			return null;
		}
		String[] temps = StringUtils.split(StringUtils.substring(s, 1, s.length()), ",");
		if (temps.length != 5) {
			return null;
		}
		// packageSuffix
		bean.setPackageSuffix(isIgnoreSuffix(temps[0])?"":temps[0]);
		// Bean name.
		bean.setBeanName(temps[1]);
		// table name.
		bean.setTableName(temps[2]);
		//menu name.
		bean.setMenuName(temps[3]);
		//table comment
		bean.setTableComment(temps[4]);
		return bean;
	}
	
	private boolean isIgnoreSuffix(String suffix) {
		String ignore = "_";
		if(StringUtils.isBlank(suffix)) {
			return true;
		}
		return PackageUtil.contain(ignore, suffix);
	}
	
	private FieldInfo genFieldInfo(String s, String beanNick) {
		FieldInfo field = new FieldInfo();
		if (!PackageUtil.isFieldLine(s)) {
			return field;
		}
		String[] temps = StringUtils.split(StringUtils.substring(s, 1, s.length()), ",");
		if (temps.length != 6) {
			return field;
		}
		// fieldName
		field.setFieldName(temps[0]);
		// column
		field.setColumName(temps[1]);
		// dataType
		field.setDataType(temps[2]);
		// columnDataType
		field.setColumnDataType(temps[3]);
		// comment
		field.setComment(temps[4]);
		// max length
		field.setMaxLen(NumberUtils.toInt(temps[5]));
		field.setFieldGetStr(String.format("%s.get%s()", beanNick, StringUtils.capitalize(field.getFieldName())));
		return field;
	}

	public ProjectBean getProjectBean() {
		return projectBean;
	}

	public void setProjectBean(ProjectBean projectBean) {
		this.projectBean = projectBean;
	}

	public List<String> getModuleSuffixs() {
		return moduleSuffixs;
	}

	public void setModuleSuffixs(List<String> moduleSuffixs) {
		this.moduleSuffixs = moduleSuffixs;
	}
}
