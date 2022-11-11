<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>

  <groupId>${packagePrefix}</groupId>
  <artifactId>${projectPrefix}-parent</artifactId>
  <version>1.0</version>
  <packaging>pom</packaging>
  	
  <modules>
      <#list modules as module>
 		<module>${module}</module>
      </#list>
  </modules>

  <properties>
		<project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
		<maven.test.skip>true</maven.test.skip>
		<downloadSources>false</downloadSources>
		<amp.genericCore>true</amp.genericCore>
		<amp.fullSource>true</amp.fullSource>
		<maven.test.skip>true</maven.test.skip>
		<!-- Framework -->
		<springframework.version>4.1.1.RELEASE</springframework.version>
		<spring.modules.version>0.8</spring.modules.version>
		<!-- velocity -->
		<velocity.version>1.7</velocity.version>
		<velocity.tools.version>1.4</velocity.tools.version>
		<!-- mybatis -->
		<mybatis.version>3.2.8</mybatis.version>
		<mybatis.spring.version>1.2.2</mybatis.spring.version>
		<!-- junit-->
		<junit.version>4.11</junit.version>
		<!--   mysql  -->
		<jdbc.version>5.1.35</jdbc.version>
		<!-- log4j -->
		<log4j.version>1.2.17</log4j.version>
		<!-- logback -->
		<logback.version>1.1.2</logback.version>
		<!-- tomcat embed -->
		<tomcat.version>7.0.56</tomcat.version>
	</properties>

	<distributionManagement>
		<repository>
			<id>releases</id>
			<name>Internal Releases</name>
			<url>
				http://10.241.11.17:18080/nexus/content/repositories/releases
			</url>
		</repository>
		<snapshotRepository>
			<id>snapshots</id>
			<name>Internal Snapshots</name>
			<url>
				http://10.241.11.17:18080/nexus/content/repositories/snapshots
			</url>
		</snapshotRepository>
	</distributionManagement>

	<dependencies>
		<!-- junit test -->
		<dependency>
			<groupId>junit</groupId>
			<artifactId>junit</artifactId>
			<version>${r'$'}{junit.version}</version>
		</dependency>
		
		<!-- collectionUtils dependency -->
		<dependency>
			<groupId>commons-collections</groupId>
			<artifactId>commons-collections</artifactId>
			<version>3.2.1</version>
		</dependency>
		
		<!-- fileupload -->
		<dependency>
			<groupId>commons-fileupload</groupId>
			<artifactId>commons-fileupload</artifactId>
			<version>1.3.1</version>
		</dependency>
		
		<!-- framework -->
		<dependency>
			<groupId>org.springframework</groupId>
			<artifactId>spring-webmvc</artifactId>
			<version>${r'$'}{springframework.version}</version>
		</dependency>
		<dependency>
		    <groupId>org.springframework</groupId>
		    <artifactId>spring-context-support</artifactId>
		    <version>${r'$'}{springframework.version}</version>
		</dependency>
		
		<dependency>
		    <groupId>org.springframework</groupId>
		    <artifactId>spring-orm</artifactId>
		    <version>${r'$'}{springframework.version}</version>
		</dependency>
		
		<!-- redis -->
		<dependency>
		    <groupId>org.springframework.data</groupId>
		    <artifactId>spring-data-redis</artifactId>
		    <version>1.4.1.RELEASE</version>
		</dependency>
		<dependency>
		    <groupId>redis.clients</groupId>
		    <artifactId>jedis</artifactId>
		    <version>2.6.2</version>
		</dependency>
		 <dependency>
		    <groupId>commons-digester</groupId>
		    <artifactId>commons-digester</artifactId>
		    <version>2.1</version>
		</dependency>
		<dependency>
			<groupId>commons-beanutils</groupId>
			<artifactId>commons-beanutils</artifactId>
			<version>1.9.2</version>
		</dependency>
		
		<!-- guava -->
		<dependency>
    		<groupId>com.google.guava</groupId>
    		<artifactId>guava</artifactId>
    		<version>18.0</version>
		</dependency>
		
		<!-- base64 dependency -->
		<dependency>
			<groupId>commons-codec</groupId>
			<artifactId>commons-codec</artifactId>
			<version>1.9</version>
		</dependency>
		
		<!-- commons -->
		<dependency>
		    <groupId>org.apache.commons</groupId>
		    <artifactId>commons-lang3</artifactId>
		    <version>3.3.2</version>
		</dependency>		
		
		<!-- log -->
		<dependency>
		    <groupId>org.slf4j</groupId>
		    <artifactId>slf4j-api</artifactId>
		    <version>1.7.6</version>
		</dependency>
		<dependency>
		    <groupId>ch.qos.logback</groupId>
		    <artifactId>logback-access</artifactId>
		    <version>${r'$'}{logback.version}</version>
		</dependency>
		<dependency>
		    <groupId>ch.qos.logback</groupId>
		    <artifactId>logback-classic</artifactId>
		    <version>${r'$'}{logback.version}</version>
		</dependency>
		<dependency>
		    <groupId>ch.qos.logback</groupId>
		    <artifactId>logback-core</artifactId>
		    <version>${r'$'}{logback.version}</version>
		</dependency>
		
		<!-- json -->
		<dependency>
			<groupId>net.sf.json-lib</groupId>
			<artifactId>json-lib</artifactId>
			<version>2.4</version>
			<classifier>jdk15</classifier>
		</dependency>
		
		<!-- fast json -->
		<dependency>
    		<groupId>com.alibaba</groupId>
    		<artifactId>fastjson</artifactId>
    		<version>1.2.8</version>
		</dependency>
		<!-- json and xml -->
		<dependency>
    		<groupId>org.json</groupId>
    		<artifactId>json</artifactId>
    		<version>20160212</version>
		</dependency>
		
		<!--  hibernate  -->
		<dependency>
			<groupId>org.hibernate</groupId>
			<artifactId>hibernate-core</artifactId>
			<version>3.5.4-Final</version>
		</dependency>
		<dependency>
			<groupId>javassist</groupId>
			<artifactId>javassist</artifactId>
			<version>3.12.1.GA</version>
		</dependency>
		
		<!-- jdbc -->
		<!-- mysql -->
    	<dependency>
			<groupId>mysql</groupId>
			<artifactId>mysql-connector-java</artifactId>
			<version>5.1.35</version>
		</dependency>
		<dependency>
			<groupId>com.jolbox</groupId>
			<artifactId>bonecp</artifactId>
			<version>0.8.0.RELEASE</version>
		</dependency>
		
		<!-- cglib -->		
		<dependency>
    		<groupId>cglib</groupId>
    		<artifactId>cglib</artifactId>
    		<version>3.2.2</version>
		</dependency>
		<!-- httpclient相关  -->
		 <dependency>
			<groupId>commons-httpclient</groupId>
			<artifactId>commons-httpclient</artifactId>
			<version>3.1</version>
			<type>jar</type>
			<scope>compile</scope>
		</dependency>
		<dependency>
			<groupId>org.apache.httpcomponents</groupId>
			<artifactId>httpcore</artifactId>
			<version>4.4-alpha1</version>
		</dependency>
		<dependency>
			<groupId>org.apache.httpcomponents</groupId>
			<artifactId>httpclient</artifactId>
			<version>4.4-alpha1</version>
		</dependency>
		<dependency>
			<groupId>org.apache.httpcomponents</groupId>
			<artifactId>httpmime</artifactId>
			<version>4.4-alpha1</version>
			<scope>compile</scope>
		</dependency>
		<dependency>
    		<groupId>javax.servlet</groupId>
    		<artifactId>servlet-api</artifactId>
    		<version>2.5</version>
    		<scope>provided</scope>
		</dependency>
		<dependency>
    		<groupId>javax.servlet.jsp</groupId>
    		<artifactId>jsp-api</artifactId>
    		<version>2.2</version>
    		<scope>provided</scope>
		</dependency>
		<dependency>
    		<groupId>jstl</groupId>
    		<artifactId>jstl</artifactId>
    		<version>1.2</version>
		</dependency>
	</dependencies>
	
	<build>
		<plugins>
			<plugin>
				<groupId>org.apache.maven.plugins</groupId>
				<artifactId>maven-resources-plugin</artifactId>
				<version>2.5</version>
				<configuration>
					<encoding>UTF-8</encoding>
				</configuration>
			</plugin>
			<plugin>
				<groupId>org.apache.maven.plugins</groupId>
				<artifactId>maven-compiler-plugin</artifactId>
				<version>2.0.2</version>
				<configuration>
					<source>1.7</source>
					<target>1.7</target>
					<encoding>utf8</encoding>
				</configuration>
			</plugin>
			<plugin>
				<groupId>org.apache.maven.plugins</groupId>
				<artifactId>maven-surefire-plugin</artifactId>
				<version>2.10</version>
				<configuration>
					<skip>true</skip>
				</configuration>
			</plugin>
			<plugin>
				<groupId>org.apache.maven.plugins</groupId>
				<artifactId>maven-eclipse-plugin</artifactId>
				<version>2.6</version>
			</plugin>
			<plugin>
				<groupId>org.apache.maven.plugins</groupId>
				<artifactId>maven-dependency-plugin</artifactId>
  				<version>2.8</version>
			</plugin>
		</plugins>
	</build>
</project>
