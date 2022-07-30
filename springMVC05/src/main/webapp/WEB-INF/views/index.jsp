<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<div class="container">
	<jsp:include page="common/header.jsp"/>
	  <div class="panel panel-default" style="margin-top:15px;">
	    <div style="text-align:center;">
	    	<img src="http://placeimg.com/640/480/any" style="width:100%;height:425px;"/>
	    </div>
	    <div class="panel-body">
	    
	    	<ul class="nav nav-tabs">
			  <li class="active"><a data-toggle="tab" href="#home">Home</a></li>
			  <li><a data-toggle="tab" href="#menu1">게시판</a></li>
			  <li><a data-toggle="tab" href="#menu2">공지사항</a></li>
			</ul>
			
			<div class="tab-content">
			  <div id="home" class="tab-pane fade in active">
			    <h3>HOME</h3>
			    <p>Some content.</p>
			  </div>
			  <div id="menu1" class="tab-pane fade">
			    <h3>게시판</h3>
			    <p>Some content in menu 1.</p>
			  </div>
			  <div id="menu2" class="tab-pane fade">
			    <h3>공지사항</h3>
			    <p>Some content in menu 2.</p>
			  </div>
			</div>
			
	    </div>
	    <div class="panel-footer">스프1탄_인프런(TED)</div>
	  </div>
	</div>
	
	<!-- 실패메시지 -->
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
	$(function(){
		var type = '${msgType}';
		var msg = '${msg}';
		if(${!empty msgType}) {
			$("#msgType").attr("class", "modal-content panel-success");
			$("#myMsg").modal("show");
		};
	});
</script>
</html>
