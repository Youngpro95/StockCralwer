<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>access denied page</h1>
<!-- Access Deined의 경우 403 에러 메시지가 발생한다. 그럴 경우 아래의 메시지가 출력이 된다. -->
<h2><c:out value="${SPRING_SECURITY_403_EXCEPTION.getMessage()}"></c:out></h2>
<h2><c:out value="${msg}"></c:out></h2>
</body>
</html>