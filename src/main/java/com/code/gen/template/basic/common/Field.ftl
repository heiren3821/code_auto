package ${packagePrefix}.model;

import java.io.Serializable;

import org.apache.commons.lang3.StringUtils;

/**
 * ### auto generate code.
 *
 */
public class Field implements Serializable {

	private static final long serialVersionUID = ${serialId}L;
	private String name;
	
	private String fieldName;
	
	private String value;
	
	private boolean checkNull;
	
	private int maxLength;
	
	public Field() {
	}
	
	public Field(String name,String fieldName, String value, int maxLength) {
		this(name,fieldName, value, true, maxLength);
	}

	public Field(String name,String fieldName, String value, boolean checkNull, int maxLength) {
		this.name = name;
		this.fieldName = fieldName;
		this.value = value;
		this.maxLength = maxLength;
		this.checkNull = checkNull;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	public String getFieldName() {
		return fieldName;
	}

	public void setFieldName(String fieldName) {
		this.fieldName = fieldName;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public boolean isCheckNull() {
		return checkNull;
	}

	public void setCheckNull(boolean checkNull) {
		this.checkNull = checkNull;
	}

	public int getMaxLength() {
		return maxLength;
	}

	public void setMaxLength(int maxLength) {
		this.maxLength = maxLength;
	}
	
	public String validate() {
		if (checkNull && StringUtils.isBlank(value)) {
			return String.format("%s不能为空", name);
		}
		if (maxLength > 0 && StringUtils.length(value) > maxLength) {
			return String.format("%s最大长度不能超过%d", name, maxLength);
		}
		return "";
	}

	@Override
	public String toString() {
		return "Field [name=" + name + ", value=" + value + ", checkNull=" + checkNull + ", maxLength=" + maxLength
				+ "]";
	}
}
