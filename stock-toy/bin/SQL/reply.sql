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
commit

ALTER TABLE tbl_reply MODIFY (replyer DEFAULT 'test');
select * from tbl_reply;

select * from tbl_reply where bno = 104941 order by rno;


	update tbl_reply set reply = '내용수정' where rno = 161


commit;
