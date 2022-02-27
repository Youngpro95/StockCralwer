<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="include.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="layout-box">
<h2>modify</h2>
<form action="/board/modify2" method="post">
번호
<input type="text" class="form-control" name="bno" value='${list.bno }' readonly="readonly">
제목
<input type="text" class="form-control" name="title" value='${list.title }'>
내용
<textarea class="form-control" rows="3" name="content" >${list.content }</textarea>
작성자
<input type="text" class="form-control" name="writer" value='${list.writer }' readonly="readonly">
<button type="submit" class="btn btn-success" >수정</button>
<button type="button" class="btn btn-danger" onclick="location.href='/board/delete?bno=${list.bno}'">삭제</button>
<button type="button" class="btn btn-default" onclick="location.href='/board/list'">목록</button>
</form>
</div>
</body>
</html>