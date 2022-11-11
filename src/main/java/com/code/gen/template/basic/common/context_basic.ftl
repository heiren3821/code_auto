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

    <!--  data source -->
    <bean class="org.springframework.beans.factory.config.PropertyPlaceholderConfigurer">
        <property name="locations"><list>
            <value>classpath:config.properties</value>
            <value>classpath:config.properties.test</value>
            <value>classpath:config.properties.local</value>
            <value>classpath:config-core.properties</value>
        </list></property>
        <property name="ignoreResourceNotFound" value="true"></property>
    </bean>
    
    <bean id="${projectPrefix}_basic_dataSource" class="com.jolbox.bonecp.BoneCPDataSource" destroy-method="close">
        <property name="driverClass" value="com.mysql.jdbc.Driver" />
        <property name="jdbcUrl" value="jdbc:mysql://${r'$'}{mysql.server.ip}:3306/${r'$'}{mysql.server.database}?autoReconnect=true&amp;useUnicode=true&amp;characterEncoding=UTF-8" />
        <property name="username" value="${r'$'}{mysql.server.username}"/>
        <property name="password" value="${r'$'}{mysql.server.password}"/>
        <property name="idleConnectionTestPeriodInMinutes" value="60"/>
        <property name="idleMaxAgeInMinutes" value="240"/>
        <property name="maxConnectionsPerPartition" value="10"/>
        <property name="minConnectionsPerPartition" value="5"/>
        <property name="partitionCount" value="1"/>
        <property name="acquireIncrement" value="1"/>                              
        <property name="statementsCacheSize" value="3"/>
        <property name="releaseHelperThreads" value="3"/>
        <property name="closeConnectionWatch" value="false"/>
    </bean>
    <!-- hibernate sessionFactory -->
    <bean id="sessionFactory"
		class="org.springframework.orm.hibernate3.LocalSessionFactoryBean">
		<property name="dataSource" ref="${projectPrefix}_basic_dataSource" />
		<property name="mappingLocations">
			<list>
				<value>classpath*:mappings/*.hbm.xml</value>
			</list>
		</property>
		<property name="hibernateProperties">
			<props>
				<prop key="hibernate.dialect">org.hibernate.dialect.MySQLDialect</prop>
				<prop key="hibernate.show_sql">false</prop>
				<prop key="hibernate.jdbc.batch_size">1</prop>
			</props>
		</property>
	</bean>
	<!-- transaction -->
	<bean id="${projectPrefix}_basic_transactionManager"
		class="org.springframework.orm.hibernate3.HibernateTransactionManager">
		<property name="sessionFactory" ref="sessionFactory" />
	</bean>
	
	<tx:annotation-driven transaction-manager="${projectPrefix}_basic_transactionManager" proxy-target-class="true"/>
    <!-- 
    <import resource="${projectPrefix}_basic_redis.xml"/>-->
</beans>