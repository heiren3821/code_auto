package ${packagePrefix}.dao${packageSuffix};

import org.springframework.stereotype.Repository;

import ${packagePrefix}.dao.MainDaoBase;
import ${packagePrefix}.model${packageSuffix}.${beanName};

/**
 * ### auto generate code.
 *
 */
@Repository
public class ${beanName}Dao extends MainDaoBase<${beanName}, Integer> {

	public ${beanName}Dao() {
		super(${beanName}.class);
	}
}