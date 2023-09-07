------------------------------------------ 문제 1
------------------------------------------ 1-1
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
CREATE USER joeun_exam IDENTIFIED BY 123456; -- 계정생성

------------------------------------------ 1-2
ALTER USER joeun_exam DEFAULT TABLESPACE users; -- 테이블스페이스 부여

------------------------------------------ 1-3
ALTER USER joeun_exam QUOTA UNLIMITED ON users; -- 용량설정

------------------------------------------ 1-4
GRANT connect, resource to joeun_exam; -- connect, resource 권한 부여

------------------------------------------ 1-5
CREATE TABLE board (
BOARD_NO        NUMBER              NOT NULL        PRIMARY KEY
,TITLE           VARCHAR2(100)        NOT NULL
,CONTENT         VARCHAR2(2000)      NOT NULL
,WRITER          VARCHAR2(20)        NOT NULL
,REG_DATE        DATE                DEFAULT sysdate NOT NULL
,UPD_DATE        DATE                DEFAULT sysdate NOT NULL
);

------------------------------------------ 1-6
CREATE SEQUENCE SEQ_BOARD
INCREMENT BY 1
START WITH 1
MAXVALUE 100000;

------------------------------------------ 1-7
INSERT INTO BOARD (BOARD_NO, TITLE, CONTENT, WRITER, REG_DATE, UPD_DATE)
VALUES (1, '제목01', '내용01', '김조은', TO_DATE('22/12/27', 'YY,MM,DD')
, TO_DATE('22/12/27', 'YY,MM,DD'));
INSERT INTO BOARD (BOARD_NO, TITLE, CONTENT, WRITER, REG_DATE, UPD_DATE)
VALUES (2, '제목02', '내용02', '김조은', TO_DATE('22/12/27', 'YY,MM,DD')
, TO_DATE('22/12/27', 'YY,MM,DD'));

------------------------------------------ 1-8
UPDATE BOARD
    SET TITLE = '수정01'
        ,CONTENT = '수정01'
WHERE BOARD_NO=1;

UPDATE BOARD
    SET TITLE = '수정02'
        ,CONTENT = '수정02'
WHERE BOARD_NO=2;0.

------------------------------------------ 1-9
SELECT *
FROM BOARD
WHERE WRITER LIKE '김%';

------------------------------------------ 1-10
DELETE
FROM BOARD
WHERE WRITER = '김조은';

------------------------------------------ 문제2
------------------------------------------ 2-1
CREATE OR REPLACE FUNCTION get_dept_title( emp_id NUMBER )
RETURN VARCHAR2 
IS 
    out_title department.dept_title%TYPE ;
BEGIN 
    SELECT dept_title 
      INTO out_title 
      FROM employee e
          ,department d
    WHERE e.dept_code = d.dept_id
      AND e.emp_id = emp_id;
    RETURN out_title;
END;
/

------------------------------------------ 2-2
CREATE SEQUENCE SEQ_BOARD
INCREMENT BY 1
START WITH 1
MINVALUE 1
MAXVALUE 100000;

CREATE OR REPLACE PROCEDURE pro_emp_write
( 
    IN_EMP_ID IN employee.emp_id%TYPE
    ,IN_TITLE IN VARCHAR2 DEFAULT '제목없음'
    ,IN_CONTENT IN VARCHAR2 DEFAULT '내용없음'
)
IS
    V_EMP_NAME employee.emp_name%TYPE;
BEGIN

SELECT emp_name INTO V_EMP_NAME
FROM employee
WHERE emp_id = IN_EMP_ID;

INSERT INTO BOARD (board_no, title, writer, content)
VALUES ( SEQ_BOARD.nextval, IN_TITLE, V_EMP_NAME, IN_CONTENT);
END;
/

------------------------------------------ 3
프로젝트 주제 : 상품 관리

설명 : 상품DB를 주축으로 각 팀의 필요 DB를 분리한다

주요기능 : 
1. 메인상품의 정보
2. 디자인팀의 필요요소
3. 영업팀의 필요요소
4. 물류팀의 필요요소

요구사항 정의 : 
1. 메인 상품 DB
- 각 DB간의 효율적인 관리를 위해서 모든 상품에는 필수로 고유의 값인 IDX가 들어가야 한다.
- 상품정보에는 모든 팀이 공통으로 확인할수 있는 정보만 기입되어야 한다

2. 디자인팀
- 상품에 대한 식별은 IDX와 상품명으로 한다
- 썸네일과 공통소드, 쇼핑몰 소스를 별도로 저장해야 한다

3. 영업팀
- 각 제품의 판매수량과 매출금액은 분석을 위해 저장하여야 한다.
- 개인정보보호를 위해 파기되는 정보를 제외한 매출분석용 데이터를 별도로 저장한다 

4. 물류팀
- 상품의 대한 관리는 상품바코드로 관리하며 해당 바코드 번호는 메인 상품의 IDX와 동일하다.
- 상품에 대한 위치가 별도로 입력되어 있어야 한다
- 물류팀에서는 제조사로 발주를 할수 있으며 발주시 발주수량을 입력하고 물건이 입고될때 입고수량과
입고일자를 저장한다
- 각 상품은 하나의 제조사에서 매입하고 하나의 제조사에 여러 상품을 발주할수 있다.
- 상품의 재고가 적정재고 미만으로 떨어지지 않게 관리해야 한다.






























