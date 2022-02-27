<!DOCTYPE html>
<html lang="en">
<head>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta charset="utf-8" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>Page Title - SB Admin</title>
<link href="/resources/css/styles.css" rel="stylesheet" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/js/all.min.js"
	crossorigin="anonymous"></script>

<style>
p {
	border: 1px solid gray
}
</style>

</head>
<body class="bg-primary">
	

	<div id="layoutAuthentication">
		<div id="layoutAuthentication_content">
			<main>
				<div class="container">
					<div class="row justify-content-center">
						<div class="col-lg-7">
							<div class="card shadow-lg border-0 rounded-lg mt-5">
								<div class="card-header">
									<h3 class="text-center font-weight-light my-4">Create
										Account</h3>
								</div>
								<div class="card-body">

									<form action="/board/register" method="post" id="uploadForm">

										<label for="title">제목</label> <input type="text"
											class="form-control" placeholder="title" name="title"
											id="title"> <label for="content">내용</label>
										<textarea class="form-control" rows="3" placeholder="content"
											name="content" id="content"></textarea>

										<label for="writer">작성자</label> <input type="text"
											class="form-control" placeholder="Writer" name="writer"
											id="writer" readonly="readonly" value="${memberNick}">
										<br>
										<!--    <input type="file" multiple="multiple"id="file" name="file"> -->
										<input type="file" id="file" name="file">
										<div id="views"></div>

										<br>
										<button type="button" class="btn btn-primary"
											onclick="register()" id="create">등록</button>
										<button type="button" class="btn btn-danger"
											onclick="location.href='/board/list'">취소</button>

									</form>
								</div>
								<div class="card-footer text-center">
									<div class="small">
										<a href="login.html">Have an account? Go to login</a>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</main>
		</div>
		<div id="layoutAuthentication_footer">
			<footer class="py-4 bg-light mt-auto">
				<div class="container-fluid">
					<div
						class="d-flex align-items-center justify-content-between small">
						<div class="text-muted">Copyright &copy; Your Website 2020</div>
						<div>
							<a href="#">Privacy Policy</a> &middot; <a href="#">Terms
								&amp; Conditions</a>
						</div>
					</div>
				</div>
			</footer>
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>
	<!--    <script src="/resources/js/scripts.js"></script>  -->

	<script>
   
  
   $(document).ready(function (){

	   let memberCheck = "${memberid}" + "";
		
	   // 비정상적인 경로로 접근했을경우 로그인페이지로 이동
		if(!memberCheck){
			console.log("로그인안됨." + memberCheck);
			alert("로그인후 이용하세요.");
			location.href="/controller/member/login";
		}
   });
   
   
   //등록시 공백체크 리턴문안먹는다.
  function register(){
	   let title = $("#title").val();
	   let content = $("#content").val();
		   if(title.replace(/\s| /gi, "").length == 0 ){
			   $("#title").focus();
			   alert("제목을 입력하세요")
			   return;
		   }else if(content.replace(/\s| /gi, "").length == 0 ){
			   $("#content").focus();
			   alert("내용을 입력하세요")
			   return;   
		   }else{
			   $("#uploadForm").submit();
		   }
	};
   
   var number = 0; //파일 개수제한을 위한변수
        $("#file").change(function(){
        	
           var formData = new FormData();
           formData.set("bno", 0);
         // input file 값 가져오기
         var inputFile = $("input[name='file']");
         
         var files = inputFile[0].files;
         
         for(var i = 0; i < files.length; i++){

        	var extName = files[i].name; //파일이름
            //파일 이름에서 뒤에부터 . 을찾아서 그 인덱스의 +1 번쨰를 문자를 뗴고, 다소문자로변경
            var extName3 = extName.substring(files[i].name.lastIndexOf(".") +1).toLowerCase();
            console.log("파일이름 :" + extName);
            console.log("확장자명 :" + extName3);
        	
            //파일 개수 제한
            if(number > 2){
        		alert("파일개수는 최대 3개입니다");
        		return;
        	}

			//파일 용량 5메가로 제한
        	console.log(files[i].size);
        	if(files[i].size > 10 * 1024 * 1024){
        		alert("파일 용량이 너무 큽니다.");
        		return
        	}
            
            //파일 확장자 검증
            if(extName3 != "jpg" && extName3 != "png" && extName3 != "txt" && extName3 != "gif" && extName3 != "jpeg"){
               alert("png, jpg ,txt 파일만 가능합니다");
               $("#file").val(""); //파일목록 비우기
               return;   
            }
            
			//이클립스 3초대기..            
            if(extName3 == "png" || extName3 == "jpg" && extName3 != "gif" && extName3 != "jpeg" ){
            	console.log("png입니다~");
            	alert("이미지 업로드시 3초정도 로딩시간이 걸립니다.");
            }


            formData.append("file", files[i]);
         
         }

         //processData, contentType는 false로 지정
          $.ajax({
                type : 'post',
                url : '/upload/uploadAjax',
                data : formData,
                processData : false,
                contentType : false,
                success : function(data) {
                    $("#file").val(""); //파일목록 비우기
                    ++number;  //파일 개수 +1
        			console.log("number--------" + number);
               if(extName3 != "jpg" && extName3 != "png"){
		         var str ="<p id='ptest'>" +data.substring(data.lastIndexOf("_")+1)+ "<input type=button value=삭제 id='fileRemoveBtn' onclick=fileRemove(`"+data.replace( /\s/g, "!@#")+"`)></p>" 
               }else{
             	   var str ="<p id='ptest'><img src='/resources/images/"+data+"'/>" +data.substring(data.lastIndexOf("_")+1)+ "<input type=button value=삭제 id='fileRemoveBtn' onclick=fileRemove(`"+data.replace( /\s/g, "!@#")+"`)></p>"
               }
               
               $("#views").append(str);
               
                },
                error : function(error) {
                    alert("err");
                   
                } 
             });      
        });
        
        //파일 삭제 ajax 통신
        function fileRemove(data){
        	console.log("클리이익------"+data);
        	$.ajax({
   			    url:"/upload/removeUploadAjax", 
   			    type:"post",
   			    contentType: "application/json; charset=utf-8",
   			    data : JSON.stringify({
   			    	uid_FileName : data
   			    }),
   			    success: function(data) {
						alert("파일삭제 성공");
   			    },
   			    error: function(err) {
   						alert("파일삭제 실패");
   			    }
   			});
   	      
         } 
        
        //파일 웹에 삭제
         $(document).on("click", "#fileRemoveBtn", function(data){
         	console.log("클래스클릭");
         	$(this).parent().html('').empty();
//          	$(this).unwrap().remove();
         	number--; //파일 개수 -1
         	console.log("number삭제 ---- " + number);
        });
        
        
        </script>
</body>
</html>