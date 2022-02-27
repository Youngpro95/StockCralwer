create table tbl_board(       --board
bno NUMBER(10,0),
title varchar2(100),
content varchar2(1000),
writer varchar2(50),
updatedate DATE  default SYSDATE,
boardcnt NUMBER(10,0) default 0,
CONSTRAINT pk_board PRIMARY KEY(bno)
);
commit;
-------
CREATE SEQUENCE seq_board INCREMENT BY 1 START WITH 1;

select * from tbl_board
where title like '��%'

	select * from tbl_board
	where title = '��'    

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
      
commit;          

    update tbl_board set cnt = cnt + 1 where bno = 321



------��� ���������?
create table tbl_reply(
rno number(10,0),
bno number(10,0) not null,
reply varchar2(1000) not null,
replyer varchar2(50) not null,
replyDate date default sysdate,
updateDate date default sysdate
);

create SEQUENCE seq_reply;

ALTER TABLE tbl_reply ADD CONSTRAINT pk_reply PRIMARY KEY (rno);

ALTER TABLE tbl_reply ADD CONSTRAINTS fk_reply foreign KEY (bno) REFERENCES tbl_board(bno) ON DELETE CASCADE;  --�Խù� ������ , ��۰��̻���

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
Ʈ����

select tbl_board.bno as a, tbl_reply.bno as b from tbl_board ,tbl_reply  where tbl_board.bno(+) = tbl_reply.bno

	delete from tbl_reply where rno = 553 and replyer = 'test11111'
    	update tbl_reply set reply = #{reply} where rno = #{rno} and = #{replyer}
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
create sequence seq_attach increment by 1 start with 1
commit;

insert into tbl_attach (file_num, board_bno, file_Name, uid_FileName, file_Path, file_size)
values(seq_attach.nextval, 504, '�����̸�', 'uid�����̸�', '���ϰ��', 1234)

SELECT seq_board.NEXTVAL FROM DUAL;

select count(*) from tbl_attach where uid_filename like '%THUMB_9b47c08d-f093-4b41-b5af-d8dd67db1da6_%'

------ ���Ͼ��ε� get -----

alter sequence seq_board nocache

select file_num, board_bno, file_name, uid_filename, file_path
from tbl_attach where board_bno = 122;


------ ȸ������ 
create table tbl_member(
memberID varchar2(100), --���̵�
memberPw varchar2(100), -- �н�����
memberName varchar2(100), --�̸�
memberPhone varchar2(100), --����ó
memberNick varchar2(100),
memberEmail varchar2(100),--�̸���
joinDate Date default sysdate, --���Խð�
memberLevel number default 1, --ȸ�����
provider varchar2(100) default 'local' --���԰��
);

commit;
drop table  tbl_member

alter table tbl_member add constraint pk_member PRIMARY key(MemberID); --id �⺻Ű

insert into tbl_member(memberid, memberpw, membername, memberphone, memberemail)
values('kst', '1234', '�����', '010-1234-1234', 'kst005109@naver.com')

select count(*) from tbl_member where memberid= 'kst'

select count(*) from tbl_member where memberid='kst005109' and memberpw='UE47upzQzfPaKgTNpBfFP2JwJ6dsp5MGrBC6U3vXZMXRT6J0Or4j8pyaZmni1XWNudi1GnXvrfscMrxOWpvjEw=='

select memberid, membername, memberphone, membernick, memberemail from tbl_member where memberid='test1234'

	update tbl_member 
	set membername = #{MemberName}, membernick=#{MemberNick}, memberphone =#{MemberPhone}, memberemail=#{MemberEmail}
	where memberid = #{MemberID}
    
    update tbl_member set memberpw='1234' where memberid='test1234' 
    
    select count(*) from tbl_member
    where memberid = 36772257 and memberphone ='010-9274-2848' and memberemail='kst005109@naver.com'
    
    
    select membernick from tbl_member
    where memberid = 'test0001'
    