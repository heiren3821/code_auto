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
                 <td>所属账户</td>
                 <td><form:textarea path="accountId"/></td>
              </tr>
              <tr>
                 <td>应用名称</td>
                 <td><form:textarea path="name"/></td>
              </tr>
              <tr>
                 <td>应用描述</td>
                 <td><form:textarea path="desc"/></td>
              </tr>
              <tr>
                 <td>应用官网</td>
                 <td><form:textarea path="website"/></td>
              </tr>
              <tr>
                 <td>所属公司名</td>
                 <td><form:textarea path="campany"/></td>
              </tr>
              <tr>
                 <td>小图url地址</td>
                 <td><form:textarea path="imgSmall"/></td>
              </tr>
              <tr>
                 <td>中图url地址</td>
                 <td><form:textarea path="imgMid"/></td>
              </tr>
              <tr>
                 <td>应用状态</td>
                 <td><form:textarea path="status"/></td>
              </tr>
              <tr>
                 <td>审核时间</td>
                 <td><form:textarea path="auditTime"/></td>
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
				  url: "<%=request.getContextPath()%>/manage/openAppBasic/save.do",
				  data: $("#entryForm").serialize(),
				  success: function(data){
					  if(data.retCode=='0') {
						  window.location.href="<%=request.getContextPath()%>/manage/openAppBasic/list.do";
					  } else {
						 $(".entry-message").html(data.retMsg);
						 $(".entry-message").removeClass("hidden");
					  }
				  },
				  dataType: 'json'
				});
		});
		$(".entry-cancel").click(function(){
			window.location.href="<%=request.getContextPath()%>/manage/openAppBasic/list.do";
		});
	});
</script>
</body>