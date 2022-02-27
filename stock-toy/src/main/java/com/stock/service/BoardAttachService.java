package com.stock.service;

import java.util.ArrayList;

import com.stock.domain.Board_AttachDTO;

public interface BoardAttachService {

	public void attach(Board_AttachDTO dto); 	//파일 db 컬럼저장
	
	public int insertbno(); 				 	//게시글 번호등록
	
	public void deleteAttach(String SfileCut); // 파일삭제
	
	public ArrayList<Board_AttachDTO> fileListGet(int bno); //게시물 번호 파일가져오기
}
