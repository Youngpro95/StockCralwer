<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %>

    
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
    
    <!-- 구글로그인 -->
    <meta name="google-signin-scope" content="profile email">
    <meta name="google-signin-client_id" content="48622415722-25jn44tcscqekpdc9sbbdpvhvrvju33v.apps.googleusercontent.com">
    <script src="https://apis.google.com/js/platform.js" async defer></script>

	<!-- 카카오로그인 -->
	<script src = "//developers.kakao.com/sdk/js/kakao.min.js"></script>

</head>

<body>

			<!-- 네이버로그인 -->
			  <%
			    String clientId = "GIWNyqhDWRzAcKMrbkIH";//애플리케이션 클라이언트 아이디값";
			    String redirectURI = URLEncoder.encode("http://localhost:8080/member/callback", "UTF-8");
			    SecureRandom random = new SecureRandom();
			    String state = new BigInteger(130, random).toString();
			    String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
			    apiURL += "&client_id=" + clientId;
			    apiURL += "&redirect_uri=" + redirectURI;
			    apiURL += "&state=" + state;
			    session.setAttribute("state", state);
			 %>

		

			
			
		

     <div class="container">
        <div class="row">
 			<div class="col-xs-6">
                <div class="login-panel panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">회원가입</h3>
                    </div>
                    <div class="panel-body">
       
                    <form role="form" action="/member/userJoin" method="post" id="userData"> 
                            <fieldset>
                            		아이디 <label class="idCheck" style="color:red" ></label>
                                <div class="form-group">
                                    <input class="form-control" placeholder="아이디는 6글자이상" autofocus name="MemberID" value="${idCheck}" id="idCheck">
                                </div>
                                	비밀번호
                                <div class="form-group">
                                    <input class="form-control" placeholder="비밀번호는 최소 8자리에 영문,숫자 포함" name="MemberPw" type="password" id="pwCheck">
                                </div>
         				                        비밀번호 확인
                                <div class="form-group">
                                    <input class="form-control" placeholder="비밀번호 확인" name="MemberPw2" type="password" value="">
                                </div>

                                	이름
                                <div class="form-group">
                                    <input class="form-control" placeholder="Name" name="MemberName" type="Name" value="${nameCheck}" id="nameCheck"> 
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
                                
							 	<button type="submit" class="btn btn-lg btn-success btn-block" id="registerClick">회원 가입</button>
							 	<button type="button" class="btn btn-lg btn-block" onclick="window.location.href='/board/list'">취소</button>
							 	
                            </fieldset>
                        </form>
                    </div>
                </div>
            </div>
            
            <div class="col-xs-6">
                <div class="login-panel panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">SNS 로가입하기</h3>
                    </div>
                    <div class="panel-body">
                    
                        <form role="form"> 
			
			<!-- 네이버로그인 -->
			  <a href="<%=apiURL%>"><img height="45.8" src="http://static.nid.naver.com/oauth/small_g_in.PNG"/></a>
			<!-- 네이버로그인 -->  
			
			<!-- 구글로그인 -->  
			  <div class="g-signin2" data-onsuccess="onSignIn" data-theme="dark"></div>
			<!-- 구글로그인 -->



			<!-- 카카오로그인  url 노출! 일단 사용 X
			<a href="https://kauth.kakao.com/oauth/authorize
			?client_id=fc856b9616fca6337845a59c3410831c
			&redirect_uri=http://localhost:8080/member/kakaoLogin
			&response_type=code">
			<img src="//mud-kage.kakao.com/14/dn/btqbjxsO6vP/KPiGpdnsubSq3a0PHEGUK1/o.jpg" width="300"/>
			</a>
			-->

				<!-- 카카오로그인 -->
				<a id="kakao-login-btn"></a>
				<!-- 카카오로그인 -->

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


		<!-- 카카오로그인 -->
		<script>
			Kakao.init('dd984359806751d456a449dcaec71a30'); //아까 카카오개발자홈페이지에서 발급받은 자바스크립트 키를 입력함
			 
			//카카오 로그인 버튼을 생성합니다. 
			Kakao.Auth.createLoginButton({ 
			    container: '#kakao-login-btn', 
			    success: function(authObj) { 
			           Kakao.API.request({
			               url: '/v2/user/me',
			               success: function(res) {
			//                      console.log(res.id);//<---- 콘솔 로그에 id 정보 출력(id는 res안에 있기 때문에  res.id 로 불러온다)
			//                      console.log(res.kaccount_email);//<---- 콘솔 로그에 email 정보 출력 (어딨는지 알겠죠?)
			//                      console.log(res.properties['nickname']);//<---- 콘솔 로그에 닉네임 출력(properties에 있는 nickname 접근 
				                 // res.properties.nickname으로도 접근 가능 )
			                     console.log(authObj.access_token);//<---- 콘솔 로그에 토큰값 출력
			                     window.location.replace("http://localhost:8080/member/kakaoLogin?token=" +authObj.access_token)
			//           var kakaonickname = res.properties.nickname;    //카카오톡 닉네임을 변수에 저장 (닉네임 값을 다른페이지로 넘겨 출력하기 위해서)
			                     
			//           window.location.replace("http://" + window.location.hostname + ( (location.port==""||location.port==undefined)?"":":" + location.port) + "/member/kakaoLogin?kakaonickname="+kakaonickname);
			          //로그인 결과 페이지로 닉네임 값을 넘겨서 출력시킨다.,
			                   }
			                 })
			               },
			               fail: function(error) {
			                 alert(JSON.stringify(error));
			               }
			             });
			</script>
			<!-- 카카오로그인 -->

			<!-- 구글로그인 -->
		    <script>
		      function onSignIn(googleUser) {
		        // Useful data for your client-side scripts:
		        var profile = googleUser.getBasicProfile();
		        console.log("ID: " + profile.getId()); // Don't send this directly to your server!
		        console.log('Full Name: ' + profile.getName());
		        console.log('Given Name: ' + profile.getGivenName());
		        console.log('Family Name: ' + profile.getFamilyName());
		        console.log("Image URL: " + profile.getImageUrl());
		        console.log("Email: " + profile.getEmail());
			
		        // The ID token you need to pass to your backend:
		        var id_token = googleUser.getAuthResponse().id_token;
		        console.log("ID Token: " + id_token);
		      
		        
				$.ajax({
					  url:"/member/googlelogin",
					  type:"post",
					  contentType: 'application/json; charset=UTF-8',
					  data: JSON.stringify({
						  "idToken" : id_token
					  }),
					  success: function (data) {
						console.log("성공");
						window.location.href = "/board/list";
					  },
					  
					  error : function(xhr,status,error) {
						console.log(error);
					  },
				});
				
		      }
		    </script>
			<!-- 구글로그인 -->



<script type="text/javascript">


$(document).ready(function () {
	
	var checkRegister = 0;

	checkRegister = ${registerCheck} + 0;
	
	if(checkRegister === 1){
		alert("회원가입 실패! 정보들을 다시 확인해주세요!");
	}else if(checkRegister === 2){
		alert("비밀번호는 최소8자리 이상 12글자미만 \n 영문,숫자 포함해서 작성해주세요!");
 		checkIDBoolean = true;
	}else if(checkRegister === 3){
		alert("입력하신 비밀번호와 비밀번호 확인이 다릅니다 확인해주세요!");
 		checkIDBoolean = true;
	}

});

</script>

<script type="text/javascript">
	
	var checkIDBoolean = false;
	var checkNickBoolean = false;
	// id등록창 변경시 ajax로 id 중복체크
	$("#idCheck").change(function() {
		
		var checkChange=" ";
		$.ajax({
			  type:"get",
			  url:"/member/idCheck",
			  data:{
				  "MemberID" : $("#idCheck").val()
			  },
			  success: function (data) {
				console.log("성공--"+ data);			  
		
				if($("#idCheck").val().length <=6){
					checkChange = "*아이디가 너무 짧습니다(6글자 이상으로 생성해주세요)*"
					$("#idCheck").focus();
				}else if($("#idCheck").val().length >=10){
					checkChange = "*아이디가 너무 깁니다(10글자 미만 으로 생성해주세요)*"
					$("#idCheck").focus();
				}else if(data === 0){
					checkChange = "*사용가능합니다*"
					checkIDBoolean = true;
				}else if(data === 2){
					checkChange = "*아이디에는 특수문자가 포함될수없습니다."
					checkIDBoolean = false;
					$("#idCheck").focus();
				}else{
					checkChange = "*이미 존재하는 아이디입니다*"
					checkIDBoolean = false;
					$("#idCheck").focus();
				}
				$(".idCheck").html(checkChange);
				console.log(checkIDBoolean);
			  },
			  
			  error : function(xhr,status,error) {
				console.log(error);
			  },
		});
	});
	
	
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
					checkNickBoolean	= true;		
				}else if(data === 1){
					checkChange = "이미 존재하는 닉네임입니다."
					$("#nickCheck").focus();
					checkNickBoolean	= false;
				}else if(data === 2){
					checkChange = "닉네임이 길이를 확인해주세요."
					$("#nickCheck").focus();
					checkNickBoolean	= false;
				}
				
				$(".nickCheck").html(checkChange);
			  },
			  
			  error : function(xhr,status,error) {
				console.log(error);
			  },
		});
	});	
	
	
		//회원가입 클릭시 1차검증 or 서버로 보내기
		$("#registerClick").click(function(e){
			
			e.preventDefault();
			
			var check = false;

			const regexID = /^[A-Za-z]{1}[A-Za-z0-9]{5,9}$/; // 6글자 10글자 첫글자숫자 X
			const regexName = /^[가-힣a-zA-Z]{2,10}$/; // 한글 영문만가능 2글자~10글자
			const regexNick = /^[\w\Wㄱ-ㅎㅏ-ㅣ가-힣]{2,10}$/; //닉네임 2글자~10글자
			const regexPhone = /^[0-9]{10,11}$/; //숫자 10~11글자만 허용
			const regexEmail = /^[a-z0-9\.\-_]+@([a-z0-9\-]+\.)+[a-z]{2,6}$/;	//이메일형식


			//id 길이 6~10사이/ 한글,특수문자 포함금지
			if (regexID.test($("#idCheck").val()) === false) {
				$("#idCheck").focus();
				alert("아이디를 정확히 입력해주세요 \n 한글,특수문자 아이디는 불가능합니다. \n* 아이디는 6글자 이상 10글자 미만입니다");
				check = true;
				return;
			}
				check = false;
			
			if ($("#pwCheck").val() == "" || $("#pwCheck").val().length <8 || $("#pwCheck").val().length >=12) {
				$("#pwCheck").focus();
				alert("비밀번호를 정확히 입력해주세요 \n * 비밀번호는 최소 8글자 이상 12글자 미만입니다");
				check = true;
				return;
			}
				check = false;

			//이름은 특수문자금자 1~20글자 사이	
			if (regexName.test($("#nameCheck").val()) === false) {
				$("#nameCheck").focus();
				alert("이름을 정확히 입력해주세요  \n* 이름은 2글자 이상 10글자 미만입니다.");
				check = true;
				return;
			}
				check = false;
			
			//닉네임
			if (regexNick.test($("#nickCheck").val()) === false) {
				$("#nickCheck").focus();
				alert("닉네임을 정확히 입력해주세요  \n* 닉네임은 2글자 이상 10글자 미만입니다");
				check = true;
				return;
			}
				check = false;
				
			//한글 금지, 11~12글자사이	
			if (regexPhone.test($("#phoneCheck").val()) === false) {
				$("#phoneCheck").focus();
				alert("연락처를 정확히 입력해주세요 \n 01012341234 형태로 작성해주세요.");
				check = true;
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
			console.log("checkIDBoolean----"+ checkIDBoolean);
			
			if(checkIDBoolean === true && check === true && checkNickBoolean === true){
				$("#userData").submit();
				console.log("데이터 보내기 성공");				
			}else{
				alert("회원가입정보를 확인해주세요");
			}
			
		});
</script>	
		


</body>

</html>
