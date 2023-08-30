-- 문제 1
-- 1-1
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
CREATE USER joeun_exam IDENTIFIED BY 123456; -- 계정생성

-- 1-2
ALTER USER joeun_exam DEFAULT TABLESPACE users; -- 테이블스페이스 부여

-- 1-3
ALTER USER joeun_exam QUOTA UNLIMITED ON users; -- 용량설정

-- 1-4
GRANT connect, resource to joeun_exam; -- connect, resource 권한 부여

-- 1-5
CREATE TABLE board (
BOARD_NO        NUMBER              NOT NULL        PRIMARY KEY
,TITLE           VARCHAR2(100)        NOT NULL
,CONTENT         VARCHAR2(2000)      NOT NULL
,WRITER          VARCHAR2(20)        NOT NULL
,REG_DATE        DATE                DEFAULT sysdate NOT NULL
,UPD_DATE        DATE                DEFAULT sysdate NOT NULL
);

-- 1-6
CREATE SEQUENCE SEQ_BOARD
INCREMENT BY 1
START WITH 1
MAXVALUE 100000;

-- 1-7
INSERT INTO BOARD (BOARD_NO, TITLE, CONTENT, WRITER, REG_DATE, UPD_DATE)
VALUES (1, 제목01, 내용01



SELECT *
FROM BOARD;