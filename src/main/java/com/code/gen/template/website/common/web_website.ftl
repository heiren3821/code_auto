<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns="http://java.sun.com/xml/ns/javaee"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://java.sun.com/xml/ns/javaee
                      http://java.sun.com/xml/ns/javaee/web-app_3_0.xsd"
  version="3.0"
  metadata-complete="true">

	<display-name>${moduleName}</display-name>

	<context-param>
		<param-name>webAppRootKey</param-name>
		<param-value>${moduleName}</param-value>
	</context-param>

	<!-- context -->
	<context-param>
		<param-name>contextConfigLocation</param-name>
		<param-value>
			classpath*:springContext_${projectPrefix}_website.xml
		</param-value>
	</context-param>

	<listener>
		<listener-class>org.springframework.web.context.ContextLoaderListener</listener-class>
	</listener>

	<!-- Filter -->
	<!-- Spring 字符编码 Filter -->
	<filter>
		<filter-name>encodingFilter</filter-name>
		<filter-class>org.springframework.web.filter.CharacterEncodingFilter</filter-class>
		<init-param>
			<param-name>encoding</param-name>
			<param-value>UTF-8</param-value>
		</init-param>
	</filter>

	<!-- Xss处理Filter -->
	<filter>
		<filter-name>xssFilter</filter-name>
		<filter-class>${packagePrefix}.common.web.filter.XssFilter</filter-class>
		<init-param>
			<param-name>noFilterUrl</param-name>
			<param-value>/client/status.htm,/client/redirect.htm</param-value>
		</init-param>
	</filter>

	<!-- filter-mapping -->
	<filter-mapping>
		<filter-name>xssFilter</filter-name>
		<url-pattern>/*</url-pattern>
	</filter-mapping>

	<!-- servlet -->
	<!-- springMVC Controller -->
	<servlet>
		<servlet-name>dispatcher</servlet-name>
		<servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
		<load-on-startup>1</load-on-startup>
	</servlet>

	<!-- servlet-mapping -->
	<servlet-mapping>
		<servlet-name>dispatcher</servlet-name>
		<url-pattern>/</url-pattern>
	</servlet-mapping>
	
	<servlet-mapping>
		<servlet-name>dispatcher</servlet-name>
		<url-pattern></url-pattern>
	</servlet-mapping>
	
	<!-- 设置session失效时间 -->
	<session-config>
		<session-timeout>1440</session-timeout>
	</session-config>

	<welcome-file-list>
		<welcome-file>index.htm</welcome-file>
	</welcome-file-list>

	<error-page>
		<error-code>500</error-code>
		<location>/error500.htm</location>
	</error-page>
	<error-page>
		<error-code>400</error-code>
		<location>/error400.htm</location>
	</error-page>
	<error-page>
		<error-code>403</error-code>
		<location>/error403.htm</location>
	</error-page>
	<error-page>
		<error-code>404</error-code>
		<location>/error404.htm</location>
	</error-page>

</web-app>