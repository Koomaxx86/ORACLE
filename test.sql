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