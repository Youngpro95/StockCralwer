CREATE TABLE stock_vi(
stk_id NUMBER(10,0), --��ȣ
stk_cd varchar2(50), --�����ڵ� 
stk_nm varchar2(50),  --�����
stk_pri varchar2(50), --����
stk_inc varchar2(50), --��·�
stk_act varchar2(50), --�ߵ��ð� 
stk_rel varchar2(50), -- �����ð�
stk_daye Date default sysdate -- �����͵�Ͻð�
-- CONSTRAINT pk_stkid PRIMARY KEY(stk_id)
);
--alter table stock_vi add stk_daye Date default sysdate

--alter table stock_vi drop primary key
--drop table stock_news
--commit;
--ALTER TABLE stock_vi MODIFY stk_rel VARCHAR2(50);
--ALTER TABLE stock_vi MODIFY stk_act VARCHAR2(50);
--ALTER TABLE stock_vi DROP CONSTRAINT pk_stkid;
--alter table stock_vi add primary key(stk_cd);


    -- if 0 �̶�� ���  1�̶��(������ ����) �ٽ� �� ,
	select count(*) from stock_vi where stk_id = '5' and to_date(stk_daye,'YY/MM/DD') =(SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD') FROM DUAL)
	
    --  �ð����� ���ؼ� 1�̶��(�������ְ� rel :00��) return / 0�̶�� ������Ʈ 
	select count(*) from stock_vi where stk_id = '5' and stk_rel='00:00:00' and to_date(stk_daye,'YY/MM/DD') =(SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD') FROM DUAL)
	
    
    select count(*) from stock_vi where stk_id = '153' 
    
    select * from stock_vi WHERE (CASE WHEN stk_rel = '00:00:00' THEN stk_rel = '11' else stk_rel='22' end)
    
    select * (case when stk_rel = '00:00:00' then stk_rel = '11' else stk_rel='22' end) from stock_vi
    
rollback

update stock_vi set stk_rel = '12:12:12' where stk_id = '155'

commit;

create SEQUENCE seq_stock

select * from stock_vi
	
    	INSERT INTO stock_vi (stk_id)
        VALUES (#{stk_id})
    
INSERT INTO stock_vi (stk_id, stk_cd, stk_nm, stk_pri, stk_inc)
VALUES (SEQ_STOCK.nextval,1111,'�����',8000,100);

COMMIT


------- VI list �۾� -----
--select * from stock_vi order by TO_NUMBER(stk_id)

select * from stock_vi order by stk_id

SELECT SYSDATE FROM DUAL;

select * from stock_vi where to_date(stk_daye,'YY/MM/DD') ='21/03/04' 

select * from stock_vi where to_date(stk_daye,'YY/MM/DD') =(SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD') FROM DUAL) order by stk_id desc

select count(*) from stock_vi where stk_id = #{stk_id}

    update stock_vi set stk_rel = '24:24:24' where stk_id = 5 and stk_nm = '�����ǰ2'

------vi news-------------    
CREATE TABLE stock_news(
--news_bno NUMBER(10,0),
news_company varchar2(300),
news_title varchar2(500),
news_time varchar2(300),
news_href varchar2(300)
)

drop table stock_news 

create sequence seq_news increment by 1 start with 1

insert into stock_news (news_bno, news_company, news_title, news_time, news_href)
values (seq_news.nextval,'�׽�Ʈȸ��','����', '7����','www.naver.com')

-- ���� ���о��� �˻��ϱ�
select * from stock_news where replace(news_company,' ','') LIKE '%THESAMSUNG%'

commit;
 

select * from stock_news where news_company ='�Ҹ��ٴ�' and news_title like '%������%'

select count(*) from stock_news where news_company ='�Ҹ��ٴ�1'

-- ������ 1 ������ 0��ȯ
select count(*) from stock_news where news_company ='����ĸ' and news_href = 'https://www.news2day.co.kr/article/20201218500072' 

select vsize('������') as byteSize from dual

commit;