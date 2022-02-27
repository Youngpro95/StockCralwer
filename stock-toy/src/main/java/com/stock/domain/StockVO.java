package com.stock.domain;

import java.util.List;

import lombok.Data;

@Data
public class StockVO {
	
	private String stk_id;
	private int Istk_id; //int형으로 변환 
	private String stk_cd;
	private String stk_nm;
	private String stk_pri;
	private String stk_inc;
	private String stk_act;
	private String stk_rel;
	
	List<StockVO> listDate; // json 데이터 배열 담기

}
