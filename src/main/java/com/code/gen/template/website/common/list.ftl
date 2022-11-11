<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="head.jsp" %>
<body>
      <%@ include file="navbar.jsp" %>
      <div class="container-fluid">
      <div class="row">
      <%@ include file="left.jsp" %>
      <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
      	  <h1>${r'$'}{emptyEntry.menuName}</h1>
      	  <div class="navbar-form" style="text-align: right;">
            <input type="button" class="btn btn-default add"  value="添加业务">
          </div>
          <div class="table-responsive">
            <table class="table table-striped">
              <thead>
                <tr>
                  <th>id</th>
				 <c:forEach items="${r'$'}{emptyEntry.fields}" var="field">
				  <th>${r'$'}{field.name}</th>
				 </c:forEach>
                  <th>状态</th>
                  <th class="t-c">操作</th>
                </tr>
              </thead>
              <tbody>
              <c:forEach items="${r'$'}{pagination.items}" var="entry">
              	  <tr>
                  	<td>${r'$'}{entry.id}</td>
                  <c:forEach items="${r'$'}{entry.fields}" var="field">
				  	<td>${r'$'}{field.value}</td>
				  </c:forEach>
                  	<td><c:if test="${r'$'}{entry.active=='1'}">有效</c:if><c:if test="${r'$'}{entry.active=='0'}">无效</c:if></td>
                  	<td class="t-c"><a href="javascript:action('${r'$'}{entry.id}','${r'$'}{entry.active}')"><c:if test="${r'$'}{entry.active=='1'}">停用</c:if><c:if test="${r'$'}{entry.active=='0'}">启用</c:if></a>
                  	<a href="<%=request.getContextPath()%>/manage/${r'$'}{emptyEntry.lowName}/${r'$'}{entry.id}/load.do">编辑</a></td>
                </tr>
              </c:forEach>
              </tbody>
            </table>
          </div>
           <%@ include file="pagination.jsp" %>
        </div>
      </div>
    </div>
<script type="text/javascript">
function action(id,active) {
	if(confirm("确定"+(active==1?"停用":"启用")+"此业务吗？")){
	$.ajax({
		  type: 'GET',
		  url: "<%=request.getContextPath()%>/manage/${r'$'}{emptyEntry.lowName}/"+id+"/"+(active==1?"inactive":"active")+".do",
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
		 window.location.href="<%=request.getContextPath()%>/manage/${r'$'}{emptyEntry.lowName}/0/load.do";
	});
});
</script>
</body>