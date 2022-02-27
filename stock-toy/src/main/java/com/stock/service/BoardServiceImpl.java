package com.stock.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.stock.domain.BoardDTO;
import com.stock.domain.Criteria;
import com.stock.mapper.BoardMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@AllArgsConstructor
public class BoardServiceImpl implements BoardService {
	//매퍼 주입
	private BoardMapper mapper;
	
	public List<BoardDTO> getList(){
		log.info("서비스 리스트");
		return mapper.getList();
	}

	@Override
	public BoardDTO get(int bno) {
		return mapper.get(bno);
	}

	@Override
	public void register(BoardDTO dto) {
		mapper.register(dto);
	}

	@Override
	public void modify(BoardDTO dto) {
		mapper.modify(dto);
	}

	@Override
	public void delete(int bno) {
		mapper.delete(bno);
	}

	@Override
	public int totalCount() {
		return mapper.totalCount();
	}

	@Override
	public List<BoardDTO> getList(Criteria cri) {
		return mapper.getList(cri);
	}

	@Override
	public List<BoardDTO> serach(Criteria cri) {

		return mapper.serach(cri);
	}

	@Override
	public int serachTotal(Criteria cri) {
		
		return mapper.serachTotal(cri);
	}

	@Override
	public int replyCount() {
	
		return mapper.replyCount();
		
	}

	@Override
	public int clickViews(int bno) {
		
		return mapper.clickViews(bno);
	
	}


}
