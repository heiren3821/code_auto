<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link href="<%=request.getContextPath()%>/static/css/jquery-ui.min.css" rel="stylesheet"></link>
<script src="<%=request.getContextPath()%>/static/js/jquery-ui.min.js"></script>
<script type="text/javascript">
  function setDate(id) {
	  return $( "#" + id).datepicker({
		  dateFormat: "yy-mm-dd",
		  dayNamesMin:[ "周日", "周一", "周二", "周三", "周四", "周五", "周六" ],
		  monthNames: [ "一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月" ]
		});
  }
</script>