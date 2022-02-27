package com.stock.domain;

import lombok.Data;

@Data
public class Board_AttachDTO {

	private int file_Num;   //파일번호
	private String file_Name; //파일이름
	private String uid_FileName; //파일uid이름
	private String file_Path; //파일경로
	private int file_Size; //파일크기
	private String file_userid; //파일작성자
	
	private int board_bno; //게시글번호

	private Board_AttachDTO[] fileList;
}
