package com.stock.service;

import java.util.List;

import com.stock.domain.StockNewsVO;
import com.stock.domain.StockVO;

public interface StockService {

	public int ViListRegister(StockVO vo);
	//뉴스 크롤링데이터 등록
	public int ViNewsRegister(StockNewsVO vo);
	
	public int getJson(StockVO vo);
	
	public int getJson2(StockVO vo);

	public void jsonUpdate(StockVO vo);
	
	//VI NEWS 시간 업데이트
	public void jsonNewsUpdate(StockNewsVO vo);
	
	public int getJsonNews(StockNewsVO vo);
	
	//vi news list 데이터 조회
	public List<StockNewsVO> getNewsList(String test1);
	
	public List<StockVO> getList();
}
