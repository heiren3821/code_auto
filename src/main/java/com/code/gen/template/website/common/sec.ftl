<?xml version="1.0" encoding="UTF-8" ?>

<taglib xmlns="http://java.sun.com/xml/ns/javaee"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://java.sun.com/xml/ns/javaee http://java.sun.com/xml/ns/javaee/web-jsptaglibrary_2_1.xsd"
    version="2.1">
    <description>secrity taglib </description>
  	<display-name>SECRITY code</display-name>
  	<tlib-version>1.1</tlib-version>
  	<short-name>sec</short-name>
<tag>
    <description>
	Secrity conditional tag, which evalutes its body if the
	supplied condition is true and optionally exposes a Boolean
	scripting variable representing the evaluation of this condition
    </description>
    <name>sec</name>
    <tag-class>${packagePrefix}.tld.SecrityTag</tag-class>
    <body-content>JSP</body-content>
    <attribute>
        <description>
			The test condition that determines whether or
			not the body content should be processed.
        </description>
        <name>hasRole</name>
        <required>true</required>
        <rtexprvalue>true</rtexprvalue>
		<type>boolean</type>
    </attribute>
  </tag>
  
</taglib>