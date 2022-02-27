<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
	language="java"%>
	
<%@include file="include.jsp"%>
<html lang="en">

<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />



<title>Tables - SB Admin </title>

<link href="/resources/css/styles.css" rel="stylesheet" />
<link
	href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css"
	rel="stylesheet" crossorigin="anonymous" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/js/all.min.js"
	crossorigin="anonymous"></script>

<style>
	nav.service-box {
		display: flex;
		align-items: center;
		justify-content: space-between;
		flex-direction: row-reverse;
	}
	
	.login{
		float : right;
		color : blue;
	}
</style>


  <!-- 구글로그인 클라이언트 아이디-->
    <meta name="google-signin-client_id" content="48622415722-25jn44tcscqekpdc9sbbdpvhvrvju33v.apps.googleusercontent.com">

</head>

<body class="sb-nav-fixed">
	<div id="layoutSidenav">
		<div id="layoutSidenav_nav">
			<nav class="sb-sidenav accordion sb-sidenav-dark"
				id="sidenavAccordion">
				<div class="sb-sidenav-menu">
					<div class="nav">
						<div class="sb-sidenav-menu-heading">Core</div>
						<a class="nav-link" href="#">
							<div class="sb-nav-link-icon">
								<i class="fas fa-tachometer-alt"></i>
							</div> 공지사항
						</a>

			<!-- 로그인 했을경우 표시. -->
<%-- 			<c:if test="${memberid != null}"> --%>
				
<!-- 						<div class="sb-sidenav-menu-heading">Interface</div> -->
<!-- 						</a> -->
<!-- 						<div class="collapse" id="collapseLayouts" -->
<!-- 							aria-labelledby="headingOne" data-parent="#sidenavAccordion"> -->
<!-- 							<nav class="sb-sidenav-menu-nested nav"> -->
<!-- 								<a class="nav-link" href="layout-static.html">Static -->
<!-- 									Navigation</a> <a class="nav-link" href="layout-sidenav-light.html">Light -->
<!-- 									Sidenav</a> -->
<!-- 							</nav> -->
<!-- 						</div> -->
<!-- 						<a class="nav-link collapsed" href="#" data-toggle="collapse" -->
<!-- 							data-target="#collapsePages" aria-expanded="false" -->
<!-- 							aria-controls="collapsePages"> -->
<!-- 							<div class="sb-nav-link-icon"> -->
<!-- 								<i class="fas fa-book-open"></i> -->
<%-- 							</div> <label style=color:white>${memberNick}</label> --%>
<!-- 							<div class="sb-sidenav-collapse-arrow"> -->
<!-- 								<i class="fas fa-angle-down"></i> -->
<!-- 							</div> -->
<!-- 						</a> -->
<!-- 						<div class="collapse" id="collapsePages" -->
<!-- 							aria-labelledby="headingTwo" data-parent="#sidenavAccordion"> -->
<!-- 							<nav class="sb-sidenav-menu-nested nav accordion" -->
<!-- 								id="sidenavAccordionPages"> -->
<!-- 								<a class="nav-link collapsed" href="#" data-toggle="collapse" -->
<!-- 									data-target="#pagesCollapseAuth" aria-expanded="false" -->
<!-- 									aria-controls="pagesCollapseAuth"> 마이페이지 -->
<!-- 								</a> -->
								
<!-- 								<a class="nav-link collapsed" href="#" data-toggle="collapse" -->
<!-- 									data-target="#pagesCollapseError" aria-expanded="false" -->
<!-- 									aria-controls="pagesCollapseError"> 로그아웃 -->

<!-- 								</a> -->
<!-- 							</nav> -->
<!-- 						</div> -->
						
<%-- 				</c:if>		 --%>
						
						<div class="sb-sidenav-menu-heading">Addons</div>
						<a class="nav-link" href="/board/list">
							<div class="sb-nav-link-icon">
								<i class="fas fa-chart-area"></i>
							</div> 자유게시판
						</a><a class="nav-link" href="/stock/list">
							<div class="sb-nav-link-icon">
								<i class="fas fa-chart-area"></i>
							</div> 주식데이터
						</a>  <a class="nav-link" href="/email/write.do">
							<div class="sb-nav-link-icon">
								<i class="fas fa-table"></i>
							</div> 건의 접수
						</a>
						
						
						
						
					</div>
				</div>
			</nav>
		</div>
		<div id="layoutSidenav_content">
			<main>
			<!-- 로그인 했을경우 표시. -->
			<c:if test="${memberid != null}">
				<div class=login>
					${memberNick}님 환영합니다.
					<br>
					<a href="/member/myPage">마이페이지</a>
					<a href="/member/logout" onclick="signOut();">로그아웃</a>
					
				</div>
			</c:if>
			
			<!-- 로그인안되 있을경우 표시 -->
			<c:if test="${memberid == null }">
				<div class=login>
				<a href="/member/login">로그인</a>
				<a href="/member/userJoin">회원가입</a>
				</div>
			</c:if>
			
				<div class="container-fluid">
					<h1 class="mt-4">자유 게시판</h1>
					<div class="card mb-4">
						<div class="card-header">
							<i class="fas fa-table mr-1"></i> 

							<div class="form-row float-right">
<!-- 								<button type="button" class="btn btn-primary" -->
<!-- 									onclick="location.href='/board/register'">register</button> -->
								<button type="button" class="btn btn-primary" onclick="memberCheck()" id="register">register</button>
							</div>

						</div>
						<div class="card-body">
							<div class="table-responsive">
								<table class="table table-condensed">
								<colgroup>
								  <col width="10%" />
								  <col width="40%" />
								  <col width="20%" />
								  <col width="20%" />
								  <col width="10%" />								  
								</colgroup>
									<thead>
										<tr>
											<th>번호</th>
											<th>제목</th>
											<th>작성자</th>
											<th>작성시간</th>
											<th>조회수</th>
										</tr>
									</thead>

									<c:forEach var="list" items="${list}">
										<tbody>
											<tr>
												<td><c:out value="${list.bno}" /></td>
												<td><a href='get?bno=${list.bno}'><c:out
															value="${list.title}" /></a> [${list.replyCnt}]</td>
												<td><c:out value="${list.writer }" /></td>
												<td><fmt:formatDate value="${list.updateDate }"
														pattern="yyyy-MM-dd KK:mm:ss" />
												<td><c:out value="${list.boardCnt}" /></td>
											</tr>
										</tbody>
									</c:forEach>
								</table>
							</div>
<%-- 							${page.toString()} --%>
							<nav class="service-box">
								<ul class="pagination pull-right">

									<c:if test="${page.prev}">
										<li class="paginate_button previous"><a
											href="list?pageNum=${page.startPage - 1 }">Previous</a></li>
									</c:if>

									<c:forEach var="num" begin="${page.startPage}"
										end="${page.endPage}">
										<li class="paginate_button ${page.cri.pageNum == num ? "active" : ""} ">

											<c:if test="${page.cri.keyword != null}">
												<a
													href="list?pageNum=${num}&amount=${page.cri.amount}&type=${page.cri.type}&keyword=${page.cri.keyword}">${num}</a>
											</c:if> <c:if test="${page.cri.keyword == null}">
												<a href="list?pageNum=${num}&amount=${page.cri.amount}">${num}</a>
											</c:if>
									</c:forEach>

									<c:if test="${page.next}">
										<li class="paginate_button next"><a
											href="list?pageNum=${page.endPage + 1 }">Next</a></li>
									</c:if>
								</ul>

								<form action="/board/list" method="get">

									<select name="type">
										<!-- 
	<option value ="title">제목</option>
	<option value ="content">내용</option>
	<option value ="writer">작성자</option>
-->
										<option value="title"
											${page.cri.type eq "title" ? "selected" : ""}>제목</option>
										<option value="content"
											${page.cri.type eq "content" ? "selected" :""}>내용</option>
										<option value="writer"
											${page.cri.type eq "writer" ? "selected" :""}>작성자</option>

									</select>

									<!-- 검색조건유지 -->
									<input type="text" name="keyword" value="${page.cri.keyword != null ? page.cri.keyword : ''}">

									<button type="submit">검색</button>

								</form>
							</nav>
						</div>

					</div>
				</div>
			</main>




<!-- 구글 로그아웃 -->
<script src="https://apis.google.com/js/platform.js?onload=onLoad" async defer></script>


<script>
    function signOut() {
      var auth2 = gapi.auth2.getAuthInstance();
      auth2.signOut().then(function () {
        console.log('User signed out.');
      });
      
      auth2.disconnect();
    }

    function onLoad() {
      gapi.load('auth2', function() {
        gapi.auth2.init();
      });
    }
  </script>
<!-- 구글 로그아웃 -->


<script type="text/javascript">


$(document).ready(function () {

	
	if("${memberWithdrawal}") alert("${memberWithdrawal}");
		
	
});



	function memberCheck(){
		
		if("${memberid}" !== ""){
			location.href="/board/register"
		}else{
			location.href="/member/login"
		}
	}
	
	
	

	

</script>



</body>

<%@include file="include.jsp"%>


</html>

