<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Spring MVC03</title>
</head>
<body>
<div class="container">
<jsp:include page="../common/header.jsp"/>
  <h2>Spring MVC03</h2>
  <div class="panel panel-default">
    <div class="panel-heading">회원사진등록</div>
    <div class="panel-body">
    	<form action='<c:url value="/addUserImg.do?${_csrf.parameterName}=${_csrf.token}"/>' method="post" enctype="multipart/form-data">
    		<input type="hidden" name="memID" value="${mvo.memID}"/>
    		<table class="table table-bordered" style="text-align:center; border:1px solid #dddddd;">
    			<tr>
    				<td style="width:200px; vertical-align: middle;">아이디</td>
    				<td>${mvo.memID}</td>
    			</tr>
    			<tr>
    				<td style="width:200px; vertical-align: middle;">사진업로드</td>
    				<td><input type="file" name="memProfile"/></td>
    			</tr>
    			<tr>
    				<td colspan="2" style="text-align:left;">
    					<input type="submit" class="btn btn-primary btn-sm pull-right" value="등록"/>
    				</td>
    			</tr>
    		</table>
    	</form>
    </div>
    <div class="panel-footer">스프1탄_인프런(TED)</div>
  </div>
</div>

<!-- 로그인 실패메시지 -->
 <div class="modal fade" id="myMsg" role="dialog">
   <div class="modal-dialog">
   
     <!-- Modal content-->
     <div id="msgType" class="modal-content panel-info">
       <div class="modal-header panel-heading">
         <button type="button" class="close" data-dismiss="modal">&times;</button>
         <h4 class="modal-title">${msgType}</h4>
       </div>
       <div class="modal-body">
         <p>${msg}</p>
       </div>
       <div class="modal-footer">
         <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
       </div>
     </div>
     
   </div>
 </div>

</body>
<script type="text/javascript">
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	
	$(function(){
		var type = '${msgType}';
		var msg = '${msg}';
		if(${!empty msgType}) {
			$("#msgType").attr("class", "modal-content panel-warning");
			$("#myMsg").modal("show");
		};
	});
</script>
</html>