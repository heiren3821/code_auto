package ${packagePrefix}.service${packageSuffix};

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ${packagePrefix}.dao.MainDaoBase;
import ${packagePrefix}.dao${packageSuffix}.${beanName}Dao;
import ${packagePrefix}.model${packageSuffix}.${beanName};
import ${packagePrefix}.service.CacheService;

/**
 * ###
 * ### auto generate code.
 *
 */
@Service
@Transactional(readOnly = true)
public class ${beanName}Service extends CacheService<Integer, ${beanName}> {
	
	@Autowired
	private ${beanName}Dao ${beanNick}Dao;
	
	<#list outBeans as outBean>
	@Autowired
	private ${outBean}Service ${outBean?uncap_first}Service;
	</#list>

	@Override
	protected MainDaoBase<${beanName}, Integer> getMainDao() {
		return ${beanNick}Dao;
	}
	
	<#if beanName?lower_case?ends_with("userinfo")>
	public ${beanName} getByAccount(String userName) {
		return getBySingleKey("userName", userName);
	}
	</#if>
	
	<#if (outBeans?size>0)>
	protected ${beanName} amendEntity(${beanName} e) {
		<#list outBeans as outBean>
		 if(e.get${outBean}Id()>0) {
		 	e.set${outBean}(${outBean?uncap_first}Service.getById(e.get${outBean}Id()));
		 }
		</#list>
		return e;
	}
	</#if>
}
