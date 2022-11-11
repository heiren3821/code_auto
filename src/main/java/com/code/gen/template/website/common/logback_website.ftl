<?xml version="1.0" encoding="UTF-8"?>
<configuration scan="false" scanPeriod="60 seconds" debug="false">
    <contextListener class="${packagePrefix}.common.LoggerStartupListener"/>
	<contextName>${moduleName}</contextName>
	<property name="char_set" value="UTF-8" />
	<property name="log_dir" value="${r'$'}{catalina.home}/logs" />
	<property name="dc_dir" value="${r'$'}{catalina.home}/logs" />

	<appender name="STDOUT" class="ch.qos.logback.core.ConsoleAppender">  
        <encoder>   
	    	<pattern>%d{HH:mm:ss.SSS} [%thread] %-5level %logger{36} - %msg%n</pattern>
	    	<charset>${r'$'}{char_set}</charset>
	    </encoder> 
    </appender>

	<appender name="${moduleName?upper_case}" class="ch.qos.logback.core.rolling.RollingFileAppender">
		<file>${r'$'}{log_dir}/${moduleName}.log</file>
		<rollingPolicy class="ch.qos.logback.core.rolling.TimeBasedRollingPolicy">
			<FileNamePattern>${r'$'}{log_dir}/${moduleName}.log.%d{yyyy-MM-dd}</FileNamePattern>
		</rollingPolicy>
		<encoder class="ch.qos.logback.classic.encoder.PatternLayoutEncoder">
			<pattern>%d{HH:mm:ss.SSS} [%thread] %-5level %logger{10} [%file:%line] %msg%n</pattern>
			<charset>${r'$'}{char_set}</charset>
		</encoder>
        <filter class="ch.qos.logback.classic.filter.ThresholdFilter">   
            <level>INFO</level>
        </filter>
	</appender>
	
	<appender name="${moduleName?upper_case}-ERROR" class="ch.qos.logback.core.rolling.RollingFileAppender">
		<file>${r'$'}{log_dir}/${moduleName}-error.log</file>
		<rollingPolicy class="ch.qos.logback.core.rolling.TimeBasedRollingPolicy">
			<FileNamePattern>${r'$'}{log_dir}/${moduleName}-error.log.%d{yyyy-MM-dd}.log</FileNamePattern>
		</rollingPolicy>
		<encoder class="ch.qos.logback.classic.encoder.PatternLayoutEncoder">
			<pattern>%d{HH:mm:ss.SSS} [%thread] %-5level %logger{10} [%file:%line] %msg%n</pattern>
			<charset>${r'$'}{char_set}</charset>
		</encoder>
        <filter class="ch.qos.logback.classic.filter.ThresholdFilter">   
            <level>ERROR</level> 
        </filter>
	</appender>
	
	<root level="INFO">
		<appender-ref ref="STDOUT"/>
    	<appender-ref ref="${moduleName?upper_case}"/>
    	<appender-ref ref="${moduleName?upper_case}-ERROR"/>
  	</root> 
  	
</configuration>
