package com.stock.mapper;

import java.util.List;

import com.stock.domain.ReplyVO;

public interface ReplyMapper {

	public List<ReplyVO> list(int bno);

	public int register(ReplyVO vo);
	
	public int update(ReplyVO vo);
	
	public int delete(ReplyVO vo);
}
