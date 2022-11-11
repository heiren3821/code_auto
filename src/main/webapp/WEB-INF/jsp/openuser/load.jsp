<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ include file="../common/head.jsp" %>
<body>
      <%@ include file="../common/navbar.jsp" %>
      <div class="container-fluid">
      <div class="row">
      <%@ include file="../common/left.jsp" %>
      <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
      <h2 class="sub-header"><c:if test="${entry.id>0}">编辑</c:if><c:if test="${entry.id ==0}">编辑</c:if>配置</h2>
          <div class="table-responsive">
            <div ><span class="alert-danger entry-message hidden"></span></div>
            <form:form commandName="entry" id="entryForm" name="entryForm">
            <table class="table table-striped">
            	<form:hidden path="id"/>
            	<input type="hidden" name="active" value="${entry.active}"/>
              <tr>
                 <td>域帐号</td>
                 <td><form:textarea path="account"/></td>
              </tr>
              <tr>
                 <td>中文名</td>
                 <td><form:textarea path="nameZh"/></td>
              </tr>
              <tr>
                 <td>工号 </td>
                 <td><form:textarea path="badge"/></td>
              </tr>
              <tr>
                 <td>手机号</td>
                 <td><form:textarea path="telephone"/></td>
              </tr>
              <tr>
                 <td>部门</td>
                 <td><form:textarea path="depName"/></td>
              </tr>
              <tr>
                 <td>直属上级</td>
                 <td><form:textarea path="reportName"/></td>
              </tr>
              <tr>
                 <td>角色</td>
                 <td><form:textarea path="role"/></td>
              </tr>
              <tr>
              	 <c:if test="${entry.id>0 }"><form:hidden path="createTimeStr"/></c:if>
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
				  url: "<%=request.getContextPath()%>/manage/openUser/save.do",
				  data: $("#entryForm").serialize(),
				  success: function(data){
					  if(data.retCode=='0') {
						  window.location.href="<%=request.getContextPath()%>/manage/openUser/list.do";
					  } else {
						 $(".entry-message").html(data.retMsg);
						 $(".entry-message").removeClass("hidden");
					  }
				  },
				  dataType: 'json'
				});
		});
		$(".entry-cancel").click(function(){
			window.location.href="<%=request.getContextPath()%>/manage/openUser/list.do";
		});
	});
</script>
</body>