<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:aop="http://www.springframework.org/schema/aop"
	xmlns:context="http://www.springframework.org/schema/context" xmlns:tx="http://www.springframework.org/schema/tx"
	xsi:schemaLocation="
		http://www.springframework.org/schema/aop 
		http://www.springframework.org/schema/aop/spring-aop-4.0.xsd
		http://www.springframework.org/schema/beans 
		http://www.springframework.org/schema/beans/spring-beans-4.0.xsd
		http://www.springframework.org/schema/tx 
		http://www.springframework.org/schema/tx/spring-tx-4.0.xsd
		http://www.springframework.org/schema/context 
		http://www.springframework.org/schema/context/spring-context-4.0.xsd">

	<context:component-scan base-package="${packagePrefix}">
		<context:exclude-filter type="annotation" expression="org.springframework.stereotype.Controller"/>
	</context:component-scan>
	
	<bean class="org.springframework.beans.factory.config.PropertyPlaceholderConfigurer">
        <property name="locations"><list>
            <value>classpath:config.properties</value>
            <value>classpath:config.properties.test</value>
            <value>classpath:config.properties.local</value>
            <value>classpath:config-core.properties</value>
        </list></property>
        <property name="ignoreResourceNotFound" value="true"></property>
    </bean>
    <!-- support file upload -->
    <bean id="multipartResolver" class="org.springframework.web.multipart.commons.CommonsMultipartResolver">
		<!-- one of the properties available; the maximum file size in bytes -->
		<property name="maxUploadSize" value="10240000"/>
		<!-- to handle  MaxUploadSizeExceededException in controller -->
		<property name="resolveLazily" value="true"/> 
	</bean>
	<import resource="classpath*:context_${projectPrefix}_basic.xml"/>
</beans>