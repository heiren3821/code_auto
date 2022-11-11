<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/head.jsp" %>
<body>
      <%@ include file="../common/navbar.jsp" %>
      <div class="container-fluid">
      <div class="row">
      <%@ include file="../common/left.jsp" %>
      <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
      	  <h1>第三方账户管理</h1>
      	  <div class="navbar-form" style="text-align: right;">
            <!-- <input type="button" class="btn btn-default add"  value="添加业务">-->
          </div>
          <div class="table-responsive">
            <table class="table table-striped">
              <thead>
                <tr>
                  <th>id</th>
 				<th>邮箱</th>
 				<th>密码</th>
 				<th>密码盐</th>
 				<th>开放账户状态</th>
 				<th>联系人姓名</th>
 				<th>联系人手机号</th>
 				<th>国家</th>
 				<th>省份</th>
 				<th>联系地址</th>
 				<th>联系人身份证</th>
                  <th>状态</th>
                  <th class="t-c">操作</th>
                </tr>
              </thead>
              <tbody>
              <c:forEach items="${entrys}" var="entry">
              	  <tr>
                  <td>${entry.id}</td>
 				     <td>${entry.email}</td>
 				     <td>${entry.passwd}</td>
 				     <td>${entry.salt}</td>
 				     <td>${entry.status}</td>
 				     <td>${entry.contactName}</td>
 				     <td>${entry.contactNo}</td>
 				     <td>${entry.country}</td>
 				     <td>${entry.province}</td>
 				     <td>${entry.contactAddress}</td>
 				     <td>${entry.contactId}</td>
                  	<td><c:if test="${entry.active=='1'}">有效</c:if><c:if test="${entry.active=='0'}">无效</c:if></td>
                  	<td class="t-c"><a href="javascript:action('${entry.id}','${entry.active}')"><c:if test="${entry.active=='1'}">停用</c:if><c:if test="${entry.active=='0'}">启用</c:if></a>
                  	<a href="<%=request.getContextPath()%>/manage/openAccount/${entry.id}/load.do">编辑</a></td>
                </tr>
              </c:forEach>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
<script type="text/javascript">
function action(id,active) {
	if(confirm("确定"+(active==1?"停用":"启用")+"此业务吗？")){
	$.ajax({
		  type: 'GET',
		  url: "<%=request.getContextPath()%>/manage/openAccount/"+id+"/"+(active==1?"inactive":"active")+".do",
		  success: function(data){
			  if(data.retCode=='0') {
				  alert(data.retMsg);
				  window.location.href = window.location.href;
			  }
		  },
		  dataType: 'json'
		});
	}
}
$(document).ready(function(){
	$(".add").click(function(){
		 window.location.href="<%=request.getContextPath()%>/manage/openAccount/0/load.do";
	});
});
</script>
</body>