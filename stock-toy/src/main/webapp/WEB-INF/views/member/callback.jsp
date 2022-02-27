<%@page import="javax.websocket.Session"%>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="com.google.gson.JsonObject" %>
<%@ page import="com.google.gson.JsonParser" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
  <head>
    <title>네이버로그인</title>
  </head>
  <body>
  <%
    String clientId = "GIWNyqhDWRzAcKMrbkIH";//애플리케이션 클라이언트 아이디값";
    String clientSecret = "JAFlosC9Qf";//애플리케이션 클라이언트 시크릿값";
    String code = request.getParameter("code");
    String state = request.getParameter("state");
    String redirectURI = URLEncoder.encode("http://localhost:8080/board/list", "UTF-8");
    String apiURL;
    apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&";
    apiURL += "client_id=" + clientId;
    apiURL += "&client_secret=" + clientSecret;
    apiURL += "&redirect_uri=" + redirectURI;
    apiURL += "&code=" + code;
    apiURL += "&state=" + state;
    String access_token = "";
    String refresh_token = "";
    
    
    System.out.println("apiURL="+apiURL);
    try {
      URL url = new URL(apiURL);

      HttpURLConnection con = (HttpURLConnection)url.openConnection();
      con.setRequestMethod("GET");
      int responseCode = con.getResponseCode();
      BufferedReader br;
      System.out.println("responseCode="+responseCode);
      if(responseCode==200) { // 정상 호출
        br = new BufferedReader(new InputStreamReader(con.getInputStream()));
      } else {  // 에러 발생
        br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
      }
      String inputLine;
      StringBuffer res = new StringBuffer();
      while ((inputLine = br.readLine()) != null) {
        res.append(inputLine);
      }
      br.close();
      if(responseCode==200) {
        out.println(res.toString());
      
		//서버로 access 토큰보내줌
        System.out.println("rest---" + res.toString());
        System.out.println("데이터타입--" + res.getClass().getName());

        JsonParser jParser = new JsonParser();
        
        JsonObject jObject = (JsonObject)jParser.parse(res.toString());
        
        System.out.println("object----" + jObject.get("access_token").toString().substring(1, jObject.get("access_token").toString().length() -1));
        
        String access = "access_token=" + jObject.get("access_token").toString().substring(1, jObject.get("access_token").toString().length() -1);
		
        response.sendRedirect("/member/personalInfo?" + access);
     
      }
    } catch (Exception e) {
      System.out.println(e);
    }finally{

    }
  %>
  
  
  
  
    <!-- jquery -->
	<script	src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
  
  
    <script type="text/javascript">

    </script>
  
  
  </body>
  
  
  

  
</html>
