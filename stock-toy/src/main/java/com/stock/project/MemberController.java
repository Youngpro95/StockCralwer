package com.stock.project;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.nio.charset.Charset;
import java.security.GeneralSecurityException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken.Payload;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.stock.domain.MemberDTO;
import com.stock.service.BoardMemberService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/member/*")
public class MemberController {

	@Autowired
	private BoardMemberService service;
	
	//회원가입
	@RequestMapping(value = "/userJoin", method = {RequestMethod.GET,RequestMethod.POST}) 
	public ModelAndView getUserJoin(MemberDTO dto) throws NoSuchAlgorithmException {

	try {
		
		log.info("회원가입 controller----------dto" + dto);
		ModelAndView mav = new ModelAndView();
		
		//dto가 null이 아니면 post 방식 받음
		if(dto.getMemberID() != null) {

			int idChk = service.idChk(dto.getMemberID());
			
			log.info("idChk----" + idChk);
			log.info("dto----" + dto);
			
			if(idChk == 0) {

				//정규표현식을 사용한 비밀번호에 소문자,숫자 들어갔는지체크
			boolean regex = false;
			Matcher regexCheck = Pattern.compile("^(?=.*[0-9])(?=.*[a-zA-Z]).{8,12}$").matcher(dto.getMemberPw());
		
			int nullCheck = userDataCheck(dto);
			
			System.out.println("nullCheck----" + nullCheck);
			
			if(!dto.getMemberPw().equals(dto.getMemberPw2())) {
				mav.addObject("idCheck", dto.getMemberID());
				mav.addObject("nameCheck", dto.getMemberName());
				mav.addObject("nickCheck", dto.getMemberNick());
				mav.addObject("phoneCheck", dto.getMemberPhone());
				mav.addObject("emailCheck", dto.getMemberEmail());
				mav.setViewName("/member/userJoin");
				mav.addObject("registerCheck", idChk+3);
				mav.addObject("pwNon", "비밀번호를 확인해주세요.");
				return mav;
			}
			
			if(regexCheck.find() || nullCheck == 1) {
					regex = true;
			}else{
					log.info("비밀번호가 일치하지않아용! 확인바람");
					mav.addObject("idCheck", dto.getMemberID());
					mav.addObject("nameCheck", dto.getMemberName());
					mav.addObject("nickCheck", dto.getMemberNick());
					mav.addObject("phoneCheck", dto.getMemberPhone());
					mav.addObject("emailCheck", dto.getMemberEmail());
					mav.addObject("registerCheck", idChk+2);
					mav.setViewName("/member/userJoin");
					return mav;
				}

				
				  log.info("regex---" + regex);
				
				  
				//비밀번호 암호화처리
				pwSecurity(dto);
				  
				//db에 회원정보등록	
				service.userRegister(dto); 
				mav.addObject("registerCheck", idChk+1);
				mav.setViewName("/member/login");
				return mav;
			}else{
				mav.addObject("registerCheck",idChk);
				mav.setViewName("/member/userJoin");
				return mav;
			}
		}
		mav.setViewName("/member/userJoin");
		return mav;		
	}catch (Exception e) {
		e.printStackTrace();
	}
	
	return null;
		
}
	
	//로그인
	@RequestMapping(value="login", method = {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView UserLogin(MemberDTO dto, HttpServletRequest req) throws NoSuchAlgorithmException {
		
		ModelAndView mav = new ModelAndView();

		if(dto.getMemberID() == null) {
			mav.setViewName("/member/login");
			return mav;
		}
		
		log.info("login dto----- " + dto);
		
		pwSecurity(dto);
		
		log.info("메서드 호출 dto ---" + dto);
		int check = service.loginCheck(dto);
		log.info("check 값---" + check);
		
		
		MemberDTO dto2 = service.getMylogin(dto.getMemberID());
		dto.setMemberNick(dto2.getMemberNick());
		log.info("service dto2---" + dto2);

		if(check == 1) {
			HttpSession session = req.getSession();
			session.setAttribute("memberid", dto.getMemberID());;
			session.setAttribute("memberNick",dto.getMemberNick());
			mav.setViewName("redirect:/board/list");
			return mav;
		}else{
			log.info("계정과 비밀번호가 일치하지않는다. 실패..");
			mav.addObject("registerCheck", 2);
			mav.addObject("MemberID", dto.getMemberID());
			mav.setViewName("/member/login");
			return mav;
		}
		
	}
	
	//로그아웃
	@GetMapping("/logout")
	public String Loginlogout(HttpSession seesion) {

		log.info("로그아웃합니다.");

		seesion.invalidate();
		
		return "redirect:/board/list";
	}
	
	//마이페이지
	@GetMapping("/myPage")
	public void getmyPage() {
	
		log.info("getmypage----");
		
	}
	//마이페이지 아이디 정보 뱉어주기
	@PostMapping("/getMyPage")
	public ResponseEntity<MemberDTO> getmyPageID(@RequestParam(value = "memberid",required = false) String memberid) {
	
		log.info("Postmypage----" + memberid);
		log.info("Serivce ----" + service.getMylogin(memberid));	
		
		return new ResponseEntity<MemberDTO>(service.getMylogin(memberid),HttpStatus.OK);
	}
	
	//마이페이지 업데이트
	@PostMapping("/myPageUpdate")
	public ModelAndView myPageUpdate(MemberDTO dto,HttpSession session){
		
		dto.setMemberID((String)session.getAttribute("memberid"));
		log.info("dto----------------" + dto);
		
		
		ModelAndView mv = new ModelAndView("/member/myPage");
		
		log.info("dto------" + dto);
		int nullCheck = userDataCheck(dto);

		if(nullCheck == 0) {
		log.info("update service---" + service.myPageUpdate(dto));
		
		return mv;
		
		}
		
		return mv;
	}
	
	//아이디 중복체크 ajax
	@GetMapping("/idCheck")
	public ResponseEntity<Integer> getIdCheck(@RequestParam("MemberID") String id) {
			
		log.info("id 체크 ---" + id);

		Matcher pattern = Pattern.compile("[ !@#$%^&*(),.?\":{}|<>]").matcher(id);
		
		//아이디 특수문자 확인 
		if(pattern.find()) {
			
			log.info("아이디에 특수문자 포함되있습니다 .리턴합니다 ---- 2");
			return new ResponseEntity<Integer>(2, HttpStatus.OK);
		
		}
		
		
		int idchk = service.idChk(id);
		
		log.info("idchk----" + idchk);
	
		return new ResponseEntity<Integer>(idchk, HttpStatus.OK);
		
	}
	@GetMapping("/nickCheck")
	public ResponseEntity<Integer> getNickCheck(@RequestParam("memberNick") String nick) {
		
		log.info("nick 체크 ---" + nick);

		
		if(nick.length() <2 || nick.length() > 10) {
			
			log.info("닉네임이 2~10글자를 벗어납니다 리턴합니다 ---- 2");
			return new ResponseEntity<Integer>(2, HttpStatus.OK);
			
		}
		
		int checkNick = service.nickChck(nick);
		
		log.info("checkNick----" + checkNick);
	
		return new ResponseEntity<Integer>(checkNick, HttpStatus.OK);
		
	}
	
	//비밀번호변경
	@GetMapping("/passwordChange")
	public void passwordChange() {
		
	}

	//비밀번호변경
	@PostMapping("/passwordChange")
	public ModelAndView passwordChange2(MemberDTO dto,HttpSession session) throws NoSuchAlgorithmException {
		
		dto.setMemberID((String)session.getAttribute("memberid"));
		log.info("dto----------------" + dto);
		
		
		ModelAndView mv = new ModelAndView("/member/passwordChange");
		
		boolean regex = Pattern.matches(("^(?=.*[0-9])(?=.*[a-zA-Z]).{8,12}$"),dto.getMemberPw2());
		
		log.info("dto-----" + dto + "regext----" + regex);
		
		if(service.loginCheck(pwSecurity(dto)) == 0) {
			log.info("비밀번호 틀림!");
			mv.addObject("pwNon", "현재 비밀번호 틀림");
			return mv;
		}
		
		
		if(regex == false) {
			log.info("8글자이상, 영문자 + 소문자 비밀번호가 아님!");
			mv.addObject("pwCheck", "8글자이상, 영문자 + 소문자 비밀번호가 아님!");
			return mv;
		}else if(dto.getMemberPw2().equals(dto.getMemberPw3())) {
			log.info("새비밀번호와 새비밀번호 확인 일치!");
			service.passwordChange(pwSecurity2(dto));
			mv.addObject("pwChangeOk", "비밀번호 변경완료!");
			return mv;
		}else{
			log.info("새비밀번호와 확인이 틀립니다.!!!!");
			mv.addObject("pwChangeNon", "새비밀번호와 확인이 틀립니다.");
			return mv;
		}	
	
	}	
	
	//회원탈퇴
	
	@GetMapping("/memberWithdrawal")
	public void memberWithdrawal() {
		
	}
	
	@PostMapping("/memberWithdrawal")
	public ModelAndView memberWithdrawal(MemberDTO dto,HttpSession session) throws NoSuchAlgorithmException {
		
		ModelAndView mv = new ModelAndView();
		
		dto.setMemberID((String)session.getAttribute("memberid"));
		
		if(service.loginCheck(pwSecurity(dto)) == 1) {
			log.info("로그인된 아이디와 비밀번호가 일치합니다..");
			service.memberWithdrawal(dto);
			mv.addObject("memberWithdrawal", "회원탈퇴 되었습니다.");
			mv.setViewName("redirect:/board/list");
			session.invalidate();
		}
			else {
			log.info("로그인된 아이디와 비밀번호가 일치하지않습니다!!!..");
			mv.addObject("memberWithdrawal", "비밀번호가 일치하지않습니다.");
			mv.setViewName("/member/memberWithdrawal");
		}			

		log.info("dto----" + dto);
		
		return mv;
		
	}
	

	//네이버 로그인1	
	@GetMapping("/callback")
	public void getCallNaverLogin() {
		
		
		log.info("--callback");
	
	}
	
	//네이버 로그인2
	@GetMapping("/personalInfo")
	public String personalInfo(@RequestParam(value="access_token", required = false) String access_token,HttpSession session,MemberDTO dto) {
		
		
		try {
		
			log.info("personalInfo !! access_token---" + access_token);
			
			
	        String token = access_token; // 네이버 로그인 접근 토큰;
	        String header = "Bearer " + token; // Bearer 다음에 공백 추가
	
	
	        String apiURL = "https://openapi.naver.com/v1/nid/me";
	
	
	        Map<String, String> requestHeaders = new HashMap<>();
	        requestHeaders.put("Authorization", header);
	        String responseBody = get(apiURL,requestHeaders);
	
	
	        System.out.println(responseBody);
			
	        
	        JsonParser jParser = new JsonParser();
	        
	        JsonObject jObject = (JsonObject)jParser.parse(responseBody);
	        
	        log.info("object----" + jObject);
	        
	        JsonObject test1 = (JsonObject)jObject.get("response");
	        log.info("test1----" + test1);
	        
	        log.info(test1.get("id"));
	        log.info(test1.get("nickname"));
	        log.info(test1.get("email"));
	        log.info(test1.get("mobile"));
	        log.info(test1.get("name"));
	        
	        dto.setMemberID(""+test1.get("id").toString().substring(1,test1.get("id").toString().length()-1));
	        dto.setMemberNick("(NAVER)"+test1.get("nickname").toString().substring(1,test1.get("nickname").toString().length()-1));
	        dto.setMemberPhone(""+test1.get("mobile").toString().substring(1,test1.get("mobile").toString().length()-1));
	        dto.setMemberEmail(""+test1.get("email").toString().substring(1,test1.get("email").toString().length()-1));
	        dto.setMemberName(""+test1.get("name").toString().substring(1,test1.get("name").toString().length()-1));
	        dto.setProvider("naver");
	        
	        System.out.println("NAVERDTO---" + dto);
	        System.out.println("네이버멤버 있나--" + service.naverMemberCheck(dto));
	        
	        if(service.naverMemberCheck(dto) == 0) {
	        	
	        	log.info("네이버 아이디 등록합니다.----");
	        	
	        	service.naverMemberJoin(dto);
	        	
	        }
	        
	        session.setAttribute("memberid", dto.getMemberNick());
			session.setAttribute("memberNick",dto.getMemberNick());
			
		return "redirect:/board/list";
		
		}catch (Exception e) {
			e.printStackTrace();
		return null;
		
		}
		
		
	}
	
	
	//구글 로그인 
	@PostMapping(value="/googlelogin" ,consumes = MediaType.APPLICATION_JSON_UTF8_VALUE )
	public void googlelogin(@RequestBody MemberDTO dto, HttpSession session) throws GeneralSecurityException, IOException {
		
		log.info("google dto--------" + dto);
	
		GoogleIdTokenVerifier verifier = new GoogleIdTokenVerifier.Builder(new NetHttpTransport(), new JacksonFactory())
			    // Specify the CLIENT_ID of the app that accesses the backend:
			    .setAudience(Collections.singletonList("48622415722-25jn44tcscqekpdc9sbbdpvhvrvju33v.apps.googleusercontent.com"))  //클라이언트아이디
			    // Or, if multiple clients access the backend:
			    //.setAudience(Arrays.asList(CLIENT_ID_1, CLIENT_ID_2, CLIENT_ID_3))
			    .build();

			// (Receive idTokenString by HTTPS POST)

			GoogleIdToken idToken = verifier.verify(dto.getIdToken()); //아이디토큰
			if (idToken != null) {
			  Payload payload = idToken.getPayload();

			  
			  // Print user identifier
			  String userId = payload.getSubject();
			  System.out.println("User ID: " + userId);

			  // Get profile information from payload
			  String email = payload.getEmail();
			  boolean emailVerified = Boolean.valueOf(payload.getEmailVerified());
			  String name = (String) payload.get("name");
			  String pictureUrl = (String) payload.get("picture");
			  String locale = (String) payload.get("locale");
			  String familyName = (String) payload.get("family_name");
			  String givenName = (String) payload.get("given_name");

			  
			  System.out.println("email: " + email);
			  System.out.println("emailVerified: " + emailVerified);
			  System.out.println("name: " + name);
			  System.out.println("locale: " + locale);
			  System.out.println("pictureUrl: " + pictureUrl);
			  System.out.println("familyName: " + familyName);
			  System.out.println("givenName: " + givenName);
			  
			  dto.setMemberID(userId);
			  dto.setMemberName(name);
			  dto.setMemberNick("(GOOGLE)"+givenName);
			  dto.setMemberEmail(email);
			  dto.setProvider("google");
			  dto.setMemberPhone("null");
			  
			  
			  if(service.naverMemberCheck(dto) == 0) {
				  log.info("구글 아이디 등록합니다.");
				  service.naverMemberJoin(dto);
			  }
			  
			  

		      session.setAttribute("memberid", dto.getMemberNick());
		      session.setAttribute("memberNick",dto.getMemberNick());
			  
			  // Use or store profile information
			  // ...
		      
			} else {
			  System.out.println("Invalid ID token.");
			}
			
	}
	
//	//카카오로그인 되는건데 jsp에서 code를 보내주는버전 일단 사용 x
//	@RequestMapping(value= "/kakaoLogin")
//	public String getkakao(@RequestParam("code") String code, HttpSession session) {
//		
//		MemberDTO dto = new MemberDTO();
//		
//		log.info("code--------" + code);
//		String kakaoAccess_Token = getAccessToken(code);
//		
//		
//		
//		if(kakaoAccess_Token != null) {
//		log.info(kakaoAccess_Token);
//		HashMap<String, Object> userInfo = getUserInfo(kakaoAccess_Token);
//		
//		
//		log.info("id" + userInfo.get("id"));
//		log.info("email" + userInfo.get("email"));
//		log.info("nickname" + userInfo.get("nickname"));
//		log.info("profile_image" + userInfo.get("profile_image"));
//
//		log.info("데이터타입---" + userInfo.get("id").toString().getClass().getName());
//		
//		
//		dto.setMemberID(userInfo.get("id").toString());
//		dto.setMemberEmail(userInfo.get("email").toString());
//		dto.setMemberNick("(KAKAO)" + userInfo.get("nickname").toString());
//		dto.setProvider("kakao");
//		dto.setMemberPhone("null");
//		dto.setMemberName("null");
// 		
//
//		  if(service.naverMemberCheck(dto) == 0) {
//			  log.info("카카오 아이디 등록합니다.");
//			  service.naverMemberJoin(dto);
//		  }
//		
//
//	    session.setAttribute("memberid", dto.getMemberNick());
//	    session.setAttribute("memberNick",dto.getMemberNick());
//		}
//		
//		return "redirect:/board/list";
//	    
//	}
	
	//카카오로그인
	@RequestMapping(value= "/kakaoLogin")
	public String getkakao2(@RequestParam("token") String token, HttpSession session) {
		
		MemberDTO dto = new MemberDTO();
		
		log.info("code--------" + token);
		String kakaoAccess_Token = token;
		
		if(kakaoAccess_Token != null) {
		log.info(kakaoAccess_Token);
		HashMap<String, Object> userInfo = getUserInfo(kakaoAccess_Token);
		
		
		log.info("id" + userInfo.get("id"));
		log.info("email" + userInfo.get("email"));
		log.info("nickname" + userInfo.get("nickname"));
		log.info("profile_image" + userInfo.get("profile_image"));

		log.info("데이터타입---" + userInfo.get("id").toString().getClass().getName());
		
		
		dto.setMemberID(userInfo.get("id").toString());
		dto.setMemberEmail(userInfo.get("email").toString());
		dto.setMemberNick("(KAKAO)" + userInfo.get("nickname").toString());
		dto.setProvider("kakao");
		dto.setMemberPhone("null");
		dto.setMemberName("null");
 		

		  if(service.naverMemberCheck(dto) == 0) {
			  log.info("카카오 아이디 등록합니다.");
			  service.naverMemberJoin(dto);
		  }
		

	    session.setAttribute("memberid", dto.getMemberNick());
	    session.setAttribute("memberNick",dto.getMemberNick());
		}
		
		return "redirect:/board/list";
	    
	}
	
	
	
	//특수문자 공백,걸러줌
	public static int userDataCheck(MemberDTO dto) {
		
		boolean regexID = Pattern.matches("[ !@#$%^&*(),.?\":{}|<>]", dto.getMemberID());
		boolean regexNick = Pattern.matches("[ !@#$%^&*(),.?\":{}|<>]", dto.getMemberID());
		boolean regexPhone = Pattern.matches("[ !@#$%^&*(),.?\":{}|<>]", dto.getMemberID());

		
		
			//이름은 특수문자금자 1~20글자 사이	
				if (dto.getMemberID().length() <=1 || dto.getMemberID().length() >=20 || regexID == true) {
					return 1;
				}
				
				//닉네임
				if (dto.getMemberNick().length() <=3 || dto.getMemberNick().length() >= 10 || regexNick == true) {
					return 1;
				}
				//연락처 한글 금지, 12~20글자사이	
				if (dto.getMemberPhone().length() <=10 || dto.getMemberPhone().length() >= 20 || regexPhone == true) {
					return 1;
				}
		
		
		return 0;
	}
	
	
	//네이버로그인
    public static String getAccessToken (String authorize_code) {
        String access_Token = "";
        String refresh_Token = "";
        String reqURL = "https://kauth.kakao.com/oauth/token";

        try {
            URL url = new URL(reqURL);

            HttpURLConnection conn = (HttpURLConnection) url.openConnection();

            //    POST 요청을 위해 기본값이 false인 setDoOutput을 true로

            conn.setRequestMethod("POST");
            conn.setDoOutput(true);

            //    POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송
            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
            StringBuilder sb = new StringBuilder();
            sb.append("grant_type=authorization_code");
            sb.append("&client_id=fc856b9616fca6337845a59c3410831c");  //본인이 발급받은 key
            sb.append("&redirect_uri=http://localhost:8080/member/kakaoLogin");     // 본인이 설정해 놓은 경로
            sb.append("&code=" + authorize_code);
            bw.write(sb.toString());
            bw.flush();

            //    결과 코드가 200이라면 성공
            int responseCode = conn.getResponseCode();
            System.out.println("responseCode : " + responseCode);

            //    요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line = "";
            String result = "";

            while ((line = br.readLine()) != null) {
                result += line;
            }
            System.out.println("response body : " + result);

            //    Gson 라이브러리에 포함된 클래스로 JSON파싱 객체 생성
            JsonParser parser = new JsonParser();
            JsonElement element = parser.parse(result);

            access_Token = element.getAsJsonObject().get("access_token").getAsString();
            refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();

            System.out.println("access_token : " + access_Token);
            System.out.println("refresh_token : " + refresh_Token);

            br.close();
            bw.close();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return access_Token;
    }
	
    
    //네이버로그인2
    public HashMap<String, Object> getUserInfo (String access_Token) {

        //    요청하는 클라이언트마다 가진 정보가 다를 수 있기에 HashMap타입으로 선언
        HashMap<String, Object> userInfo = new HashMap<>();
        String reqURL = "https://kapi.kakao.com/v2/user/me";
        try {
            URL url = new URL(reqURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");

            //    요청에 필요한 Header에 포함될 내용
            conn.setRequestProperty("Authorization", "Bearer " + access_Token);

            int responseCode = conn.getResponseCode();
            System.out.println("responseCode : " + responseCode);

            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));

            String line = "";
            String result = "";

            while ((line = br.readLine()) != null) {
                result += line;
            }
            System.out.println("response body : " + result);


            
            JsonParser parser = new JsonParser();
            JsonElement element = parser.parse(result);

            JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
            JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();
            JsonObject obj = (JsonObject) parser.parse(result);

            
            String nickname = properties.getAsJsonObject().get("nickname").getAsString();
            String profile_image = properties.getAsJsonObject().get("profile_image").getAsString();
            String email = kakao_account.getAsJsonObject().get("email").getAsString();

            
            
            userInfo.put("id", obj.get("id"));
            userInfo.put("nickname", nickname);
            userInfo.put("email", email);
            userInfo.put("profile_image", profile_image);
            
            
            
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return userInfo;
    }
    
	
	
	
	
	//비밀번호 암호화처리
	public static MemberDTO pwSecurity(MemberDTO dto) throws NoSuchAlgorithmException {
		
		MessageDigest md = MessageDigest.getInstance("SHA-512");
		byte[] bytes = dto.getMemberPw().getBytes(Charset.forName("UTF-8"));
		md.update(bytes);
		dto.setMemberPw(Base64.getEncoder().encodeToString(md.digest()));
		
		return dto;
	}
	
	//비밀번호 암호화처리2
	public static MemberDTO pwSecurity2(MemberDTO dto) throws NoSuchAlgorithmException {
		
		MessageDigest md = MessageDigest.getInstance("SHA-512");
		byte[] bytes = dto.getMemberPw2().getBytes(Charset.forName("UTF-8"));
		md.update(bytes);
		dto.setMemberPw2(Base64.getEncoder().encodeToString(md.digest()));

		return dto;
	}
	
	
	//카카오로그인
	 private static String get(String apiUrl, Map<String, String> requestHeaders){
	        HttpURLConnection con = connect(apiUrl);
	        try {
	            con.setRequestMethod("GET");
	            for(Map.Entry<String, String> header :requestHeaders.entrySet()) {
	                con.setRequestProperty(header.getKey(), header.getValue());
	            }


	            int responseCode = con.getResponseCode();
	            if (responseCode == HttpURLConnection.HTTP_OK) { // 정상 호출
	                return readBody(con.getInputStream());
	            } else { // 에러 발생
	                return readBody(con.getErrorStream());
	            }
	        } catch (IOException e) {
	            throw new RuntimeException("API 요청과 응답 실패", e);
	        } finally {
	            con.disconnect();
	        }
	    }
	
		//카카오로그인
	 private static HttpURLConnection connect(String apiUrl){
	        try {
	            URL url = new URL(apiUrl);
	            return (HttpURLConnection)url.openConnection();
	        } catch (MalformedURLException e) {
	            throw new RuntimeException("API URL이 잘못되었습니다. : " + apiUrl, e);
	        } catch (IOException e) {
	            throw new RuntimeException("연결이 실패했습니다. : " + apiUrl, e);
	        }
	    }
		//카카오로그인
	 private static String readBody(InputStream body){
	        InputStreamReader streamReader = new InputStreamReader(body);


	        try (BufferedReader lineReader = new BufferedReader(streamReader)) {
	            StringBuilder responseBody = new StringBuilder();


	            String line;
	            while ((line = lineReader.readLine()) != null) {
	                responseBody.append(line);
	            }


	            return responseBody.toString();
	        } catch (IOException e) {
	            throw new RuntimeException("API 응답을 읽는데 실패했습니다.", e);
	        }
	    }
	
	
}

