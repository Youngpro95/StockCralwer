package com.stock.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.stock.domain.Board_AttachDTO;
import com.stock.mapper.Board_AttachMapper;

@Service
public class Board_AttachServiceImpl implements Board_AttachService {

	@Autowired
	private Board_AttachMapper mapper;
	
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
