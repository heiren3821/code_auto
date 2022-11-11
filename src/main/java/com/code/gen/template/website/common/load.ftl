<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ include file="head.jsp" %>
<body>
      <%@ include file="navbar.jsp" %>
      <div class="container-fluid">
      <div class="row">
      <%@ include file="left.jsp" %>
      <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
      <h2 class="sub-header"><c:if test="${r'$'}{entry.id>0}">编辑</c:if><c:if test="${r'$'}{entry.id ==0}">编辑</c:if>配置</h2>
          <div class="table-responsive">
            <div ><span class="alert-danger entry-message hidden"></span></div>
            <form:form commandName="entry" id="entryForm" name="entryForm">
            <table class="table table-striped">
            	<form:hidden path="id"/>
              <c:forEach items="${r'$'}{entry.fields}" var="field">
			  <tr>
                 <td width="20%">${r'$'}{field.name}</td>
                 <td width="80%"><textarea name="${r'$'}{field.fieldName}" class="form-control" style="width:50%">${r'$'}{field.value}</textarea></td>
              </tr>
			  </c:forEach>
			  <tr>
                 <td width="20%">备注信息</td>
                 <td width="80%"><textarea name="remark" class="form-control" style="width:50%">${r'$'}{entry.remark}</textarea></td>
              </tr>
              <tr>
              	 <c:if test="${r'$'}{entry.id>0 }"><form:hidden path="active"/><form:hidden path="createTimeStr"/></c:if>
                 <td colspan="2" class="t-c"><input type="button" class="btn btn-primary entry-cancel" style="margin-right:20px;" value="取消"><input type="button" class="btn btn-primary entry-save" value="提交"></td>
              </tr>
            </table>
            </form:form>
          </div>
        </div>
      </div>
    </div>
<script type="text/javascript">
	$(document).ready(function(){
		$(".entry-save").click(function(){
			$(".entry-message").addClass("hidden");
			$.ajax({
				  type: 'POST',
				  url: "<%=request.getContextPath()%>/manage/${r'$'}{entry.lowName}/save.do",
				  data: $("#entryForm").serialize(),
				  success: function(data){
					  if(data.retCode=='0') {
						  window.location.href="<%=request.getContextPath()%>/manage/${r'$'}{entry.lowName}/list.do";
					  } else {
						 $(".entry-message").html(data.retMsg);
						 $(".entry-message").removeClass("hidden");
					  }
				  },
				  dataType: 'json'
				});
		});
		$(".entry-cancel").click(function(){
			window.location.href="<%=request.getContextPath()%>/manage/${r'$'}{entry.lowName}/list.do";
		});
	});
</script>
</body>