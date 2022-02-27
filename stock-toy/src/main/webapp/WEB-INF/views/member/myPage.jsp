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
 			<div class="col-xs-6">
                <div class="login-panel panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">회원정보 수정</h3>
                    </div>
                    <div class="panel-body">
                    
                            
							아이디
		                   <div class="form-group">
		                      <input class="form-control" placeholder="Name" name="MemberID" type="Name" value="${memberid}" id="idCheck" readonly="readonly"> 
		                   </div> 
		                               
                           <form role="form" action="/member/myPageUpdate" method="post" id="userData"> 
                            <fieldset>
                                	이름
                                <div class="form-group">
                                    <input class="form-control" placeholder="Name" name="MemberName" type="Name" value="${memberName}" id="nameCheck"> 
                                </div>
                                	닉네임<label class="nickCheck" style="color:red" ></label>
                                <div class="form-group">
                                    <input class="form-control" placeholder="Nick" name="MemberNick" type="Nick" value="${nickCheck}" id="nickCheck">
                                </div>
                                	연락처
                                <div class="form-group">
                                    <input class="form-control" placeholder="01012341234 형태로 작성해주세요" name="MemberPhone" type="Phone" value="${phoneCheck}" id="phoneCheck">
                                </div>
                                	이메일
                                <div class="form-group">
                                    <input class="form-control" placeholder="E-mail" name="MemberEmail" type="email" value="${emailCheck}" id="emailCheck">
                                </div>
                                
							 	<button type="button" class="btn btn-lg btn-success btn-block" id="updateClick">정보 수정</button>
							 	<button type="button" class="btn btn-lg btn-block" id="updateCancel" onclick="window.location.href='/board/list'">취소</button> 
							 	
                            </fieldset>
                        </form>
                    </div>
                </div>
            </div>
            
            <div class="col-xs-6">
                <div class="login-panel panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">Please Sign In</h3>
                    </div>
                    <div class="panel-body">
                    
                        <form role="form" action="" method="" id=""> 
                            <fieldset>
							 	<button type="button" class="btn btn-lg btn-success btn-block" onclick="window.location.href='/member/passwordChange'">비밀번호 변경</button>
							 	<button type="button" class="btn btn-lg btn-danger btn-block" onclick="window.location.href='/member/memberWithdrawal'">회원 탈퇴</button>							 	
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

<script>


	
	$(document).ready(function(){

		
		let memberCheck = "${memberid}" + "";
			
		   // 비정상적인 경로로 접근했을경우 로그인페이지로 이동
			if(!memberCheck){
				console.log("로그인안됨." + memberCheck);
				alert("로그인후 이용하세요.");
				location.href="/member/login";
			}
		   
	 		   $.ajax({
	 				type: "post",
	 				url : "/member/getMyPage",
				    data :{"memberid" : "${memberid}"},
	 			   	success : function(data){
	 			   		console.log(data.memberPhone);
	 			   		$("#nameCheck").val(data.memberName);
	 			   		$("#nickCheck").val(data.memberNick);
	 			   		$("#phoneCheck").val(data.memberPhone);
	 			   		$("#emailCheck").val(data.memberEmail);
	 			   	},error : function(error){
	 			   		console.log("실패");
	 			   	} 
	 		   });
		
	});
	
	var checkNickBoolean = false;
	
	//닉네임 중복체크
	$("#nickCheck").change(function() {
		
		var checkChange=" ";
		
		$.ajax({
			  type:"get",
			  url:"/member/nickCheck",
			  data:{
				  "memberNick" : $("#nickCheck").val()
			  },
			  success: function (data) {
				console.log("성공--"+ data);
				if(data ===0){
					checkChange = "*사용가능합니다."
					checkNickBoolean= true;		
				}else if(data === 1){
					checkChange = "이미 존재하는 닉네임입니다."
					$("#nickCheck").focus();
					checkNickBoolean= false;
				}else if(data === 2){
					checkChange = "닉네임이 길이를 확인해주세요."
					$("#nickCheck").focus();
					checkNickBoolean= false;
				}
				
				$(".nickCheck").html(checkChange);
			  },
			  
			  error : function(xhr,status,error) {
				console.log(error);
			  },
		});
	});	
	
	
	
	//정보수정 클릭시 1차검증 or 서버로 보내기
	$("#updateClick").click(function(e){
		
		e.preventDefault();
		
		var check = false;

		const regexID = /^[A-Za-z]{1}[A-Za-z0-9]{5,9}$/; // 6글자 10글자 첫글자숫자 X
		const regexName = /^[가-힣a-zA-Z]{2,10}$/; // 한글 영문만가능 2글자~10글자
		const regexNick = /^[\w\Wㄱ-ㅎㅏ-ㅣ가-힣]{2,10}$/; //닉네임 2글자~10글자
		const regexPhone = /^[0-9]{10,11}$/; //숫자 10~11글자만 허용
		const regexEmail = /^[a-z0-9\.\-_]+@([a-z0-9\-]+\.)+[a-z]{2,6}$/;	//이메일형식
		
		//이름은 특수문자금자 1~20글자 사이	
			if (regexName.test($("#nameCheck").val()) === false) {
			$("#nameCheck").focus();
			alert("이름을를 정확히 입력해주세요  \n* 이름은는 1글자 이상 20글자 미만입니다.");
			check = true;
			return;
		}
			check = false;
		//닉네임 
			if (regexNick.test($("#nickCheck").val()) === false) {
			check = true;
			$("#nickCheck").focus();
			alert("닉네임을 정확히 입력해주세요  \n* 닉네임은 3글자 이상 10글자 미만입니다");
			return;
		}
			check = false;
			
		//한글 금지, 11~12글자사이	
			if (regexPhone.test($("#phoneCheck").val()) === false) {
			check = true;
			$("#phoneCheck").focus();
			alert("연락처를 정확히 입력해주세요");
			return;
		}

			check = false;
		//이메일
			if (regexEmail.test($("#emailCheck").val()) === false) {
				$("#emailCheck").focus();
				alert("이메일을 정확히 입력해주세요.");
				check = true;
				return;
			}
		
		
			check = true;
		console.log("check----"+ check);
		
		if(check === true && checkIDBoolean	=== true){
			$("#userData").submit();
			alert("정보수정 완료");
		}else{
			alert("정보수정 실패");
		}
		
	});	

	

</script>



</body>

</html>
