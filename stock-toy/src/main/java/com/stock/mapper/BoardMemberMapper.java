package com.stock.mapper;

import com.stock.domain.MemberDTO;

public interface BoardMemberMapper {
	//id중복 체크
	public int idChk(String id);
	//닉네임 중복체크
	public int nickChck(String nick);
	//회원가입
	public int userRegister(MemberDTO dto);
	//로그인 체크
	public int loginCheck(MemberDTO dto);
	//마이페이지에서 현재 로그인한 아이디의 정보를 가져옴
	public MemberDTO getMylogin(String memberid);
	//마이페이지 업데이트
	public int myPageUpdate(MemberDTO dto);
	//비밀번호 변경
	public void passwordChange(MemberDTO dto);
	//회원탈퇴
	public int memberWithdrawal(MemberDTO dto);
	
	
	//네이버 멤버체크
	public int naverMemberCheck(MemberDTO dto);
	//네이버 회원가입
	public void naverMemberJoin(MemberDTO dto);
}
