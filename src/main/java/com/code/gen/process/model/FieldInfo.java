package com.code.gen.process.model;

import org.apache.commons.lang3.StringUtils;

public class FieldInfo {

	private String fieldName;
	private String columName;
	private String dataType;
	private String columnDataType;
	private String comment;
	private String fieldGetStr;
	private int maxLen;

	public String getFieldName() {
		return fieldName;
	}

	public void setFieldName(String fieldName) {
		this.fieldName = fieldName;
	}
	
	public String getCFieldName() {
		return StringUtils.capitalize(fieldName);
	}

	public String getColumName() {
		return columName;
	}

	public void setColumName(String columName) {
		this.columName = columName;
	}

	public String getDataType() {
		return dataType;
	}

	public void setDataType(String dataType) {
		this.dataType = dataType;
	}
	
	public boolean isDateType() {
		return StringUtils.endsWith(dataType, "Date");
	}

	public String getColumnDataType() {
		return columnDataType;
	}

	public void setColumnDataType(String columnDataType) {
		this.columnDataType = columnDataType;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public String getFieldGetStr() {
		return fieldGetStr;
	}

	public void setFieldGetStr(String fieldGetStr) {
		this.fieldGetStr = fieldGetStr;
	}

	public int getMaxLen() {
		return maxLen;
	}

	public void setMaxLen(int maxLen) {
		this.maxLen = maxLen;
	}
	
	public boolean isOutBean() {
		return !"id".equalsIgnoreCase(fieldName) && StringUtils.endsWith(fieldName, "Id");
	}
	
	public String getOutSideBean() {
		String cFieldName = getCFieldName();
		return isOutBean() ? StringUtils.substring(cFieldName, 0, cFieldName.length() - 2) : "";
	}

	@Override
	public String toString() {
		return "BeanInfo [fieldName=" + fieldName + ", columName=" + columName + ", dataType=" + dataType + ", comment="
				+ comment + ", fieldGetStr=" + fieldGetStr + ", maxLen=" + maxLen + ", toString()=" + super.toString()
				+ "]";
	}
}
