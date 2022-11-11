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
                 <td>应用唯一主键</td>
                 <td><form:textarea path="appBasicId"/></td>
              </tr>
              <tr>
                 <td>枚举值 平台标示 android or ios</td>
                 <td><form:textarea path="platform"/></td>
              </tr>
              <tr>
                 <td>下载url</td>
                 <td><form:textarea path="downloadUrl"/></td>
              </tr>
              <tr>
                 <td>最新版本</td>
                 <td><form:textarea path="appVersion"/></td>
              </tr>
              <tr>
                 <td>应用文件md5值</td>
                 <td><form:textarea path="appMd5"/></td>
              </tr>
              <tr>
                 <td>应用文件大小 字节</td>
                 <td><form:textarea path="appSize"/></td>
              </tr>
              <tr>
                 <td>app升级信息</td>
                 <td><form:textarea path="appDesc"/></td>
              </tr>
              <tr>
                 <td>处理点策略，发起点 策略.</td>
                 <td><form:textarea path="moduleStrategy"/></td>
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
				  url: "<%=request.getContextPath()%>/manage/openUpgradeConfig/save.do",
				  data: $("#entryForm").serialize(),
				  success: function(data){
					  if(data.retCode=='0') {
						  window.location.href="<%=request.getContextPath()%>/manage/openUpgradeConfig/list.do";
					  } else {
						 $(".entry-message").html(data.retMsg);
						 $(".entry-message").removeClass("hidden");
					  }
				  },
				  dataType: 'json'
				});
		});
		$(".entry-cancel").click(function(){
			window.location.href="<%=request.getContextPath()%>/manage/openUpgradeConfig/list.do";
		});
	});
</script>
</body>