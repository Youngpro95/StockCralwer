<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
파일이 업로드 됨.
파일명 : ${savedName}


<script>
	var result = "${saveName}";
	parent.addFilePath(result); //파일명을 부모페이지로 전달
</script>
</body>
</html>