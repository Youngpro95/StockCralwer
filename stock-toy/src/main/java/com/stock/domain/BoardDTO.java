 package com.stock.domain;

import java.util.Date;

import lombok.Data;

@Data
public class BoardDTO {

	private int bno;
	private String title;
	private String content;
	private String writer;
	private Date updateDate;
	private int boardCnt; //게시글 조회
	private int replyCnt;

	private int attach; //파일업로드
	
}
