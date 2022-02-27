<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	ifram{
		width: 600px;
		height: 100px;
		border: 1px;
		border-style: solid;
	}

</style>

</head>
<body>


	 <!-- target을 지정한곳으로 form data가 이동 -->
	<form id = "form1" target="iframePhoto" action="/upload/uploadForm" method="post" enctype="multipart/form-data">
		<input type="file" name="file">
		<input type="submit" value="업로드">
	</form>
	
	<iframe name="iframePhoto"></iframe>



<script type="text/javascript">

	function addFilePath(msg){
		console.log(msg); //파일명 콘솔 출력
		document.getElementById("form1").reset(); //ifream에 업로드 결과 출력후 form에 저장된 데이터 리셋
	}
</script>

</body>
</html>