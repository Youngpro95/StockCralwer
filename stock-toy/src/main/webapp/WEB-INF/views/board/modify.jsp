<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="include.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" http-equiv="Content-Type" content="text/html;">
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
<%-- <input type="text" class="form-control" name="writer" value='${list.writer }' readonly="readonly"> --%>
<input type="text" class="form-control" name="writer" value='${list.writer}' readonly="readonly">

      <input type="file" id="file" name="file" >
		<div id="views">

		</div>	
	<button type="submit" class="btn btn-success" >수정</button>
	<button type="button" class="btn btn-danger" onclick="location.href='/board/delete?bno=${list.bno}'">삭제</button>
	<button type="button" class="btn btn-default" onclick="location.href='/board/list'">목록</button>

</form>
</div>

<script type="text/javascript">
var number = 0; //파일 개수제한을 위한변수
$("#file").change(function(){
	
   var formData = new FormData();
   formData.set("bno",${list.bno});
	
   for (var key of formData.keys()) {

	   console.log(key);

	 }

	 for (var value of formData.values()) {

	   console.log(value);

	 }
   
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
        	
        	console.log("----------------")
			console.log("data----" + data);        	
        	console.log("----------------")
            $("#file").val(""); //파일목록 비우기
            number++;  //파일 개수 +1
			console.log("number--------" + number);

		     if(extName3 != "jpg" && extName3 != "png"){

             	var str ="<p id='ptest'>" +data.substring(data.lastIndexOf("_")+1)+ "<input type=button value=삭제 id='fileRemoveBtn' onclick=fileRemove(\'"+encodeURIComponent(data)+"\')></p>" 
		  
		     }else{

		    	 var str ="<p id='ptest'><img src='/resources/images/"+data+"'/>" +data.substring(data.lastIndexOf("_")+1)+ "<input type=button value=삭제 id='fileRemoveBtn' onclick=fileRemove(`"+encodeURIComponent(data)+"`)></p>"
               }
		     
       $("#views").append(str);
       
        },
        error : function(error) {
            alert("err");
           
        } 
     });      
});
</script>

<script charset="UTF-8">
let fileGet = "";
let ext = "";
let memberCheck = "${memberNick}" + "";

var number = 0; //파일 개수제한을 위한변수
(function () {
	console.log("즉시실행함수!");	
	
	console.log(typeof memberCheck);
	
	// 비정상적인 경로로 접근했을경우 로그인페이지로 이동
	if(!memberCheck || memberCheck != "${list.writer}"){
		console.log("로그인안됨." + memberCheck);
		alert("로그인후 이용하세요.");
// 		location.href="/member/login";
	}
	
	$.ajax({
		url: "/upload/uploadGet",
		type: "get",
		data: {"bno" : ${list.bno}},
		success: function(data) {
//				console.log("성공" + JSON.stringify(data));
//				console.log("성공" + JSON.stringify(data[0].file_Path));
			
			if(data != null){
				
				$.each(data, function(index, value){
					++number;
//						console.log("인덱스번호:" + index + " 값:" + value.file_Name);
//						console.log(data[index].file_Path);

					//text파일이 아니라면
					if(data[index].uid_FileName.lastIndexOf("txt") === -1){
						ext = value.file_Path;
						ext = ext.substring(ext.lastIndexOf("images")+6) + "\\" + value.uid_FileName.replaceAll(" ", "%20");
// 						fileGet += "<p><img src=/resources/images" + ext + "><button type=button onclick=fileRemove("+`ext`+") id='fileRemoveBtn'>삭제</button></p>"
						fileGet += "<p><img src=/resources/images" +ext+ ">" + value.file_Name + "</a><button type=button onclick=fileRemove(\'"+encodeURIComponent(value.file_Path+"\\"+value.uid_FileName)+"\') id='fileRemoveBtn'>삭제</button></p>";
						
					}else{
						ext = value.file_Path;
						ext = ext.substring(ext.lastIndexOf("images")+6) + "\\" + value.uid_FileName.replace(/\s| /gi, "!@#");
// 						fileGet += "<p><a href=/resources/images" +ext+ ">" + value.file_Name + "</a><button type=button onclick=fileRemove(\'"+value.file_Path+","+value.uid_FileName+"\') id='fileRemoveBtn'>삭제</button></p>";
						fileGet += "<p><a href=/resources/images" +ext+ ">" + value.file_Name + "</a><button type=button onclick=fileRemove(\'"+encodeURIComponent(value.file_Path+"\\"+value.uid_FileName)+"\') id='fileRemoveBtn'>삭제</button></p>";
						
						console.log(value.file_Path +"\\"+value.uid_FileName);
					}
				});
			}
			
			$("#views").html(fileGet);
		},
		error: function(err){
			console.log("실패");
		}
	});
})();
	
    //파일 삭제 ajax 통신
    function fileRemove(data){
		console.log("로그---" + data);
		let file_Path = decodeURIComponent(data);
		let file_Name = decodeURIComponent(data);	
		
			if(file_Path.indexOf("\\") == -1){
				console.log("파일네임 \\없음--  "+ file_Name);
			}else{
				file_Path = file_Path.substring(0,file_Path.lastIndexOf("\\"));
				console.log("파일경로--" + file_Path);
		 	
				file_Name = file_Name.substring(file_Name.indexOf("20")+11);
				console.log("파일네임--"+ file_Name);	

			}
			
		$.ajax({
			    url:"/upload/removeUploadAjax", 
			    type:"post",
			    contentType: "application/json; charset=utf-8",
			    data : JSON.stringify({
			    	uid_FileName : file_Name,
					file_Path : file_Path
			    }),
			    success: function(data) {
					console.log("삭제성공")
			    },
			    error: function(err) {
						alert("error삭제");
			    }
			});
	      
     }
    
    
    //파일 웹에 삭제
    $(document).on("click", "#fileRemoveBtn", function(data){
    	console.log("클래스클릭");
    	$(this).parent().html('').empty();
//     	$(this).unwrap().remove();
    	number--; //파일 개수 -1
    	console.log("number삭제 ---- " + number);
   });
    
</script>

</body>
</html>