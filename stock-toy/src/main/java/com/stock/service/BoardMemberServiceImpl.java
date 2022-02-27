package com.stock.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.stock.domain.MemberDTO;
import com.stock.mapper.BoardMemberMapper;

@Service
public class BoardMemberServiceImpl implements BoardMemberService {

	@Autowired
	private BoardMemberMapper mapper;
	
	@Override
	public int idChk(String id) {
		
		return mapper.idChk(id);
	}

	@Override
	public int userRegister(MemberDTO dto) {

		return mapper.userRegister(dto);
	}

	@Override
	public int loginCheck(MemberDTO dto) {

		return mapper.loginCheck(dto);
	
	}

	@Override
	public MemberDTO getMylogin(String memberid) {

		return mapper.getMylogin(memberid);
	
	}

	@Override
	public int myPageUpdate(MemberDTO dto) {

		return mapper.myPageUpdate(dto);
	}

	@Override
	public void passwordChange(MemberDTO dto) {
		
		mapper.passwordChange(dto);
	}

	@Override
	public void memberWithdrawal(MemberDTO dto) {
	
		mapper.memberWithdrawal(dto);		
	
	}

	@Override
	public int naverMemberCheck(MemberDTO dto) {

		return mapper.naverMemberCheck(dto);
	}

	@Override
	public void naverMemberJoin(MemberDTO dto) {

		
		mapper.naverMemberJoin(dto);
	}

	@Override
	public int nickChck(String nick) {

		return mapper.nickChck(nick);
	}

	
	
	

}
