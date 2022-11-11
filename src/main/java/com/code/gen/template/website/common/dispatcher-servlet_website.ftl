<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:mvc="http://www.springframework.org/schema/mvc" xmlns:context="http://www.springframework.org/schema/context"
	xsi:schemaLocation="
	http://www.springframework.org/schema/beans
	http://www.springframework.org/schema/beans/spring-beans-4.0.xsd
	http://www.springframework.org/schema/context 
	http://www.springframework.org/schema/context/spring-context-4.0.xsd
	http://www.springframework.org/schema/mvc  
    http://www.springframework.org/schema/mvc/spring-mvc-4.0.xsd">

	<!-- 指定扫描某些包   -->
	<context:component-scan base-package="${packagePrefix}">
		<context:exclude-filter type="annotation" expression="org.springframework.stereotype.Service"/>
	</context:component-scan>
	
	<mvc:annotation-driven>  
    <mvc:message-converters register-defaults="true">  
        <!-- 避免IE执行AJAX时,返回JSON出现下载文件 -->  
        <bean id="fastJsonHttpMessageConverter" class="com.alibaba.fastjson.support.spring.FastJsonHttpMessageConverter">  
            <property name="supportedMediaTypes" value="application/json;charset=UTF-8" />
			<property name="features">
				<list>
					<value>WriteMapNullValue</value>
					<value>QuoteFieldNames</value>
				</list>
			</property>  
        </bean>  
    </mvc:message-converters>  
	</mvc:annotation-driven>
	
	<mvc:resources location="/static/" mapping="/static/**"/>
	
	<mvc:interceptors>
		<bean id="authCheckInterceptor" class="${packagePrefix}.interceptor.AuthCheckInterceptor"></bean>
	</mvc:interceptors>

	<!-- simple view Resolver. -->
	<bean id="viewResolver" class="org.springframework.web.servlet.view.InternalResourceViewResolver">
    	<property name="prefix" value="/WEB-INF/jsp/"/>
    	<property name="suffix" value=".jsp"/>
	</bean> 

	<!-- 异常处理  -->
	<bean id="exceptionResolver"
		class="org.springframework.web.servlet.handler.SimpleMappingExceptionResolver">
		<property name="defaultErrorView">
			<value>/exception/error</value>
		</property>
		<property name="warnLogCategory">
			<value>WARN</value>
		</property>
		<property name="exceptionMappings">
			<props>
				<prop key="java.sql.SQLException">/exception/error</prop>
				<prop key="org.springframework.web.multipart.MaxUploadSizeExceededException">/exception/error</prop>
			</props>
		</property>
	</bean>

</beans>
