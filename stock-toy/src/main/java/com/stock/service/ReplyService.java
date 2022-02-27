package com.stock.service;

import java.util.List;

import com.stock.domain.ReplyVO;

public interface ReplyService {

	public List<ReplyVO> list(int bno);

	public int register(ReplyVO vo);
	
	public int update(ReplyVO vo);
	
	public int delete(ReplyVO vo);
}
