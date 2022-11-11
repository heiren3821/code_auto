<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div style="float:right">
  	<ul class="pagination pagination-lg">
    	<c:if test="${r'$'}{pagination.pages.size()>0}">
    		<li class="page-item <c:if test="${r'$'}{!pagination.showPrevious}">disabled</c:if>"><a class="page-link" pageNo="${r'$'}{pagination.previous}" href="javascript:void(0)">前一页</a></li>
    	<c:forEach items="${r'$'}{pagination.pages}" var="page">
    		<li class="page-item <c:if test="${r'$'}{page==pagination.pageNo}">active</c:if>"><a class='page-link' pageNo="${r'$'}{page}" href="javascript:void(0)">${r'$'}{page}</a></li>
    	</c:forEach>
    		<li class="page-item <c:if test="${r'$'}{!pagination.showNext}">disabled</c:if>"><a class="page-link" pageNo="${r'$'}{pagination.next}" href="javascript:void(0)">下一页</a></li>
    		<li class="page-item disabled"><a  href="javascript:void(0)">共${r'$'}{pagination.maxSize}页${r'$'}{pagination.count}条</a></li>
  		</c:if>
  	</ul>
</div>
<script type="text/javascript">
function getUrlQueryParams() {
    var sPageURL = decodeURIComponent(window.location.search.substring(1)),
        sURLVariables = sPageURL.split('&'),
        sParameterName,
        i;
    var result = '';
    for (i = 0; i < sURLVariables.length; i++) {
        sParameterName = sURLVariables[i].split('=');
        if(sParameterName[0]=='pageNo'|| sParameterName[0]=='pageSize') {
        	continue;
        }
        result = result+'&'+sURLVariables[i];
    }
    return result;
};
${r'$'}(document).ready(function(){
	${r'$'}(".page-link").click(function(){
		if(${r'$'}(this).parent().hasClass("disabled")) {
			return;
		}
		var url = window.location.href.split("?")[0];
		var pageNo = ${r'$'}(this).attr("pageNo");
		window.location.href = url+"?pageNo="+pageNo+"&pageSize=${r'$'}{pagination.pageSize}" +getUrlQueryParams();
	});
});
</script>