
alter table tbl_board rename column replycnt to boardcnt
-------

select * from tbl_board
where title like '��%'

	select * from tbl_board
	where title = '��'    
    
ALTER TABLE tbl_board MODIFY (CNT DEFAULT 0);

 select    
	insert into tbl_board (bno,title,content,writer) 
	values (seq_board.nextval,'ġŲ','ġŲ����','ġŲ�ۼ���')
 
commit; 
 	select count(*) from tbl_board where title = 'ġŲ2' 
   
select * from
  	(
    select /*+INDEX_DESC(tbl_board pk_board)*/ rownum rn, bno, content, writer, boardcnt from tbl_board
	where title LIKE '�׼���%' and bno > 0 and rownum > 0 and rownum <= 1 * 10
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



------��� ���������?
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


---------- ���Ͼ��ε�-----
create table tbl_attach(
file_name varchar2(150),                 --���Ͽ�����
uid_filename varchar2(150),              --���� uuid
file_path varchar2(150),                 -- ���ϰ��
file_userid varchar2(150),               -- �����
file_regdate date default sysdate,       --�����
board_bno number(10),                     --�Խñ۹�ȣ
file_num number(10),                      --���Ϲ�ȣ
file_size number(10)                     -- ���ϻ�����
);
ALTER TABLE tbl_attach DROP CONSTRAINT fk_filebno;
alter table tbl_attach add constraints fk_filebno foreign key (board_bno) references tbl_board(bno)
commit;

insert into tbl_attach (file_num, board_bno, file_Name, uid_FileName, file_Path, file_size)
values(seq_attach.nextval, 504, '�����̸�', 'uid�����̸�', '���ϰ��', 1234)

SELECT seq_board.NEXTVAL FROM DUAL;

select count(*) from tbl_attach where uid_filename like '%THUMB_9b47c08d-f093-4b41-b5af-d8dd67db1da6_%'


