create database `${projectName}`;

<#list processBeans as bean>
CREATE TABLE `${projectName}`.`${bean.tableName}` 
<#list bean.fields as field>
<#if field.fieldName=="id">
(`id` INT(11) NOT NULL AUTO_INCREMENT,
<#elseif  field.dataType=="String">
`${field.columName}` VARCHAR(${field.maxLen?c}) NULL DEFAULT NULL COMMENT '${field.comment}', 
<#elseif  field.dataType=="int">
`${field.columName}` ${field.columnDataType}(${field.maxLen?c}) NULL DEFAULT '0' COMMENT '${field.comment}',
<#elseif  field.dataType="Date">
`${field.columName}` DATETIME NOT NULL COMMENT '${field.comment}', 
</#if>
</#list>
PRIMARY KEY (`id`)
)ENGINE = InnoDB CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT = '${bean.tableComment}';
</#list>