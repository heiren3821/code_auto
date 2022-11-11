package ${packagePrefix}.model;

import java.util.List;

public interface Entity<T extends Number> {

	T getId();
	
	boolean isPersist();
	
	void setActive(int active);
	
	List<Field> getFields();
}
