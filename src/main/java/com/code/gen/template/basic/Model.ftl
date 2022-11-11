package ${packagePrefix}.model${packageSuffix};

import java.util.ArrayList;
import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
<#if beanName?lower_case?ends_with("userinfo")>
import org.apache.commons.lang3.StringUtils;
</#if>
import org.apache.commons.lang3.math.NumberUtils;

import ${packagePrefix}.model.IntegerEntity;
import ${packagePrefix}.model.Field;
<#list outBeans as outBean>
import ${packagePrefix}.model.${outBean};
</#list>
import ${packagePrefix}.common.util.StringUtil;
<#if beanName?lower_case?ends_with("userinfo")>
import ${packagePrefix}.enums.RoleEnum;
</#if>


<#if hasDate>
import java.util.Date;
</#if>

/**
 *### auto generate code.
 *
 */
public class ${beanName} extends IntegerEntity {

	private static final long serialVersionUID = ${serialId}L;
	
	public ${beanName}() {
	}

	public ${beanName}(int id) {
		setId(id);
	}
	
	<#list fields as bean>
	<#if !excludesFields?seq_contains(bean.fieldName)>
 	
 	<#if bean.outBean>
 	private ${bean.outSideBean} ${bean.outSideBean?uncap_first};
 	<#else>
 	private ${bean.dataType} ${bean.fieldName};
 	</#if>
 	</#if>
    </#list>
    
    <#if beanName?lower_case?ends_with("userinfo")>
    private boolean rememberMe;
    </#if>
    
    @JSONField(serialize = false)
    public String getMenuName() {
    	return "${menuName}";
    }
    
    @JSONField(serialize = false)
    public String getBaseName() {
    	return "${menuName?replace('管理','')}";
    }

	<#list fields as bean>
	<#if !excludesFields?seq_contains(bean.fieldName)>
	<#if bean.outBean>
	public ${bean.dataType} get${bean.fieldName?cap_first}() {
		return ${bean.outSideBean?uncap_first}==null? 0: ${bean.outSideBean?uncap_first}.getId();
	}

	public void set${bean.fieldName?cap_first}(${bean.dataType} ${bean.fieldName}) {
		this.${bean.outSideBean?uncap_first} = new ${bean.outSideBean}(${bean.fieldName});
	}
	
	@JSONField(serialize = false)
	public ${bean.outSideBean} get${bean.outSideBean}() {
		return ${bean.outSideBean?uncap_first};
	}

	public void set${bean.outSideBean}(${bean.outSideBean} ${bean.outSideBean?uncap_first}) {
		this.${bean.outSideBean?uncap_first} = ${bean.outSideBean?uncap_first};
	}
	<#else>
    public ${bean.dataType} get${bean.fieldName?cap_first}() {
		return ${bean.fieldName};
	}

	public void set${bean.fieldName?cap_first}(${bean.dataType} ${bean.fieldName}) {
		this.${bean.fieldName} = ${bean.fieldName};
	}
	</#if>
	</#if>
   </#list>
   
   @JSONField(serialize = false)
   public List<Field> getFields() {
   		List<Field> fields = new ArrayList<Field>();
   	 	<#list fields as bean>
   	 	<#if !excludesFields?seq_contains(bean.fieldName)>
   	 	fields.add(new Field("${bean.comment}","${bean.fieldName}", StringUtil.valueOf(get${bean.fieldName?cap_first}()),${(!(beanName?lower_case?ends_with("remark")))?c}, ${bean.maxLen?c}));
   		</#if>
   		</#list>
   		return fields;
   }
   
   <#if beanName?lower_case?ends_with("userinfo")>
   @JSONField(serialize = false)
	public String getRoleNames() {
		StringBuffer sb = new StringBuffer();
		for (String role : StringUtils.split(roles, ",")) {
			sb.append(RoleEnum.valueOf(NumberUtils.toInt(role)).name()).append(",");
		}
		return sb.length() > 0 ? sb.substring(0, sb.length() - 1) : "";
	}
	
	@JSONField(serialize = false)
	public boolean isAdmin() {
		for (String role : StringUtils.split(roles, ",")) {
			if (RoleEnum.valueOf(NumberUtils.toInt(role)).isAdmin()) {
				return true;
			}
		}
		return false;
	}
	
	public void setRole(RoleEnum role) {
		setRoles((StringUtils.isBlank(roles) ? "" : roles + ",")
				+ role.getCode());
	}
	
	public boolean isRememberMe() {
		return rememberMe;
	}

	public void setRememberMe(boolean rememberMe) {
		this.rememberMe = rememberMe;
	}
   </#if>
   
	@Override
	public String toString() {
		return "${beanName} ["
		<#list fields as bean>
		<#if !excludesFields?seq_contains(bean.fieldName)>
		  + "${bean.fieldName}=" + <#if bean.outBean>get${bean.fieldName?cap_first}()<#else>${bean.fieldName}</#if>+","
		</#if>
		</#list>
		+ " toString()=" + super.toString() + "]";
	}
}
