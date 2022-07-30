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
    <div class="panel-heading">로그인</div>
    <div class="panel-body">
    	<form action='<c:url value="/memLogin.do"/>' method="post">
    	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    		<table class="table table-bordered" style="text-align:center; border:1px solid #dddddd;">
    			<tr>
    				<td style="width:200px; vertical-align: middle;">아이디</td>
    				<td><input id="memID" name="memID" type="text" class="form-control" maxlength="20" placeholder="아이디를 입력해주세요"/></td>
    			</tr>
    			<tr>
    				<td style="width:200px; vertical-align: middle;">비밀번호</td>
    				<td colspan="2"><input id="memPassword" name="memPassword" type="password" class="form-control" maxlength="20" placeholder="비밀번호를 입력해주세요"/></td>
    			</tr>
    			<tr>
    				<td colspan="2" style="text-align:left;">
    					<input type="submit" class="btn btn-primary btn-sm pull-right" value="로그인"/>
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