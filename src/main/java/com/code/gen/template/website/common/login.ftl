<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<title>${projectDesc}</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/styles/bootstrap.min.css">
<link href="<%=request.getContextPath()%>/static/styles/dashboard.css" rel="stylesheet"></link>
<script type="text/javascript" src="<%=request.getContextPath()%>/static/js/jquery-2.2.3.min.js"></script>

<body>
	<div id="container">
		<c:if test="${r'$'}{not empty error}">
			<div class="error">${r'$'}{error}</div>
		</c:if>
		<c:if test="${r'$'}{not empty msg}">
			<div class="msg">${r'$'}{msg}</div>
		</c:if>
		<form id="loginForm" name="loginForm" action="<%=request.getContextPath()%>/${projectPrefix}/login" method="post" class="form-signin">
			<h2 class="form-signin-heading">${projectDesc}</h2>
			<div>
				<c:if test="${r'$'}{not empty errorMessage}">
					<span style="color: red">${r'$'}{errorMessage}</span>
				</c:if>
			</div>

			<div>
				<input type="text" name="userName" id="userName" placeholder="用户名" class="form-control required" >
			</div>

			<div>
				<input type="password" name="password" id="password" placeholder="密码" class="form-control required"/>
			</div>

			<div class="checkbox">
				<label><input type="checkbox" id="rememberMe" name="rememberMe" value="true"/><b>记住我: </b></label>
			</div>

			<div>
				<input type='button' value='登录' onclick="loginForm.submit()" class="btn btn-lg btn-primary btn-block" />
			</div>
		</form>
	</div>
<script>
$(document).keypress(function(e) {  
    // 回车键事件  
       if(e.which == 13) {  
    	   loginForm.submit();  
       }  
   }); 
</script>
</body>