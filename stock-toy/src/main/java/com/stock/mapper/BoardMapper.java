package com.stock.mapper;

import java.util.List;

import com.stock.domain.BoardDTO;
import com.stock.domain.Criteria;

public interface BoardMapper {

	//리스트 목록
	public List<BoardDTO> getList();
	//게시물 조회
	public BoardDTO get(int bno);
	//게시물 등록
	public void register(BoardDTO dto);
	//게시물 수정
	public void modify(BoardDTO dto);
	//게시물 삭제
	public void delete(int bno);
	//게시물 총개수
	public int totalCount();
	//게시물 조회수
	public int clickViews(int bno);
	
	public int replyCount();
	
	public List<BoardDTO> getList(Criteria cri);

	public List<BoardDTO> serach(Criteria cri);
	
	public int serachTotal(Criteria cri);

}


