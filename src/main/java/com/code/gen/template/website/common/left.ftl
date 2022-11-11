<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="/WEB-INF/tld/sec.tld" %>
<div class="col-sm-3 col-md-2 sidebar">
     <ul class="nav nav-sidebar">
     <sec:sec hasRole="ROLE_ADMIN">
     <#list processBeans as bean>
         <li data-key='${bean.beanName?lower_case}'><a href="<%=request.getContextPath()%>/manage/${bean.beanName?lower_case}/list.do"><span class="glyphicon glyphicon-cog icon-cog"></span>${bean.menuName}</a></li>
     </#list>
     </sec:sec>
     </ul>
</div>
<script type="text/javascript">
$(document).ready(function() {
	var url = window.location.href;
	url = url.indexOf("?")>0?url.substring(0,url.indexOf("?")):url;
	$.each($( "ul.nav-sidebar > li" ),function(index,li) {
		if(url.indexOf($(li).data("key"))>0) {
			$(li).addClass("active");
		}
	})
})
</script>