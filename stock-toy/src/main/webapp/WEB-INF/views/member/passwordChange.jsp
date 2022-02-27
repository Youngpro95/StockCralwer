<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ include file="../board/include.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>SB Admin 2 - Bootstrap Admin Theme</title>

    <!-- Bootstrap Core CSS -->
    <link href="/resources/css/bootstrap.min.css" rel="stylesheet">

    <!-- MetisMenu CSS -->
    <link href="/resources/vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="/resources/css/sb-admin-2.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="/resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>

<body>
    <div class="container">
        <div class="row">
            <div class="col-md-4 col-md-offset-4">
                <div class="login-panel panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">Please Sign In</h3>
                    </div>
                    <div class="panel-body">
                        <form role="form" action="/member/passwordChange" method="post">
                            <fieldset>
<!--                             	<div class="form-group"> -->
<%--                                     <input class="form-control" name="MemberID" type="hidden" value="${memberid}"> --%>
<!--                                 </div> -->
                            
                                <div class="form-group">
                                    <input class="form-control" placeholder="현재 비밀번호" name="MemberPw" type="password" autofocus>
                                </div>
                                <div class="form-group">
                                    <input class="form-control" placeholder="새 비밀번호" name="MemberPw2" type="password">
                                </div>
                                <div class="form-group">
                                    <input class="form-control" placeholder="새 비밀번호 확인" name="MemberPw3" type="password">
                                </div>
                                <!-- Change this to a button or input when using this as a form -->
								<button type="submit" class="btn btn-lg btn-success btn-block">비밀번호 변경</button>
								<button type="button" class="btn btn-lg btn-block" onclick="window.location.href='/member/myPage';">취소</button>
                            </fieldset>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- jQuery -->
    <script src="/resources/vendor/jquery/jquery.min.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="/resources/vendor/bootstrap/js/bootstrap.min.js"></script>

    <!-- Metis Menu Plugin JavaScript -->
    <script src="/resources/vendor/metisMenu/metisMenu.min.js"></script>

    <!-- Custom Theme JavaScript -->
    <script src="/resources/dist/js/sb-admin-2.js"></script>

<script type="text/javascript">

$(document).ready(function () {
	
	if("${pwNon}"){
		alert("${pwNon}");
	}else if("${pwChangeOk}"){
		alert("${pwChangeOk}");
	}else if("${pwCheck}"){
		alert("${pwCheck}");
	}else if("${pwChangeNon}")
		alert("${pwChangeNon}");

});



</script>


</body>




</html>
