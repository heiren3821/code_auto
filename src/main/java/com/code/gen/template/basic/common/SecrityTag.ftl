package ${packagePrefix}.tld;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.jstl.core.ConditionalTagSupport;

import org.apache.commons.lang3.StringUtils;

import ${packagePrefix}.common.util.StringUtil;

public class SecrityTag extends ConditionalTagSupport {
	
	private String hasRole;
	
	private static final long serialVersionUID = -866835072513603664L;

	@Override
	protected boolean condition() throws JspTagException {
		if (StringUtils.isBlank(hasRole)) {
			return false;
		}
		String[] temps = StringUtils.split(hasRole, ",");
		for (String temp : temps) {
			if(StringUtil.contain(getCurrentRols(), temp)) {
				return true;
			}
		}
		return false;
	}
	
	private String getCurrentRols() {
		HttpServletRequest request = (HttpServletRequest) pageContext.getRequest();
		Object userRoles = request.getAttribute("USER_ROLES");
		return userRoles == null ? "" : userRoles.toString();
	}
	

	public String getHasRole() {
		return hasRole;
	}

	public void setHasRole(String hasRole) {
		this.hasRole = hasRole;
	}
}
