package com.code.gen.process.configuration;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;

import com.code.gen.process.model.ModuleSuffixConfig;
import com.code.gen.process.model.TemplateConfig;
import com.code.gen.process.util.PackageUtil;

public class Config {

	private static List<TemplateConfig> templates = new ArrayList<TemplateConfig>();
	private static List<ModuleSuffixConfig> moduleSuffixs =new ArrayList<ModuleSuffixConfig>();
	private static String DEFAULT_TEMPLATE_NAME = "BeanInfo.txt";
	private static String defFileName = DEFAULT_TEMPLATE_NAME;
	
	static {
		moduleSuffixs.add(new ModuleSuffixConfig("parent",true,false));
		moduleSuffixs.add(new ModuleSuffixConfig("basic",true,false));
		moduleSuffixs.add(new ModuleSuffixConfig("website",true,true));
		
		// ##### basic#####
		templates.add(new TemplateConfig("Dao.ftl", "{{beanName}}Dao.java",
				"src/main/java/{{packagePrefix}}/dao{{packageSuffix}}", "basic"));
		templates.add(new TemplateConfig("hibernate.ftl", "{{beanName}}.hbm.xml",
				"src/main/resources/mappings", "basic"));
		templates.add(new TemplateConfig("Model.ftl", "{{beanName}}.java",
				"src/main/java/{{packagePrefix}}/model{{packageSuffix}}", "basic"));
		templates.add(new TemplateConfig("Service.ftl", "{{beanName}}Service.java",
				"src/main/java/{{packagePrefix}}/service{{packageSuffix}}", "basic"));

		/// #######basic other ############
		templates.add(new TemplateConfig("pom_basic.ftl", "pom.xml", "", "other_basic"));
		templates.add(new TemplateConfig("basic_redis.ftl", "{{projectPrefix}}_basic_redis.xml", "src/main/resources",
				"other_basic"));
		templates.add(new TemplateConfig("context_basic.ftl", "context_{{projectPrefix}}_basic.xml",
				"src/main/resources", "other_basic"));
		templates.add(new TemplateConfig("LoggerStartupListener.ftl", "LoggerStartupListener.java",
				"src/main/java/{{packagePrefix}}/common", "other_basic"));
		templates.add(new TemplateConfig("HttpClientUtil.ftl", "HttpClientUtil.java",
				"src/main/java/{{packagePrefix}}/common/util", "other_basic"));
		templates.add(new TemplateConfig("IpUtil.ftl", "IpUtil.java", "src/main/java/{{packagePrefix}}/common/util",
				"other_basic"));
		templates.add(new TemplateConfig("PropertyUtil.ftl", "PropertyUtil.java", "src/main/java/{{packagePrefix}}/common/util",
				"other_basic"));
		templates.add(new TemplateConfig("StringUtil.ftl", "StringUtil.java", "src/main/java/{{packagePrefix}}/common/util",
				"other_basic"));
		templates.add(new TemplateConfig("DateUtil.ftl", "DateUtil.java", "src/main/java/{{packagePrefix}}/common/util",
				"other_basic"));
		templates.add(new TemplateConfig("CheckHeartAction.ftl", "CheckHeartAction.java", "src/main/java/{{packagePrefix}}/common/web/action",
				"other_basic"));
		templates.add(new TemplateConfig("ErrorAction.ftl", "ErrorAction.java", "src/main/java/{{packagePrefix}}/common/web/action",
				"other_basic"));
		templates.add(new TemplateConfig("XssFilter.ftl", "XssFilter.java", "src/main/java/{{packagePrefix}}/common/web/filter",
				"other_basic"));
		templates.add(new TemplateConfig("XssHttpServletRequestWrapper.ftl", "XssHttpServletRequestWrapper.java", "src/main/java/{{packagePrefix}}/common/web/filter",
				"other_basic"));
		templates.add(new TemplateConfig("CommonPropertyPlaceholderConfigurer.ftl", "CommonPropertyPlaceholderConfigurer.java", "src/main/java/{{packagePrefix}}/common/config",
				"other_basic"));
		templates.add(new TemplateConfig("GenericDao.ftl", "GenericDao.java", "src/main/java/{{packagePrefix}}/dao",
				"other_basic"));
		templates.add(new TemplateConfig("GenericDaoHibernateImpl.ftl", "GenericDaoHibernateImpl.java", "src/main/java/{{packagePrefix}}/dao",
				"other_basic"));
		templates.add(new TemplateConfig("MainDaoBase.ftl", "MainDaoBase.java", "src/main/java/{{packagePrefix}}/dao",
				"other_basic"));
		templates.add(new TemplateConfig("Constants.ftl", "Constants.java", "src/main/java/{{packagePrefix}}/common",
				"other_basic"));
		templates.add(new TemplateConfig("Field.ftl", "Field.java", "src/main/java/{{packagePrefix}}/model",
				"other_basic"));
		templates.add(new TemplateConfig("Entity.ftl", "Entity.java", "src/main/java/{{packagePrefix}}/model",
				"other_basic"));
		templates.add(new TemplateConfig("IntegerEntity.ftl", "IntegerEntity.java", "src/main/java/{{packagePrefix}}/model",
				"other_basic"));
		templates.add(new TemplateConfig("Pagination.ftl", "Pagination.java", "src/main/java/{{packagePrefix}}/model",
				"other_basic"));
		templates.add(new TemplateConfig("CacheService.ftl", "CacheService.java", "src/main/java/{{packagePrefix}}/service",
				"other_basic"));
		templates.add(new TemplateConfig("CacheClient.ftl", "CacheClient.java", "src/main/java/{{packagePrefix}}/service/cache",
				"other_basic"));
		templates.add(new TemplateConfig("MemoryClient.ftl", "MemoryClient.java", "src/main/java/{{packagePrefix}}/service/cache",
				"other_basic"));
		templates.add(new TemplateConfig("RedisClient.ftl", "RedisClient.java", "src/main/java/{{packagePrefix}}/service/cache",
				"other_basic"));
		templates.add(new TemplateConfig("SecrityTag.ftl", "SecrityTag.java", "src/main/java/{{packagePrefix}}/tld",
				"other_basic"));
		templates.add(new TemplateConfig("Role.ftl", "RoleEnum.java", "src/main/java/{{packagePrefix}}/enums",
				"other_basic"));
		//########## other basic end ######
		// ###  website ######
		templates.add(new TemplateConfig("Controller.ftl", "{{beanName}}Controller.java",
				"src/main/java/{{packagePrefix}}.controller{{packageSuffix}}", "website"));
		///#### other website ############
		templates.add(new TemplateConfig("pom_website.ftl", "pom.xml", "","other_website"));
		templates.add(new TemplateConfig("dispatcher-servlet_website.ftl", "dispatcher-servlet.xml", "src/main/webapp/WEB-INF",
				"other_website"));
		templates.add(new TemplateConfig("web_website.ftl", "web.xml", "src/main/webapp/WEB-INF",
				"other_website"));
		templates.add(new TemplateConfig("logback_website.ftl", "logback.xml", "src/main/resources",
				"other_website"));
		templates.add(new TemplateConfig("config_properties.ftl", "config.properties", "src/main/resources",
				"other_website"));
		templates.add(new TemplateConfig("config_properties_local.ftl", "config.properties.local", "src/main/resources",
				"other_website"));
		templates.add(new TemplateConfig("springContext_website.ftl", "springContext_{{projectPrefix}}_website.xml", "src/main/resources",
				"other_website"));
		templates
				.add(new TemplateConfig("left.ftl", "left.jsp", "src/main/webapp/WEB-INF/jsp/common", "other_website"));
		templates
				.add(new TemplateConfig("list.ftl", "list.jsp", "src/main/webapp/WEB-INF/jsp/common", "other_website"));
		templates
				.add(new TemplateConfig("load.ftl", "load.jsp", "src/main/webapp/WEB-INF/jsp/common", "other_website"));
		templates.add(new TemplateConfig("pagination.ftl", "pagination.jsp", "src/main/webapp/WEB-INF/jsp/common",
				"other_website"));
		templates.add(new TemplateConfig("dashboard.ftl", "dashboard.jsp", "src/main/webapp/WEB-INF/jsp",
				"other_website"));
		templates.add(new TemplateConfig("login.ftl", "login.jsp", "src/main/webapp/WEB-INF/jsp",
				"other_website"));
		templates.add(new TemplateConfig("authError.ftl", "authError.jsp", "src/main/webapp/WEB-INF/jsp",
				"other_website"));
		templates.add(new TemplateConfig("sec.ftl", "sec.tld", "src/main/webapp/WEB-INF/tld",
				"other_website"));
		templates.add(new TemplateConfig("navbar.ftl", "navbar.jsp", "src/main/webapp/WEB-INF/jsp/common",
				"other_website"));
		templates.add(new TemplateConfig("BaseController.ftl", "BaseController.java", "src/main/java/{{packagePrefix}}/controller",
				"other_website"));
		templates.add(new TemplateConfig("BaseManageController.ftl", "BaseManageController.java", "src/main/java/{{packagePrefix}}/controller",
				"other_website"));
		templates.add(new TemplateConfig("AuthCheckInterceptor.ftl", "AuthCheckInterceptor.java", "src/main/java/{{packagePrefix}}/interceptor",
				"other_website"));
		templates.add(new TemplateConfig("ServletUtils.ftl", "ServletUtils.java", "src/main/java/{{packagePrefix}}/util",
				"other_website"));
		templates.add(new TemplateConfig("SsoController.ftl", "SsoController.java", "src/main/java/{{packagePrefix}}/controller",
				"other_website"));
		templates.add(new TemplateConfig("CacheController.ftl", "CacheController.java", "src/main/java/{{packagePrefix}}/controller",
				"other_website"));
		///#### parent ############
		templates.add(new TemplateConfig("pom_parent.ftl", "pom.xml", "", "parent"));
		templates.add(new TemplateConfig("table.ftl", "table.sql", "", "parent"));
		//######project ##########
		templates.add(new TemplateConfig("pom_project.ftl", "pom.xml", "", "other"));
	}
	
	private static TemplateConfig getTemplateByName(String template) {
		for(TemplateConfig config :templates) {
			if(StringUtils.equals(template, config.getTemplateName())) {
				return config;
			}
		}
		return new TemplateConfig();
	}
    
    public static String getFileName(String template) {
    	return getTemplateByName(template).getFileName();
    }
    
    public static String getFileStorePath(String template) {
    	return getTemplateByName(template).getPath();
    }
    
	public static String getTemplatePath(String suffix) {
		return PackageUtil.getFilePath("src/main/java/com/code/gen/template/" + suffix);
	}
	
	public static String getOutResultPath() {
		return PackageUtil.getFilePath("output/");
	}
	
	public static List<ModuleSuffixConfig> getModuleSuffixs() {
		return moduleSuffixs;
	}

	public static List<String> getTemplatesByModule(String suffix) {
		List<String> temps = new ArrayList<String>();
		for (TemplateConfig config : templates) {
			if (config.contain(suffix)) {
				temps.add(config.getTemplateName());
			}
		}
		return temps;
	}

	public static List<String> getOtherTemplatesByModule(String suffix) {
		String key = "other" + (StringUtils.isBlank(suffix) ? "" : "_" + suffix);
		return getTemplatesByModule(key);
	}
	
	public static String getCodeDefPath() {
		return PackageUtil.getFilePath("src/main/java/com/code/gen/def/" + getDefFileName());
	}
	
	public static String getStartComment() {
		return "#";
	}
	
	public static String getStartProject() {
		return "1";
	}
	
	public static String getStartBean() {
		return "2";
	}
	
	public static String getStartField() {
		return "3";
	}

	public static String getDefFileName() {
		return StringUtils.isBlank(defFileName) ? DEFAULT_TEMPLATE_NAME : defFileName;
	}

	public static void setDefFileName(String defFileName) {
		Config.defFileName = defFileName;
	}
	
	public static List<String> getSortedModuleSuffixs() {
		List<String> sortSuffixs = new ArrayList<String>();
		for (ModuleSuffixConfig config : moduleSuffixs) {
			sortSuffixs.add(config.getSuffix());
		}
		return sortSuffixs;
	}
}
