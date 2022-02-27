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
where title like '농%'

	select * from tbl_board
	where title = '농'    

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
      
commit;          

    update tbl_board set cnt = cnt + 1 where bno = 321



------댓글 개수몇개인지?
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

ALTER TABLE tbl_reply ADD CONSTRAINTS fk_reply foreign KEY (bno) REFERENCES tbl_board(bno) ON DELETE CASCADE;  --게시물 삭제시 , 댓글같이삭제

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
트리거

select tbl_board.bno as a, tbl_reply.bno as b from tbl_board ,tbl_reply  where tbl_board.bno(+) = tbl_reply.bno

	delete from tbl_reply where rno = 553 and replyer = 'test11111'
    	update tbl_reply set reply = #{reply} where rno = #{rno} and = #{replyer}
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
create sequence seq_attach increment by 1 start with 1
commit;

insert into tbl_attach (file_num, board_bno, file_Name, uid_FileName, file_Path, file_size)
values(seq_attach.nextval, 504, '파일이름', 'uid파일이름', '파일경로', 1234)

SELECT seq_board.NEXTVAL FROM DUAL;

select count(*) from tbl_attach where uid_filename like '%THUMB_9b47c08d-f093-4b41-b5af-d8dd67db1da6_%'

------ 파일업로드 get -----

alter sequence seq_board nocache

select file_num, board_bno, file_name, uid_filename, file_path
from tbl_attach where board_bno = 122;


------ 회원가입 
create table tbl_member(
memberID varchar2(100), --아이디
memberPw varchar2(100), -- 패스워드
memberName varchar2(100), --이름
memberPhone varchar2(100), --연락처
memberNick varchar2(100),
memberEmail varchar2(100),--이메일
joinDate Date default sysdate, --가입시간
memberLevel number default 1, --회원등급
provider varchar2(100) default 'local' --가입경로
);

commit;
drop table  tbl_member

alter table tbl_member add constraint pk_member PRIMARY key(MemberID); --id 기본키

insert into tbl_member(memberid, memberpw, membername, memberphone, memberemail)
values('kst', '1234', '김승태', '010-1234-1234', 'kst005109@naver.com')

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
    