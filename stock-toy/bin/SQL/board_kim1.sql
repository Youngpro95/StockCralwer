
alter table tbl_board rename column replycnt to boardcnt
-------

select * from tbl_board
where title like '농%'

	select * from tbl_board
	where title = '농'    
    
ALTER TABLE tbl_board MODIFY (CNT DEFAULT 0);

 select    
	insert into tbl_board (bno,title,content,writer) 
	values (seq_board.nextval,'치킨','치킨내용','치킨작성자')
 
commit; 
 	select count(*) from tbl_board where title = '치킨2' 
   
select * from
  	(
    select /*+INDEX_DESC(tbl_board pk_board)*/ rownum rn, bno, content, writer, boardcnt from tbl_board
	where title LIKE '테수투%' and bno > 0 and rownum > 0 and rownum <= 1 * 10
    )
where rn > (1 - 1) * 10
    
    SELECT * FROM 
	 (
	 SELECT /*+INDEX_DESC(tbl_board pk_board)*/ rownum rn, bno, title, content, writer, updatedate, boardcnt
	 FROM tbl_board
	 WHERE bno > 0 and rownum > 0 and rownum <= 1 * 10
	 )
    WHERE rn > (1 - 1) * 10
       
          
    ALTER TABLE tbl_board RENAME COLUMN CNT TO boardCnt;
      
commit;          

    update tbl_board set cnt = cnt + 1 where bno = 321



------댓글 개수몇개인지?
select * from tbl_board where bno = 341

    SELECT * FROM 
	 (
	 SELECT /*+INDEX_DESC(board pk_board)*/ rownum rn, bno, title, content, writer, updatedate, boardcnt, (select count(*) from tbl_reply reply where reply.bno = board.bno) as replyCount
	 FROM tbl_board board
	 WHERE bno > 0 and rownum > 0 and rownum <= 2 * 10
	 )
    WHERE rn > (1 - 1) * 10

select *,(select count(*) from tbl_reply reply where reply.bno = tbl_board.bno) as replyCount
from tbl_board 

select tbl_board.bno as a, tbl_reply.bno as b from tbl_board ,tbl_reply  where tbl_board.bno(+) = tbl_reply.bno


---------- 파일업로드-----
create table tbl_attach(
file_name varchar2(150),                 --파일원본명
uid_filename varchar2(150),              --파일 uuid
file_path varchar2(150),                 -- 파일경로
file_userid varchar2(150),               -- 등록자
file_regdate date default sysdate,       --등록일
board_bno number(10),                     --게시글번호
file_num number(10),                      --파일번호
file_size number(10)                     -- 파일사이즈
);
ALTER TABLE tbl_attach DROP CONSTRAINT fk_filebno;
alter table tbl_attach add constraints fk_filebno foreign key (board_bno) references tbl_board(bno)
commit;

insert into tbl_attach (file_num, board_bno, file_Name, uid_FileName, file_Path, file_size)
values(seq_attach.nextval, 504, '파일이름', 'uid파일이름', '파일경로', 1234)

SELECT seq_board.NEXTVAL FROM DUAL;

select count(*) from tbl_attach where uid_filename like '%THUMB_9b47c08d-f093-4b41-b5af-d8dd67db1da6_%'


