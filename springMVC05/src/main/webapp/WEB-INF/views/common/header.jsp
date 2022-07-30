<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>
<nav class="navbar navbar-default">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
      <a class="navbar-brand" href='<c:url value="/"/>'>스프1탄</a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav">
        <li class="active"><a href='<c:url value="/"/>'>Home</a></li>
        <li><a href='<c:url value="/boardMain.do"/>'>게시판</a></li>
      </ul>
      <c:choose>
      	<c:when test="${empty mvo}">
   		  <ul class="nav navbar-nav navbar-right">
            <li><a href='<c:url value="/memLoginForm.do"/>'><span class="glyphicon glyphicon-user"></span>&nbsp;&nbsp;로그인</a></li>
            <li><a href='<c:url value="/memJoin.do"/>'><span class="glyphicon glyphicon-log-in"></span>&nbsp;&nbsp;회원가입</a></li>
	      </ul>
      	</c:when>
      	<c:otherwise>
      	  <ul class="nav navbar-nav navbar-right">
	      	<li>
	      	<c:choose>
				<c:when test="${empty mvo.memProfile}">
					<img class="img-circle" src='<c:url value="/resources/img/user.png"/>' style="width:50px;height:50px;"/>
				</c:when>
				<c:otherwise>
					<img class="img-circle" src='<c:url value="/resources/upload/${mvo.memProfile}"/>' style="width:50px;height:50px;"/>
				</c:otherwise>
			</c:choose>
			<span style="margin-left:10px;font-weight:bolder;">${mvo.memName}님 안녕하세요.</span>
	      	</li>
            <li><a href='<c:url value="/updateUserInfo.do"/>'><span class="glyphicon glyphicon-wrench"></span>&nbsp;&nbsp;회원정보수정</a></li>
            <li><a href='<c:url value="/userImgForm.do"/>'><span class="glyphicon glyphicon-picture"></span>&nbsp;&nbsp;사진등록</a></li>
            <li><a href='<c:url value="/memLogout.do"/>'><span class="glyphicon glyphicon-log-out"></span>&nbsp;&nbsp;로그아웃</a></li>
	      </ul>
      	</c:otherwise>
      </c:choose>
    </div>
  </div>
</nav>