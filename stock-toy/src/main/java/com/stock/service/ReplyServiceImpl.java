package com.stock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.stock.domain.ReplyVO;
import com.stock.mapper.ReplyMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class ReplyServiceImpl implements ReplyService {

	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
	
	@Override
	public List<ReplyVO> list(int bno) {
		
		log.info("-----서비스단 댓글 리스트----");
		
		return mapper.list(bno);
	}

	@Override
	public int register(ReplyVO vo) {
		log.info("-----서비스단 댓글 등록----");
		
		return mapper.register(vo);
		
	}

	@Override
	public int update(ReplyVO vo) {
		log.info("----서비스단 댓글 업데이트 ----");
	
		return mapper.update(vo);
	
	}

	@Override
	public int delete(ReplyVO vo) {
		log.info("----서비스단 댓글 삭제 ----");
		
		return mapper.delete(vo);

	}

}
