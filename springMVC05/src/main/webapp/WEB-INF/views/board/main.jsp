<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<div class="container">
 <jsp:include page="../common/header.jsp"/>
  <h2>회원게시판</h2>
  <div class="panel panel-default">
    <div class="panel-heading">BOARD</div>
    <div class="panel-body" id="view">Panel Content</div>
    <div class="panel-body" id="wForm" style="display:none;">
    	<form id="frm">
    	<input type="hidden" name="memID" value="${mvo.memID}"/>
    	<table class="table">
    		<tr>
    			<td>제목</td>
    			<td><input type="text" id="title" name="title" class="form-control"/></td>
    		</tr>
    		<tr>
    			<td>내용</td>
    			<td><textarea rows="7" id="content" name="content" class="form-control"/></textarea></td>
    		</tr>
    		<tr>
    			<td>작성자</td>
    			<td><input type="text" id="writer" name="writer" class="form-control" value="${mvo.memName}" readonly/></td>
    		</tr>
    		<tr>
    			<td colspan="2" align="center">
    				<button type="button" class="btn btn-success btn-sm" onclick="goInsert()">등록</button>
    				<button type="reset" id="clear" class="btn btn-warning btn-sm">취소</button>
    				<button type="button" class="btn btn-info btn-sm" onclick="goForm('L')">목록</button>
    			</td>
    		</tr>
    	</table>
    	</form>
    </div>
    <div class="panel-footer">스프1탄_TED</div>
  </div>
</div>
</body>
<script type="text/javascript">
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";

	$(document).ready(function(){
		loadList();
	})
	
	function loadList() {
		$("#clear").trigger("click");
		// 서버와 통신 : 게시판 리스트 가져오기
		$.ajax({
			url : "board/all",
			type : "get",
			dataType : "json",
			success : makeView,
			error : function(){
				alert("error");
			}
		});		
	}
	
	function makeView(arr) {
		var listHtml = "<table class='table table-bordered'>";
		listHtml += "<tr>";
		listHtml += "<td>번호</td>";
		listHtml += "<td>제목</td>";
		listHtml += "<td>작성자</td>";
		listHtml += "<td>작성일</td>";
		listHtml += "<td>조회수</td>";
		listHtml += "</tr>";
		$.each(arr, function(i, obj){
			listHtml += "<tr>";
			listHtml += "<td>"+ obj.idx +"</td>";
			listHtml += "<td class='td_title'><a data-idx="+obj.idx+" onclick='goContent("+obj.idx+")' style='cursor:pointer;'>"+ obj.title +"</a></td>";
			listHtml += "<td>"+ obj.writer +"</td>";
			listHtml += "<td>"+ obj.indate.split(' ')[0] +"</td>";
			listHtml += "<td id='cnt"+obj.idx+"'>"+ obj.count +"</td>";
			listHtml += "</tr>";
			listHtml += "<tr id='c"+obj.idx+"' style='display:none;'>";
			listHtml += "<td>내용</td>";
			listHtml += "<td colspan='4'>";
			listHtml += "<textarea rows='7' id='ta"+obj.idx+"' class='form-control ta' readonly></textarea>";
			// 본인글만
			if("${mvo.memID}" == obj.memID) {
				listHtml += "<br/>";
				listHtml += "<span><button class='btn btn-success btn-sm' data-title=" + obj.title + " data-idx=" + obj.idx + " onclick='goUpdateForm(this)'>수정화면</button></span>&nbsp;";
				listHtml += "<button class='btn btn-warning btn-sm' onclick='goDelete(" + obj.idx + ")'>삭제</button>";
			} else {
				listHtml += "<br/>";
				listHtml += "<span><button disabled class='btn btn-success btn-sm' data-title=" + obj.title + " data-idx=" + obj.idx + " onclick='goUpdateForm(this)'>수정화면</button></span>&nbsp;";
				listHtml += "<button disabled class='btn btn-warning btn-sm' onclick='goDelete(" + obj.idx + ")'>삭제</button>";
			}
			listHtml += "</td>";
			listHtml += "</tr>";
		});
		
		// 로그인을 해야 보이는 부분
		if(${!empty mvo}) {
			listHtml += "<tr>";
			listHtml += "<td colspan='5'>";
			listHtml += "<button class='btn btn-primary btn-sm' onclick='goForm()'>글쓰기</button>";
			listHtml += "</td>";
			listHtml += "</tr>";
		}
		listHtml += "</table>";
		$("#view").html(listHtml);
		goForm("L");
	}
	
	function goContent(idx) {
		if($("#c"+idx).css("display") == "none") {
			var objParam = {
				"idx" : idx
			}
// 			$.ajax({
// 				url : "board/" + idx,
// 				type : "get",
// 				dataType : "json",
// 				success : function(data){
// 					$("#ta" + idx).val(data.content);
// 					fnAddCount(idx);
// 				},
// 				error : function(){
// 					alert("error");
// 				}
// 			});	
			
			// fetch로 변환
// 			fetch("board/" + idx)
// 				.then((response)=>response.json())
// 				.then((response)=>{
// 					$("#ta" + idx).val(response.content);
// 					fnAddCount(idx);
// 				});
			
			// async호출
			fetchAcync(idx);
			
			$("#c"+idx).css("display", "table-row"); // 보이게
			$("#ta"+idx).attr("readonly", true);
		} else {
			$("#c"+idx).css("display", "none");
		}
		
	}
	
	async function fetchAcync(idx) {
		const response = await fetch("board/" + idx);
		const result = await response.json();
		$("#ta" + idx).val(result.content);
		fnAddCount(idx);
	}
	
	function fnAddCount(idx) {
		var objParam = {
			"idx" : idx
		}
		$.ajax({
			url : "board/count/" + idx,
			type : "put",
			data : objParam,
			beforeSend: function(xhr){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
				},
			dataType : "json",
			success : function(data){
				$("#ta" + idx).val(data.content);
				fnAddCount(idx);
			},
			error : function(){
				alert("error");
			}
		});	
	}
	
	function goForm(MODE) {
		$("#clear").trigger("click");
		if(MODE == 'L') {
			$("#view").show();
			$("#wForm").hide();
		} else {
			$("#view").hide();
			$("#wForm").show();
		}
	}
	
	function goInsert() {
		var fData = $("#frm").serialize();
		$.ajax({
			url : "board/new",
			type : "post",
			data : fData,
			beforeSend: function(xhr){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
				},
			success : loadList,
			error : function(){
				alert("error");
			}
		});
 	}
	
	function goDelete(idx) {
		$.ajax({
			url : "board/" + idx,
			type : "delete",
			beforeSend: function(xhr){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
				},
			success : loadList,
			error : function(){
				alert("error");
			}
		});	
	}
	
	function goUpdateForm(_this) {
		var idx = $(_this).data("idx");
		var title = $(_this).data("title");
		var newInput = "<input type='text' id='nt"+idx+"' class='form-control' value='"+ title +"'/>";
		var newButton = "<button class='btn btn-primary btn-sm' onclick='goUpdate("+idx+")'>수정</button>";
		$(_this).parent().prev().prev().attr("readonly", false);
		$(_this).parent().parent().parent().prev().find(".td_title").html(newInput);
		$(_this).parent().html(newButton);
	}
	
	function goUpdate(idx) {
		var title = $("#nt" + idx).val();
		var content = $("#ta" + idx).val();
		var paramObj = {
			"idx" : idx,
			"title" : title,
			"content" : content
		};
		$.ajax({
			url : "board/update",
			contentType : "application/json;charset=utf-8;",
			type : "put",
			beforeSend: function(xhr){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
				},
			data : JSON.stringify(paramObj),
			success : loadList,
			error : function(){
				alert("error");
			}
		});	
	}
</script>
</html>
