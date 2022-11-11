package com.code.gen.process.util;

import java.io.File;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;

import com.code.gen.process.configuration.Config;

public class PackageUtil {
	
	public static boolean isEndPackage(String packagePrefix) {
		return !StringUtils.endsWith(packagePrefix, ".");
	}

	public static String getPackageName(String packagePrefix, String project) {
		String tempPrefix = StringUtils.isBlank(packagePrefix) ? "com" : packagePrefix;
		return (tempPrefix + (isEndPackage(tempPrefix) ? ("." + project) : "")).toLowerCase();
	}
	
	public static String getBasePath() {
		File file = new File("");
		return file.getAbsolutePath();
	}
	
	public static String getFilePath(String tempPath) {
		return getBasePath() + "/" + tempPath;
	}
	
	public static String getPackagePath(String packageName) {
		String javaName = StringUtils.substringAfterLast(packageName, ".");
		String path = StringUtils.substringBeforeLast(packageName, ".");
		if (StringUtils.isNotBlank(javaName)) {
			if (!Character.isUpperCase(path.charAt(0))) {
				return StringUtils.replace(packageName, ".", "/");
			}
		}
		return StringUtils.replace(path, ".", "/");
	}
	
	public static String template(String template, Map<String, String> params) {
		String temp = template;
		for (Map.Entry<String, String> entry : params.entrySet()) {
			temp = StringUtils.replace(temp, "{{" + entry.getKey() + "}}", entry.getValue());
		}
		return temp;
	}
	
	public static boolean contain(String value, String sub) {
		return StringUtils.contains("," + value + ",", "," + StringUtils.trim(sub) + ",");
	}
	
	public static boolean isCommentLine(String s) {
		return StringUtils.startsWith(s, Config.getStartComment());
	}
	
	public static boolean isProjectLine(String s) {
		return StringUtils.startsWith(s, Config.getStartProject());
	}
	
	public static boolean isBeanLine(String s) {
		return StringUtils.startsWith(s, Config.getStartBean());
	}
	
	public static boolean isFieldLine(String s) {
		return StringUtils.startsWith(s, Config.getStartField());
	}
	
	public static List<String> getExcludeFields() {
		return Arrays
				.asList(new String[] { "id", "active", "remark", "createBy", "createTime", "updateBy", "updateTime" });
	}
	
	public static String amendFilePath(String...paths) {
		StringBuilder sb = new StringBuilder();
		for(String path :paths) {
			sb.append(path).append(File.separator);
		}
		return sb.toString();
	}
	
	public static String getStaticPath() {
		return getFilePath("static");
	}
	
	public static String getJspCommonPath() {
		return getFilePath("jsp/common");
	}
}
