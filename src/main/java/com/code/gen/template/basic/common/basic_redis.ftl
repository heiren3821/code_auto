<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xmlns:p="http://www.springframework.org/schema/p"
	xmlns:context="http://www.springframework.org/schema/context" 
	xsi:schemaLocation="
		http://www.springframework.org/schema/beans 
		http://www.springframework.org/schema/beans/spring-beans-4.0.xsd
		http://www.springframework.org/schema/context 
		http://www.springframework.org/schema/context/spring-context-4.0.xsd">
	
	<!-- video data redis -->
	<bean id="${projectPrefix}BasicJedisPoolConfig" class="redis.clients.jedis.JedisPoolConfig">
		<property name="maxTotal" value="${r'$'}{redis.${projectPrefix}.data.pool.maxTotal}" />
		<property name="maxIdle" value="${r'$'}{redis.${projectPrefix}.data.pool.maxIdle}" />
		<property name="maxWaitMillis" value="${r'$'}{redis.${projectPrefix}.data.pool.maxWaitMillis}" />
		<property name="testOnBorrow" value="${r'$'}{redis.${projectPrefix}.data.pool.testOnBorrow}" />
	</bean>
	
	<bean id="${projectPrefix}BasicJedisConnectionFactory"
		class="org.springframework.data.redis.connection.jedis.JedisConnectionFactory"
		p:host-name="${r'$'}{redis.${projectPrefix}.data.host}" p:port="${r'$'}{redis.${projectPrefix}.data.port}" p:password="${r'$'}{redis.${projectPrefix}.data.pass}"
		p:poolConfig-ref="${projectPrefix}BasicJedisPoolConfig" />
		
	<bean id="${projectPrefix}BasicRedisTemplate" class="org.springframework.data.redis.core.StringRedisTemplate"
		p:connection-factory-ref="${projectPrefix}BasicJedisConnectionFactory" />
		 

</beans>