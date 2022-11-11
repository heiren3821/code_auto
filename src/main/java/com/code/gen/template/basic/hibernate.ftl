<?xml version="1.0"?>
<!DOCTYPE hibernate-mapping SYSTEM
    "classpath://org/hibernate/hibernate-mapping-3.0.dtd">

<hibernate-mapping>
	<class name="${packagePrefix}.model${packageSuffix}.${beanName}" table="${tableName}">
		<id name="id" column="id" type="java.lang.Integer">
			<generator class="native" />
		</id>
		<#list fields as bean>
		<#if bean.fieldName != "id">
 		<property name="${bean.fieldName}" >
			<column name="${bean.columName}"></column>
		</property>
		</#if>
       </#list>
	</class>
</hibernate-mapping>