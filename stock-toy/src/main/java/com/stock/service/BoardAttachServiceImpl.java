package com.stock.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.stock.domain.Board_AttachDTO;
import com.stock.mapper.BoardAttachMapper;

@Service
public class BoardAttachServiceImpl implements BoardAttachService {

	@Autowired
	private BoardAttachMapper mapper;
	
	@Override
	public void attach(Board_AttachDTO dto) {
		
		mapper.attach(dto);
		
	}

	@Override
	public int insertbno() {
		
		return mapper.insertbno();
		
	}

	@Override
	public void deleteAttach(String SfileCut) {

		mapper.deleteAttach(SfileCut);
		
	}

	@Override
	public ArrayList<Board_AttachDTO> fileListGet(int bno) {

		return mapper.fileListGet(bno);
	}


}
