package com.stock.domain;

import java.util.Date;

import lombok.Data;

@Data
public class MemberDTO {

	private String memberID;	//아이디
	private String memberPw;	//패스워드
	private String memberPw2;	//패스워드2
	private String memberPw3;	//패스워드3
	
	private String memberName;	//이름
	private String memberPhone;	//연락처
	private String memberNick;	//닉네임
	private String memberEmail;	//이메일
	private Date joinDate;		//가입일
	private int memberLevel;	//회원 레벨
	
	
	
	private String idToken; // sns 토큰ID
	private String provider; //가입경로
	
}
