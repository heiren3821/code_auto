package ${packagePrefix}.enums;

/**
 * @author chenweixiong
 *
 */
public enum RoleEnum {
	ROLE_USER(1, "普通用户"), ROLE_QUERY(2, "查询用户"), ROLE_ADMIN(3, "管理员");
	private final int code;
	private final String name;

	private RoleEnum(int code, String name) {
		this.code = code;
		this.name = name;
	}

	public int getCode() {
		return code;
	}

	public String getName() {
		return name;
	}
	
	public boolean isAdmin() {
		return code == 3;
	}

	public static RoleEnum valueOf(int code) {
		for(RoleEnum temp :values()) {
			if(temp.getCode() ==code) {
				return temp;
			}
		}
		return ROLE_USER;
	}
}
