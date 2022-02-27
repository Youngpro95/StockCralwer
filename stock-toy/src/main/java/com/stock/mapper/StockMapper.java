package com.stock.mapper;

import java.util.List;

import com.stock.domain.StockNewsVO;
import com.stock.domain.StockVO;

public interface StockMapper {
    //vi 크롤링 데이터 등록
	public int ViListRegister(StockVO vo);
	
	//뉴스 크롤링데이터 등록
	public int ViNewsRegister(StockNewsVO vo);
	
	//DB에 VI 데이터 저장되있는지 확인 1(데이터있음) 0 (데이터없음)
	public int getJson(StockVO vo);
	
	//시간까지 비교해서 1이라면(데이터있고 rel null임) return / 0이라면 업데이트 
	public int getJson2(StockVO vo);
	
	//vi news데이터 있는지 여부  조회
	public int getJsonNews(StockNewsVO vo);
	
	//VI NEWS 시간 업데이트
	public void jsonNewsUpdate(StockNewsVO vo);
	
	//vi news list 데이터 조회
	public List<StockNewsVO> getNewsList(String test1);
	
	//vi 해제시각 업데이트
	public void jsonUpdate(StockVO vo);
	
	// db데이터 출력
	public List<StockVO> getList();
}
