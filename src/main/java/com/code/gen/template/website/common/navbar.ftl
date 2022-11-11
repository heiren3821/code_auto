<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav class="navbar navbar-inverse1 navbar-fixed-top navbar-inner navbar-header">
      <div class="container-fluid">
        <div class="navbar-header">
          <a class="navbar-brand navbar-brand-logo" href="#">${projectDesc}</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
        	<div class="nav navbar-nav navbar-right">
        		<a href="<%=request.getContextPath()%>/${projectPrefix}/logout.do" class="navbar-brand navbar-brand-logout"><span class="glyphicon glyphicon-off icon-logout"></span>登出</a>
        	</div>
        </div>
      </div>
    </nav>