<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="common/head.jsp" %>
<body>
      <div class="container-fluid">
      <div class='content'>
        <span class='msg'>你未获得授权操作该短信管理平台页面,</span><span class="sec">10</span>秒后自动退出，<a class='link-logout' href="<%=request.getContextPath()%>/${projectPrefix}/logout.do">登出</a>
        </div>
    </div>
<script type="text/javascript">
	function autocheck() {
		var sec = $(".sec").html();
		$(".sec").html(sec-1);
		if(sec == 1) {
			window.location.href="<%=request.getContextPath()%>/${projectPrefix}/logout";
		}
	}
	setInterval(autocheck, 1000);
</script>
</body>