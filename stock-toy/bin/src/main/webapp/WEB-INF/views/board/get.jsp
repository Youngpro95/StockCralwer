<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="include.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
.reply-list {
	padding: 10px;
	border-style: groove;
}

.test1 {
	padding: 10px;
	border-style: groove;
}
</style>
</head>
<body>
<script type="text/javascript" src="/resources/js/common.js"></script>


	<div class="layout-box">
		<h2>get</h2>
		번호 <input type="text" class="form-control" value='${list.bno }'
			readonly="readonly"> 제목 <input type="text"
			class="form-control" value='${list.title }' readonly="readonly">
		내용
		<textarea class="form-control" rows="3" readonly="readonly">${list.content }</textarea>
		작성자 <input type="text" class="form-control" value='${list.writer }'
			readonly="readonly">
		<button type="button" class="btn btn-success"
			onclick="location.href='/board/modify?bno=${list.bno}'">수정</button>
		<button type="button" class="btn btn-default"
			onclick="location.href='/board/list?'">목록</button>
	</div>

	<div class="reply-input layout-box">
		댓글
		<textarea class="form-control" rows="3" placeholder="댓글을 작성해 주세요"
			id="reply"></textarea>
		<input type="text" placeholder="작성자를 작성해 주세요" id="replyer"> <br>
		<button class="commentReg btn btn-default btn-xs">등록</button>
	</div>

	<div class="reply-list layout-box" id="reply-list">
	
	</div>

<script>
$(document).ready(function () {
	
	app(); //즉시실행함수댓글리스트

});


	//즉시 실행함수(댓글불러오기)
	var app = function () {
	
		var str ="";
		$.ajax({
		    url:"/replies/${list.bno}", //request 보낼 서버의 경로
		    type:"get",
		    dataType:"json",
		    success: function(data) {
		    	$.each(data, function(index, item) {
		/*     		str +=	"<div class=test1 id=" + data[index].rno + ">" 
		    		str +=	"<li class=rno data-rno='"+ data[index].rno +"'>" + "댓글번호:" +   data[index].rno + "</li>" 
		    		str +=	"<li class=reply data-reply='"+ data[index].reply +"'>" + "내용:" +data[index].reply + "</li>" 
		    		str +=	"<li>" + "작성자:" + data[index].replyer + "</li>" 
		    		str +=	"<button name='list-update' class='btn btn-info btn-xs'>" +"수정"+ "</button>" 
		    		str +=	"<button name='list-delete' class='btn btn-danger btn-xs'>" +"삭제"+ "</button>" 
		    		str +=	"</div>" */
		    		
		    		str +=	"<div class=test1 id=" + data[index].rno + ">" 
		    		str +=	"<input class=rno type=hidden data-rno ='"+ data[index].rno +"' value ="+ data[index].rno + ">"
		    		str +=	"<li><input class=reply type=hidden data-reply='"+ data[index].reply +"'>" + "내용:" +data[index].reply + "</li>" 
		    		str +=	"<li>" + "작성자 :" + data[index].replyer + "</li>" 
		    		str +=	"<button name='list-update' class='btn btn-info btn-xs'>" +"수정"+ "</button>" 
		    		str +=	"<button name='list-delete' class='btn btn-danger btn-xs'>" +"삭제"+ "</button>" 
		    		str +=	"</div>"
		    		
		    		$(".reply-list").html(str);

		    		/* $(".reply-list").append ("<div class=test1 id=" + data[index].rno + ">" +
							"<li class= rno data-rno='"+ data[index].rno +"'>" + data[index].rno + "</li>" +
							"<li class=reply data-reply='"+ data[index].reply +"'>" + "내용:" +data[index].reply + "</li>" +
							"<li>" + "작성자:" + data[index].replyer + "</li>" +
		    				"<button name='list-update'>" +"수정"+ "</button>" + 
		    				"<button name='list-delete'>" +"삭제"+ "</button>" + 
		    				"</div>") */
		    		
		    		// $(".reply-list").append("<br>" + data[index].rno  + "<br>" + data[index].reply + "<br>" + data[index].replyer + "<br>");
		    	})
		    },
		    error: function(err) {
					alert("error댓글")
		    }
		});
	}
	
	 //댓글 삭제
	 $(document).on("click", "button[name='list-delete']", function() {
	    
	       var index = $("button[name='list-delete']").index(this); 
	       console.log(index);
	        
	       var rno = $('.rno:eq( '+ index +')').data('rno');
	       console.log(rno);
	       
	        var msg = confirm("댓글을 삭제하시겠습니까?");
	        if(msg == true){
	        	
	        $.ajax({
			    url:"/replies/"+ rno, //request 보낼 서버의 경로
			    type:"delete",
			    dataType: "text",
			    contentType: "application/json; charset=utf-8",
			    data : JSON.stringify({
					rno : rno
			    }),
			    success: function(data) {
						$("#reply-list").html('');
						app();
						alert("삭제 성공")
			    },
			    error: function(err) {
						alert("error등록")

			    }
			});
	       } 
	        
		 }); //댓글 삭제end
		 
	//댓글수정
	 $(document).on("click", "button[name='list-update']", function () {
	    
	       var index2 = $("button[name='list-update']").index(this); 
	       
	       var rno2 = $('.rno:eq( '+ index2 +')').data('rno');
	       
	       var rno3 = $('.reply:eq( '+ index2 +')').data('reply');

	       
	       console.log(rno2);
	       console.log(rno3);
	      $("#" + rno2).html
	      ('<textarea class="form-control" rows="3" placeholder="댓글을 작성해 주세요" id = "replyupdate">'+ rno3 +'</textarea>' 
	      + '<button id="ok" onclick=replyup('+ rno2 +');> 확인  </button>' + '<button id="clear">취소</button>');
		
		 }); //댓글 end 
	      
		/*
	       클릭하면 > 해당 div id 를 가져와서 , 

	    textarea 안에 div 자식 내용을뿌려줌 ( 그리고 )   

 	       확인, 취소버튼을 만들고 , 확인 클릭시 (reply를 ajax 넘겨준다 ), ajax 호출 후 > 댓글 리로드 ,
	       취소 시 , 리로드
	        */
		 

// 	        $(document).on("click", "button[id='ok']"   
		function replyup(i) {
	
				var aaaa = $("#replyupdate").val();
				
				console.log(aaaa);
				
				console.log("확확인"+i);
				var rno2 = i;
				
		        $.ajax({
				    url:"/replies/" + rno2, //request 보낼 서버의 경로
				    type:"patch",
				    dataType: "text",
				    contentType: "application/json; charset=utf-8",
				    data : JSON.stringify({
						bno : ${list.bno},
				    	reply : aaaa
				    }),
				    success: function(data) {
							$("#reply-list").html('');
							app();
							alert("수정 성공")
				    },
				    error: function(err) {
							alert("error등록")

				    }
				});

		 };
		
		 //댓글 취소
		 $(document).on("click", "button[id='clear']", function (){
			 $("#reply-list").html('');
			 app();
		 });

		 
		 //댓글 등록
$(".commentReg").click(function () {
    if ( $.trim($("#reply").val()) == "") {
        alert("댓글 내용을 입력해주세요.");
        $("#reply").focus();
        return;
    }
    
    if ( $.trim($("#replyer").val()) == "") {
        alert("작성자를 입력해주세요.");
        $("#replyer").focus();
        return;
    }
	
	var test = $("#reply").val();
	var test2 = $("#replyer").val();
	
	$.ajax({
	    url:"/replies/${list.bno}", //request 보낼 서버의 경로
	    type:"post",
	    dataType: "text",
	    contentType: "application/json; charset=utf-8",
	    data : JSON.stringify({
	    	bno : ${list.bno},
	    	reply: test,
	    	replyer: test2
	    }),
	    success: function(data) {
				$("#reply").val('');
				$("#replyer").val('');
				$("#reply-list").html('');
				app();
				alert("등록 성공");
	    },
	    error: function(err) {
				alert("error등록")

	    }
	});

}); //등록 end
</script>

</body>
</html>
