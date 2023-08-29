-- 문제 1
-- 1-1
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
CREATE USER joeun_exam IDENTIFIED BY 123456; -- 계정생성

-- 1-2
ALTER USER joeun_exam DEFAULT TABLESPACE users; -- 테이블스페이스 부여

-- 1-3
ALTER USER joeun QUOTA UNLIMITED ON users; -- 용량설정

-- 1-4
GRANT connect, resource to joeun; -- connect, resource 권한 부여

-- 1-5
CREATE TABLE BOARD (
BOARD_NO        NUMBER              NOT NULL        PRIMARY KEY
TITLE           VARCHR2(100)        NOT NULL
CONTENT         VARCHAR2(2000)      NOT NULL
WRITER          VARCHAR2(20)        NOT NULL
REG_DATE        DATE                NOT NULL
UPD_DATE        DATE                NOT NULL
);