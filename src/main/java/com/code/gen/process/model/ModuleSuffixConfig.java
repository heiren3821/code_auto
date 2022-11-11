package com.code.gen.process.model;

import java.io.File;

import com.code.gen.process.configuration.Config;

public class ModuleSuffixConfig {

	private String suffix;
	
	private boolean processBean;
	
	private boolean copyStatic;
	
	public ModuleSuffixConfig() {
	}
	
	public ModuleSuffixConfig(String suffix, boolean processBean, boolean copyStatic) {
		this.suffix = suffix;
		this.processBean = processBean;
		this.copyStatic = copyStatic;
	}

	public String getSuffix() {
		return suffix;
	}

	public void setSuffix(String suffix) {
		this.suffix = suffix;
	}

	public boolean isProcessBean() {
		return processBean;
	}

	public void setProcessBean(boolean processBean) {
		this.processBean = processBean;
	}

	public boolean isCopyStatic() {
		return copyStatic;
	}

	public void setCopyStatic(boolean copyStatic) {
		this.copyStatic = copyStatic;
	}
	
	public boolean isProcessCommon() {
		return new File(Config.getTemplatePath(suffix) + "/common").exists();
	}

	@Override
	public String toString() {
		return "ModuleSuffixConfig [suffix=" + suffix + ", processBean=" + processBean + ", copyStatic=" + copyStatic
				+ "]";
	}
}
