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
                 <td>邮箱</td>
                 <td><form:textarea path="email"/></td>
              </tr>
              <tr>
                 <td>密码</td>
                 <td><form:textarea path="passwd"/></td>
              </tr>
              <tr>
                 <td>密码盐</td>
                 <td><form:textarea path="salt"/></td>
              </tr>
              <tr>
                 <td>开放账户状态</td>
                 <td><form:textarea path="status"/></td>
              </tr>
              <tr>
                 <td>联系人姓名</td>
                 <td><form:textarea path="contactName"/></td>
              </tr>
              <tr>
                 <td>联系人手机号</td>
                 <td><form:textarea path="contactNo"/></td>
              </tr>
              <tr>
                 <td>国家</td>
                 <td><form:textarea path="country"/></td>
              </tr>
              <tr>
                 <td>省份</td>
                 <td><form:textarea path="province"/></td>
              </tr>
              <tr>
                 <td>联系地址</td>
                 <td><form:textarea path="contactAddress"/></td>
              </tr>
              <tr>
                 <td>联系人身份证</td>
                 <td><form:textarea path="contactId"/></td>
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
				  url: "<%=request.getContextPath()%>/manage/openAccount/save.do",
				  data: $("#entryForm").serialize(),
				  success: function(data){
					  if(data.retCode=='0') {
						  window.location.href="<%=request.getContextPath()%>/manage/openAccount/list.do";
					  } else {
						 $(".entry-message").html(data.retMsg);
						 $(".entry-message").removeClass("hidden");
					  }
				  },
				  dataType: 'json'
				});
		});
		$(".entry-cancel").click(function(){
			window.location.href="<%=request.getContextPath()%>/manage/openAccount/list.do";
		});
	});
</script>
</body>