<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="include.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
   <style>
      div.row {
        width: 100%;
        display: flex;
        border: 1px solid #003458;
      }
      div.left {
        width: 45%;
      height:45%;
        float: left;
        box-sizing: border-box;
      }
      div.right {
        width: 50%;
        float: right;
        box-sizing: border-box;
      }

      span.red{
         color:red;
      }
      
      span.blue{
         color:blue;
      }
      
      span.gray{
         color:gray;
      }
      span.yellow{
      	color:yellow;
      }
      span.black{
         color:black;
      }
    </style>
</head>
<body>
<h1>실시간 주식 Vi 목록 </h1>

<form>
	<button type="button" class="btn btn-primary" onclick="location.href='/board/list'" id="register">자유게시판</button>
</form>


<div class="left table-responsive" id="StockList">
  <table class="table">
    <thead>
      <tr>
        <th scope="col">번호</th>
        <th scope="col">종목코드</th>
        <th scope="col">종목명</th>
        <th scope="col">발동가격</th>
        <th scope="col">상승률</th>
        <th scope="col">발동시간</th>
        <th scope="col">해제시각</th>
      </tr>
    </thead>
    <tbody id="tbody">
    <tr id="test">
     <td id="stk_id"></td>
     <td id="stk_cd"></td>
     <td id="stk_nm"></td>
     <td id="stk_pri"></td> 
     <td id="stk_inc"></td>
     <td id="stk_act"></td>
     <td id="stk_rel"></td>                          
   </tr>
  <!-- 커뮤니티이동 임시 -->
<!-- <button><h2><a href="http://localhost:8080/board/list" style="color:black" target="_blank">커뮤니티 이동</a></h2></button> -->

    </tbody>
  </table>
  
</div>

<div class="right table-responsive" id="StockNewsList">
  <table class="table">
    <thead>
      <tr>
     <!--    <th scope="col">기사제목</th>  -->
        <th scope="col">기사제목</th>
        <th scope="col">시간</th>
      </tr>
    </thead>
    <tbody id="tbody">
    <tr>
   <!--    <td id="news_title"></td>-->
    <td id="news_content"></td>  
     <td id="news_time"></td>                          
   </tr>
  </table>
</div>
<!-- <div class="right table-responsive" id="StockNewsList">
  <table class="table">
    <thead>
      <tr>
        <th scope="col">기사제목</th> 
        <th scope="col">특징주 기사제목</th>
        <th scope="col">시간</th>
      </tr>
    </thead>
    <tbody id="tbody">
    <tr>
      <td id="news_title"></td>
    <td id="news_content"></td>  
     <td id="news_time"></td>                          
   </tr>
  </table>
</div> -->

</div>


 
<script>
$( document ).ready(function() {

/*    이미 있던 데이터를 초기화시켜줌
   setInterval('$("#tbody").html("<tr><td id=stk_id><td id=stk_cd><td id=stk_nm><td id=stk_pri><td id=stk_inc><td id=stk_act><td id=stk_rel></tr>")', 10000);
 */
   //리스트 호출
   ajaxGetList();
    
   //ajax리로드
   setInterval("ajaxGetList()", 20000);

});

//vi 데이터 가져오기 (json 배열로 온걸 끄내쓰기)
 function ajaxGetList(){
   
   $.ajax({
       url: "/stock/ajax",
       type: "get",
       success: function(data){
          //ajax 데이터를 변경하기위해 변수 선언
          let stk_id = "";
          let stk_cd = "";
          let stk_nm = "";
          let stk_pri = "";
          let stk_inc = "";
          let stk_act = "";
          let stk_rel = "";
          
          for(let i=0; i<data.length; i++){
          
          // 상승률이 -인지 체크
          let rise = data[i].stk_inc.indexOf("-");
          
           stk_id += data[i].stk_id + "<br>"
          stk_cd += data[i].stk_cd + "<br>";
          stk_nm +="<a onclick=ajaxGetNews(`" +data[i].stk_nm+ "`)>" +data[i].stk_nm + "</a><br>";
          stk_pri += data[i].stk_pri + "<br>";
         // rise이 0이라면 블루(상승) 1이라면 레드(하락) 
          if(rise == 0){    
            stk_inc +="<span class='blue'>" +  data[i].stk_inc + "<span><br>";
         }else{
            stk_inc +="<span class='red'>" + data[i].stk_inc + "<span><br>";   
         }
      
         stk_act += data[i].stk_act + "<br>";
         
         if(data[i].stk_rel === "00:00:00"){
            stk_rel +="<span class='yellow'>" +  data[i].stk_rel + "<span><br>"
         }else{
            stk_rel +="<span class='black'>" +  data[i].stk_rel + "<span><br>";
         }
         //  console.log(aaa.replace(/\s/gi, ""));
         
         } // for end
          
            $("#stk_id").html(stk_id);
            $("#stk_cd").html(stk_cd);
            $("#stk_nm").html(stk_nm);
            $("#stk_pri").html(stk_pri);
            $("#stk_inc").html(stk_inc);
            $("#stk_act").html(stk_act);
            $("#stk_rel").html(stk_rel);
            
         //data.forEach(math => console.log(math));
       },
       error: function (request, status, error){
           alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
       }

   });
   
}
      //ajax 뉴스데이터
       function ajaxGetNews(strStk_nm){
      
   //   console.log(typeof strStk_nm);
       
      
        $.ajax({
          url: "/stock/ajaxNews",
          data: {"stknm" : strStk_nm},
          method: "GET",
          success: function(data){
            console.log("성공");
         //   let news_title = "";
            let news_content = "";
            let news_time = "";
            
            //서버에서 받아온 뉴스기사 list로 등록
            for(let i = 0; i<data.length; i++){
         //      news_title += data[i].news_company + "<br>"; 
               news_content +="<a href= "+ data[i].news_href + " target='_blank'>" +  data[i].news_title + "<br>";
               news_time += data[i].news_time + "<br>";
         
            }

         //   $("#news_title" ).html(news_title);
            $("#news_content").html(news_content);
            $("#news_time").html(news_time);
             
          },
          error: function (request, status, error){
               alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
           }
       });
    }
    

</script>


</html>
