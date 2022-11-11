package com.code.gen.process;

import java.io.File;
import java.io.FileWriter;
import java.io.Writer;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.code.gen.process.configuration.Config;
import com.code.gen.process.util.PackageUtil;

import freemarker.cache.FileTemplateLoader;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateExceptionHandler;
import freemarker.template.Version;

public class Processor {
	protected Logger logger = LoggerFactory.getLogger(BeanProcessor.class);
	private Configuration cfg = new Configuration(new Version(2, 3, 23));
	private String suffix = "";
	private boolean other;

	public Processor(String suffix) {
		this(suffix, false);
	}
	
	public Processor(String suffixPath, boolean other) {
		this.suffix = StringUtils.substringBefore(suffixPath, "/");
		this.other = other;
		cfg = new Configuration(new Version(2, 3, 23));
		cfg.setDefaultEncoding("UTF-8");
		cfg.setLocale(Locale.CHINA);
		cfg.setTemplateExceptionHandler(TemplateExceptionHandler.RETHROW_HANDLER);
		try {
			cfg.setTemplateLoader(new FileTemplateLoader(new File(Config.getTemplatePath(suffixPath))));
		} catch (Exception e) {
			logger.error("load template loader error", e);
		}
	}

	private String getModuleKey() {
		return (other ? "other_" : "") + (StringUtils.isBlank(suffix) ? "other" : suffix);
	}
	
	public void process() {
		for (String templateName :Config.getTemplatesByModule(getModuleKey())) {
			Writer fileWriter = null;
			try {
				Template template = cfg.getTemplate(templateName);
				File file = new File(getDestFileName(templateName));
				File parent = file.getParentFile();
				if (!parent.exists()) {
					parent.mkdirs();
					file.createNewFile();
				}
				fileWriter = new FileWriter(file);
				template.process(getProcessData(), fileWriter);
				fileWriter.flush();
			} catch (Exception e) {
				logger.error("convert File met error", e);
			}
		}
	}
	
	private String getDestFileName(String template) {
		String[] temps = StringUtils.split(template, ".");
		if (temps.length != 2) {
			return PackageUtil.amendFilePath(getStoreParentPath(), template);
		}
		return PackageUtil.amendFilePath(getStoreParentPath(), getStorePath(template),
				PackageUtil.template(Config.getFileName(template), getFileNameParams()));
	}

	protected Map<String, String> getFileNameParams() {
		return new HashMap<String, String>();
	}
	
	protected String getStoreParentPath() {
		return Config.getOutResultPath();
	}
	
	protected Map<String, String> getStoreParams() {
		return new HashMap<String, String>();
	}
	
	private String getStorePath(String template) {
		return PackageUtil.getPackagePath(PackageUtil.template(Config.getFileStorePath(template), getStoreParams()));
	}
	
	protected Map<String, Object> getProcessData() {
		return new HashMap<String, Object>();
	}

	public Configuration getCfg() {
		return cfg;
	}

	public void setCfg(Configuration cfg) {
		this.cfg = cfg;
	}

}
