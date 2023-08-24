-------------------------------------- 70.

-- DMP(덤프파일) 
-- “community.dmp” 덤프파일을 ‘joeun2’ 계정에 import 하는 명령어를 작성하시오.
-- # joeun 계정 생성 하기
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
CREATE USER joeun IDENTIFIED BY 123456; -- 계정생성
ALTER USER joeun DEFAULT TABLESPACE users; -- 테이블스페이스 부여
ALTER USER joeun QUOTA UNLIMITED ON users; -- 용량설정
GRANT connect, resource to joeun; -- connect, resource 권한 부여
GRANT DBA TO joeun; -- 데이터베이스 관리자 권한 부여

-- 덤프 파일 import 하기 (CMD에서 실행)
-- imp userid=관리자계정/비밀번호 file=덤프파일경로 fromuser=덤프소유계정 touser=임포트할 계정
imp userid=system/123456 file=D:\Jung\SQL\community.dmp fromuser=joeun touser=joeun

-------------------------------------- 71.
-- exp userid=생성계정/비밀번호 file=파일경로 log=로그파일경로
-- 생성계정은 import 할 떄 fromuser로 쓰인다.

-- 사용 중인 계정(‘joeun’)이 소유하고 있는 데이터를 “community.dmp” 덤프파일로 export 하는 명령어를 작성하시오.
exp userid=joeun/123456 file=D:\Jung\SQL\community2.dmp log=D:\Jung\SQL\community2.log

-------------------------------------- 72.
-- 외래키 지정
-- ALTER TABLE 테이블명 ADD CONSTRAINT 제약조건명
-- FOREIGN KEY (외래키컬럼) REFERENCES 참조테이블(기본키);
-- 제약조건삭제
-- ALTER TABLE 테이블명 DROP CONSTRAINT 제약조건명

-- 테이블 MS_BOARD 에서 WRITER 속성을 NUMBER 변경하고, 테이블 MS_USER 의 USER_NO 를 참조하는 외래키를 지정하는 SQL 문을 작성하시오.
-- 1) 속성변경
-- 테이블 MS_BOARD 에서 WRITER 속성을 NUMBER 변경
-- 2개의 타입을 맞춰주기 위해서 NUMBER로 변경해야한다.
ALTER TABLE MS_BOARD MODIFY WRITER NUMBER

-- 외래키 지정
-- MS_BOARD 테이블의 WRITER 속성에 대하여, MS_USER의 USER_NO를 참조하도록 외래키로 지정하시오.
ALTER TABLE MS_BOARD ADD CONSTRAINT MS_BOARD_WRITER_FK
FOREIGN KEY (WRITER) REFERENCES MS_USER(USER_NO); 

-- 2) 테이블 MS_FILE 의 BOARD_NO 속성을 테이블 MS_BOARD 의 BOARD_NO 를 참조하는 외래키로 지정하는 SQL 문을작성하시오.
ALTER TABLE MS_FILE ADD CONSTRAINT MS_FILE_BOARD_NO_FK
FOREIGN KEY (BOARD_NO) REFERENCES MS_BOARD(BOARD_NO);

--3)테이블 MS_REPLY 의 BOARD_NO 속성을 테이블 MS_BOARD 의 BOARD_NO 를 참조하는 외래키로 지정하는 SQL문을 작성하시오.
ALTER TABLE MS_REPLY ADD CONSTRAINT MS_REPLY_BOARD_NO_FK
FOREIGN KEY (BOARD_NO) REFERENCES MS_BOARD(BOARD_NO);

-------------------------------------- 73.

-- MS_USER 에 아래 <예시> 과 같이 속성을 추가하는 SQL문을 작성하시오.
ALTER TABLE MS_USER ADD CTZ_NO CHAR(14) NULL UNIQUE;
ALTER TABLE MS_USER ADD GENDER CHAR(6) NULL;

--ALTER TABLE MS_USER MODIFY CTZ_NO NULL;
--ALTER TABLE MS_USER MODIFY GENDER NULL;

COMMENT ON COLUMN MS_USER.CTZ_NO IS '주민번호';
COMMENT ON COLUMN MS_USER.GENDER IS '성별';

DESC MS_USER;

ALTER TABLE MS_USER MODIFY CTZ_NO NULL;
ALTER TABLE MS_USER MODIFY GENDER NULL;

-------------------------------------- 74.

-- MS_USER 의 GENDER 속성이 (‘여‘, ‘남‘, ‘기타‘) 값을 갖도록 하는 제약조건을 추가하는 SQL 문을 작성하시오.
ALTER TABLE MS_USER ADD CONSTRAINT MS_USER_GENDER_CHEK
CHECK (gender IN('여', '남', '기타'));

-------------------------------------- 75.

-- MS_FILE 에 <예시> 와 같이 확장자 속성을 추가하는 SQL 문을 작성하시오.
ALTER TABLE MS_FILE ADD EXT VARCHAR2(10) NULL;
COMMENT ON COLUMN MS_FILE.EXT IS '확장자';

DESC MS_FILE;

-------------------------------------- 76.
-- MERGE(머지) 조건에 부합하면 병합을 한다.

-- MS_FILE 의 FILE_NAME 속성에서 확장자를 추출하여 EXT 속성에 UPDATE 하는 SQL 문을 작성하시오.
/*
    조건
    - FILE NAME 에서 추출한 확장자가 JPEG, JPG, GIF, PNG가 아니면 삭제한다.
    - FILE NAME에서 추출한 확장자를 EXT속성에 UPDATE한다.
*/    
-- 대상 테이블 지정. 
MERGE INTO MS_FILE T -- T <-- 별칭 
-- 사용할 데이터의 자원을 지정
USING ( SELECT FILE_NO, FILE_NAME FROM MS_FILE ) F -- F <-- 별칭
-- ON (update 될 조건) 2개의 FILE_NO비교
ON (T.FILE_NO = F.FILE_NO)
-- 매치조건에 만족한 경우
WHEN MATCHED THEN
    -- SUBSTR( 문자열, 시작번호)
    -- INSTR FILE_NAME에서 뒤에서 부터 '.'의 위치를 확인(그 다음 확장자가 출력)
    -- SUBSTR 확인된 '.'위치로부터 +1의 위치부터 맨 끝의 문자열을 가져온다.
    UPDATE SET T.EXT = SUBSTR(F.FILE_NAME, INSTR(F.FILE_NAME, '.', -1) +1 )
    -- 조건에 만족할 떄 삭제
    -- NOT IN : 포함시키지 않는다.
    DELETE WHERE SUBSTR(F.FILE_NAME, INSTR(F.FILE_NAME, '.', -1) +1 )
    NOT IN ('jpeg', 'jpg', 'gif', 'png')
-- WHEN NOT MATCHED THEN
-- [매치가 안 될 떄,]
;

-- 내용확인
SELECT *
FROM MS_FILE;

-- 파일추가
-- MS_FILE의 BOARD_NO는 MS_BOARD의 BOARD_NO를 참조한다.
-- 참조 무결성 위배 : 현재 MS_BOARD에 BOARD_NO가 없기에 MS_FILE에 게시글 생성이 안된다.
-- 데이터의 중복성과 종속성이 해결된 상태를 무결성이라고 한다.
INSERT INTO MS_FILE ( FILE_NO, BOARD_NO, FILE_NAME, FILE_DATA, REG_DATE, UPD_DATE, EXT)
VALUES (1, 1, '강아지.png', '123', sysdate, sysdate, 'png');

INSERT INTO MS_FILE ( FILE_NO, BOARD_NO, FILE_NAME, FILE_DATA, REG_DATE, UPD_DATE, EXT)
VALUES (2, 1, 'Main.fxml', '123', sysdate, sysdate, '---');

-- MS_BOARD에 게시글 추가
-- MS_BOARRD는 USER_NUMBER을 참조한다
-- MS_USER에 1번이 없기에 무결성 제약조건 위반
INSERT INTO MS_BOARD ( BOARD_NO, TITLE, CONTENT, WRITER, HIT, LIKE_CNT, DEL_YN, DEL_DATE, REG_DATE, UPD_DATE )
VALUES (1, '제목', '내용', 1, 0, 0, 'N', NULL, sysdate, sysdate);

-- MS_USER에 게시글 추가
INSERT INTO MS_USER( USER_NO, USER_ID, USER_PW, USER_NAME, BIRTH, TEL, ADDRESS, REG_DATE, UPD_DATE, CTZ_NO, GENDER )
VALUES ( 1, 'JOEUN', '123456', '김조은', TO_DATE('2020/01/01', 'YYYY/MM/DD'), '010-1234-1234', '부평', sysdate, sysdate, '200101-334444', '남');

SELECT * FROM MS_USER;
SELECT * FROM MS_BOARD;
SELECT * FROM MS_FILE;

-------------------------------------- 77.

-- 테이블 MS_FILE 의 EXT 속성이 (‘jpg’, ‘jpeg’, ‘gif’, ‘png’) 값을 갖도록 하는 제약조건을 추가하는 SQL문을 작성하시오.
ALTER TABLE MS_FILE ADD CONSTRAINT MS_FILE_EXT_CHECK
CHECK (EXT IN('jpg', 'jpeg', 'gif', 'png') );

-- 제약조건 설정으로 EXT에 제약조건명이 없으면 삽입이 안된다.
INSERT INTO MS_FILE ( FILE_NO, BOARD_NO, FILE_NAME, FILE_DATA, REG_DATE, UPD_DATE, EXT)
VALUES (3, 1, 'Main.java', '123', sysdate, sysdate, 'java');

INSERT INTO MS_FILE ( FILE_NO, BOARD_NO, FILE_NAME, FILE_DATA, REG_DATE, UPD_DATE, EXT)
VALUES (4, 1, '고양이.jpg', '123', sysdate, sysdate, 'jpg');

-- NULL은 체크제약조건이 아닌 NOT NULL 제약조건에 걸린다.
INSERT INTO MS_FILE ( FILE_NO, BOARD_NO, FILE_NAME, FILE_DATA, REG_DATE, UPD_DATE, EXT)
VALUES (5, 1, '제목없음', '123', sysdate, sysdate, NULL);

-------------------------------------- 78.

-- DROP은 구조자체를 삭제한다.
/*
    DELETE vs TRUNCATE
    * DELETE    - 데이터 조작어 (DML)
    - 한 행 단위로 데이터를 삭제한다
    - COMMIT, ROLLBACK 를 이용하여 변경사항을 적용하거나 되돌릴 수 있음
    
    * TRUNCATE  - 데이터 정의어 (DDL)
    - 모든 행을 삭제한다.
    - 삭제된 데이터를 되돌릴수 없다.
*/
-- 아래 <예시> 에 주어진 테이블의 모든 행을 삭제하는 SQL 문을 작성하시오.
-- USER -> BOARD -> FILE 순으로 참조가 되어 있기에 제일 마지막 부터 삭제해야 한다
TRUNCATE TABLE MS_USER;
TRUNCATE TABLE MS_BOARD;
TRUNCATE TABLE MS_FILE;
TRUNCATE TABLE MS_REPLY;

DELETE FROM MS_USER;
DELETE FROM MS_BOARD;
DELETE FROM MS_REPLY;

SELECT * FROM MS_USER;
SELECT * FROM MS_BOARD;
SELECT * FROM MS_FILE;
SELECT * FROM MS_REPLY;

-------------------------------------- 79.

-- <예시> 에 주어진 테이블의 속성을 삭제하는 SQL 문을 작성하시오.
ALTER TABLE MS_BOARD DROP COLUMN WRITER;
ALTER TABLE MS_FILE DROP COLUMN BOARD_NO;
ALTER TABLE MS_REPLY DROP COLUMN BOARD_NO;

-------------------------------------- 80.

-- <예시>에 주어진 속성들을 각 테이블에 추가한 뒤 외래키로 지정하시오. 참조 테이블에 대하여 삭제 시, 연결된 속성의 값도 삭제를 하는 제약조건도 추가하는 SQL 문을 작성하시오.
-- 1) MS_BOARD 에 WRITER 속성 추가
ALTER TABLE MS_BOARD ADD WRITER NUMBER NOT NULL;
ALTER TABLE MS_BOARD
ADD CONSTRAINT MS_BOARD_WRITER_FK
FOREIGN KEY (WRITER) REFERENCES MS_USER(USER_NO)
ON DELETE CASCADE;

-- ON DELETE [NO ACTION, RESTRICT, CASCADE, SET NULL]
-- 부모 삭제시 아래 옵션 발동. 각각의 테이블별로 따로 줘야 한다.
-- * RESTRICT   : 자식 테이블의 데이가 존재하면, 삭제 안함
-- * CASCADE    : 자식 테이블의 데이터도 함께 삭제 // 해
-- * SET NULL   : 자식 테이블의 데이터를 NULL로 변경

-- 2)
ALTER TABLE MS_FILE ADD BOARD_NO NUMBER NOT NULL;
ALTER TABLE MS_FILE
ADD CONSTRAINT MS_FILE_BOARD_NO_FK
FOREIGN KEY (BOARD_NO) REFERENCES MS_BOARD(BOARD_NO)
ON DELETE CASCADE;

--3)
ALTER TABLE MS_REPLY ADD BOARD_NO NUMBER NOT NULL;
ALTER TABLE MS_REPLY
ADD CONSTRAINT MS_REPLY_BOARD_NO_FK
FOREIGN KEY (BOARD_NO) REFERENCES MS_BOARD(BOARD_NO)
ON DELETE CASCADE;

SELECT * FROM MS_USER;
SELECT * FROM MS_BOARD;
SELECT * FROM MS_FILE;
SELECT * FROM MS_REPLY;

-- 회원탈퇴 (회원번호: 1)
DELETE FROM MS_USER WHERE USER_NO = 1;

-- ON DELETE CASCADE 옵션으로 외래키 지정 시, MS_USER 데이터를 삭제하면, MS_BOARD의 참조된 데이터도 연쇄적으로 삭제된다.
-- MS_USER 데이터가 삭제되면, MS_FILE, MS_REPLY에 참조된 데이터도 연쇄적으로 삭제된다.

-- 외래키 제약조건 정리
ALTER TABLE 테이블명
ADD CONSTRAINT 제약조건명 FOREIGN KEY (외래키 속성)
REFERENCES 참조테이블(참조 속성);

-- 옵션
-- ON UPDATE        -- 참조 테이블 수정 시, 아래 옵션이 자식 테이블에 적용
-- ON DELETE        -- 참조 테이블 삭제 시, 아래 옵션이 자식 테이블에 적용

-- * CASCADE        : 자식 데이터 수정
-- * SET NULL       : 자식 데이터는 NULL
-- * SET DEFAULT    : 자식 데이터는 기본값
-- * RESTRICT       : 자식 테이블의 참조하는 데이터가 존재하면, 부모 데이터 수정 불가
-- * NO ACTION      : 아무런 행위도 취하지 않는다 (기본값 - 생략)

-------------------------------------- 81.
/*
    서브쿼리 (Sub Query; 하위 질의)
    : SQL 문 내부에 사용하는 SELECT 문
    * 메인쿼리 : 서브쿼리를 사용하는 최종적인 SELECT문
    
    * 서브쿼리 종류
    - 스칼라 서브쿼리  : SELECT 절에서 사용하는 서브쿼리
    - 인라인 뷰       : FROM 절에서 사용하는 서브쿼리
    - 서브 쿼리       : WHERE 절에서 사용하는 서브쿼리
*/
-- joeun파일 import
imp userid=system/123456 file=D:\Jung\SQL\joeun.dmp fromuser=joeun touser=joeun

-- <예시> 의 테이블 구조와 출력결과를 참고하여, 스칼라 서브쿼리로 출력결과를 조회하는 SQL 문을 작성하시오.
SELECT * FROM employee;
SELECT * FROM department;
SELECT * FROM job;

-- 스칼라 서브쿼리
SELECT   emp_id 사원번호
        , emp_name 직원명
        ,(SELECT dept_title FROM department d WHERE d.dept_id = e.dept_code) 부서명
        ,(SELECT job_name FROM job j WHERE j.job_code = e.job_code) 직급명
FROM employee e;

-------------------------------------- 82.

-- <예시> 의 테이블 구조와 출력결과를 참고하여, 인라인 뷰를 이용하여 부서별로 최고급여를 받는 직원을 조회하는 SQL 문을 작성하시오. (단, 부서코드는 DEPT_CODE, DEPT_ID 이다.
-- 1. 부서별로 최고급여 조회
SELECT dept_code,
    MAX(salary) MAX_SAL,
    MIN(salary) MIN_SAL,
    AVG(salary) AVG_SAL
FROM employee
GROUP BY dept_code;

-- 2. 부서별 초고급여 조회결과를 서브쿼리(인라인 뷰)로 지정
-- 이오리는 부서코드가 없어서 출력이 안된다
SELECT emp_id 사원번호
        ,emp_name 직원명
        ,dept_title 부서명
        ,salary 급여
        ,max_sal 최대급여
        ,min_sal 최저급여
        ,ROUND(avg_sal, 2) 평균급여
FROM employee e, department d,
    (
        SELECT dept_code,
           
            MAX(salary) MAX_SAL,
            MIN(salary) MIN_SAL,
            AVG(salary) AVG_SAL
            FROM employee
            GROUP BY dept_code
    ) t
WHERE e.dept_code = d.dept_id AND e.salary = t.max_sal;

-------------------------------------- 83.

-- 중첩 서브쿼리를 이용하여 직원명이 ‘이태림'인 사원과 같은 부서의 직원들을 조회하는 SQL 문을 작성하시오.
-- 1) dept_code 조회
SELECT dept_code
FROM employee
WHERE emp_name = '이태림';

-- 2) 전체조회
SELECT emp_id 사원번호,
        emp_name 직원명,
        email 이메일,
        phone 전화번호
FROM employee
WHERE dept_code =
(
SELECT dept_code
FROM employee
WHERE emp_name = '이태림'
);

-------------------------------------- 84.
-- 다중행의 조건값 경우 '='는 단일행만 가능하기에 'IN'을 사용한다

-- 테이블 EMPLOYEE 와 DEPARTMENT 의 DEPT_CODE 와 DEPT_ID 속성이 일치하는 행이 존재하는 경우, 테이블 DEPARTMENT 의 데이터를 조회하는 SQL 문을 작성하시오.
-- 1) 서브쿼리를 이용한 방법
SELECT dept_id 부서번호
    , dept_title 부서명
    , location_id 지역명
FROM department
WHERE dept_id IN
(
SELECT DISTINCT dept_code 
FROM employee
WHERE dept_code IS NOT NULL
)
ORDER BY dept_id;

-- 2) EXISTS
-- 데이터가 존재하면 모든 데이터가 출력(TRUE, FALSE)
-- TRUE인 데이터만 남겨두고 FALSE는 버린다.
SELECT dept_id 부서번호
    , dept_title 부서명
    , location_id 지역명
FROM department d
WHERE EXISTS 
(
SELECT *
FROM employee e
WHERE e.dept_code = d.dept_id
)
ORDER BY dept_id;;

-------------------------------------- 85.
-- EMPLOYEE 와 DEPARTMENT 의 DEPT_CODE 와 DEPT_ID 속성이 일치하는 행이 존재하지 않는 경우, 테이블 DEPARTMENT 의 데이터를 조회하는 SQL 문을 작성하시오.
-- 1) 서브쿼리를 이용한 방법
SELECT dept_id 부서번호
    , dept_title 부서명
    , location_id 지역명
FROM department
WHERE dept_id NOT IN
(
SELECT DISTINCT dept_code 
FROM employee
WHERE dept_code IS NOT NULL
)
ORDER BY dept_id;

-- 2) EXISTS
-- 데이터가 존재하면 모든 데이터가 출력(TRUE, FALSE)
-- TRUE인 데이터만 남겨두고 FALSE는 버린다.
SELECT dept_id 부서번호
    , dept_title 부서명
    , location_id 지역명
FROM department d
WHERE NOT EXISTS 
(
SELECT *
FROM employee e
WHERE e.dept_code = d.dept_id
)
ORDER BY dept_id;;

-------------------------------------- 86.

-- EMPLOYEE 의 DEPT_CODE 가 ‘D1’인 부서의 최대급여보다 더 큰 급여를 받는 사원을 조회하는 SQL 문을 작성하시오.
SELECT emp_id 사원번호
        ,emp_name 직원명
        ,dept_code 부서번호
        ,dept_title 부서명
        ,TO_CHAR( salary, '999,999,999') 급여
FROM employee e, department d
WHERE e.dept_code = d.dept_id
AND salary >
(
SELECT MAX(salary)
FROM employee
WHERE dept_code = 'D1'
);

-- ALL
-- : 모든 조건이 만족할 때 결과를 출력하는 연산자
-- 모든 데이터를 하나씩 다 비교한다.
SELECT emp_id 사원번호
        ,emp_name 직원명
        ,dept_code 부서번호
        ,dept_title 부서명
        ,TO_CHAR( salary, '999,999,999') 급여
FROM employee e, department d
WHERE e.dept_code = d.dept_id
    AND e.salary > ALL
                        (
                        SELECT salary
                        FROM employee
                        WHERE dept_code = 'D1'
                        );

-------------------------------------- 87.

-- 테이블 EMPLOYEE 의 DEPT_CODE 가 ‘D9’인 부서의 최저급여보다 더 큰 급여를 받는 사원을 조회하는 SQL 문을 작성하시오.
SELECT emp_id 사원번호
        ,emp_name 직원명
        ,dept_code 부서번호
        ,dept_title 부서명
        ,TO_CHAR( salary, '999,999,999') 급여
FROM employee e, department d
WHERE e.dept_code = d.dept_id
AND salary >
(
SELECT MIN(salary)
FROM employee
WHERE dept_code = 'D9'
);

-- ANY
-- : 조건이 만족하는 값이 하나라도 있으면 결과를 출력하는 연산자
SELECT emp_id 사원번호
        ,emp_name 직원명
        ,dept_code 부서번호
        ,dept_title 부서명
        ,TO_CHAR( salary, '999,999,999') 급여
FROM employee e, department d
WHERE e.dept_code = d.dept_id -- from의 중복을 제거하기 위한 코드
    AND e.salary > ANY
                    (
                    SELECT salary
                    FROM employee
                    WHERE dept_code = 'D9'
                    );

-------------------------------------- 88.
-- LEFT JOIN
-- FROM 테이블1 JOIN 테이블2 ON (조인 조건식)
-- : 왼쪽 데이터 기준의 조합.
-- : 오른쪽 데이터의 빈 영역은 NULL로 나온다.

-- EMPLOYEE 와 DEPARTMENT 를 조인하여 출력하되, 부서가 없는 직원도 포함하여 출력하는 SQL 문을 작성하시오.
SELECT e.emp_id 사원번호
        ,e.emp_name 직원명
        ,NVL(d.dept_id, '(없음)') 부서번호
        ,NVL(d.dept_title, '(없음)') 부서명
FROM employee e LEFT JOIN department d
                ON (d.dept_id = e.dept_code);

-------------------------------------- 89.
-- RIGHT JOIN
-- FROM 테이블1 JOIN 테이블2 ON (조인 조건식)
-- : 오른쪽쪽 데이터 기준의 조합.
-- : 왼쪽 데이터의 빈 영역은 NULL로 나온다.
-- 테이블 EMPLOYEE 와 DEPARTMENT 를 조인하여 출력하되, 직원이 없는 부서도 포함하여 출력하는 SQL 문을 작성하시오.
SELECT NVL (e.emp_id, '(없음)') 사원번호
        ,NVL (e.emp_name, '(없음)') 직원명
        ,dept_id 부서번호
        ,dept_title 부서명
FROM employee e RIGHT JOIN department d ON (e.dept_code = d.dept_id);

-------------------------------------- 90.
-- FULL JOIN
-- 테이블 EMPLOYEE 와 DEPARTMENT 를 조인하여 출력하되, 직원 및 부서 유무에 상관없이 출력하는 SQL 문을 작성하시오.
SELECT NVL (e.emp_id, '(없음)') 사원번호
        ,NVL (e.emp_name, '(없음)') 직원명
        ,NVL (d.dept_id, '(없음)') 부서번호
        ,NVL (d.dept_title, '(없음)') 부서명
FROM employee e FULL JOIN department d ON (e.dept_code = d.dept_id);

-------------------------------------- 91.
-- 중복 조인

-- 조인을 이용하여, <예시> 와 같이 출력되는 SQL 문을 완성하시오.
-- 지역명 : location.local_name
-- 국가명 : national.national_name
SELECT * FROM employee;
SELECT * FROM department;
SELECT * FROM location;
SELECT * FROM national;

SELECT e.emp_id 사원번호
        ,e.emp_name 직원명
        ,d.dept_id 부서번호
        ,d.dept_title 부서명
        ,l.local_name 지역명
        ,e.salary 급여
        ,e.hire_date 입사일자
FROM employee e
    LEFT JOIN department d ON e.dept_code = d.dept_id
    LEFT JOIN location l ON d.location_id = l.local_code
    LEFT JOIN national n ON l.national_code = n.national_code;
    
-------------------------------------- 92.
-- INNER JOIN (JOIN)교집합 출력

-- 조인을 이용하여, <예시> 와 같이 출력되는 SQL 문을 완성하시오.
-- 1) manager_id 컬림이 null이 아닌 사원을 중복없이 조회
-- 매니저들의 사원번호
SELECT DISTINCT manager_id
FROM employee
WHERE manager_id IS NOT NULL;

-- 2) employee, department, job 테이블을 조인하여 조회
SELECT *
FROM employee e
        LEFT JOIN department d ON e.dept_code = d.dept_id
        JOIN job j ON e.job_code = j.job_code;
    
-- 3) 조인 결과 중, EMP_ID가 매니저 사원번호인 경우만을 조회
SELECT e.emp_id 사원번호
        ,e.emp_name 직원명
        ,d.dept_title 부서명
        ,j.job_name 직급
        ,'매니저' 구분
FROM employee e
        LEFT JOIN department d ON e.dept_code = d.dept_id
        JOIN job j ON e.job_code = j.job_code
WHERE emp_id IN (
                SELECT DISTINCT manager_id
                FROM employee
                WHERE manager_id IS NOT NULL
);
    
-------------------------------------- 93.
-- 사원(매니저가 아닌)만 조회하시오
SELECT e.emp_id 사원번호
        ,e.emp_name 직원명
        ,d.dept_title 부서명
        ,j.job_name 직급
        ,'사원' 구분
FROM employee e
        LEFT JOIN department d ON e.dept_code = d.dept_id
        JOIN job j ON e.job_code = j.job_code
WHERE emp_id NOT IN (
                SELECT DISTINCT manager_id
                FROM employee
                WHERE manager_id IS NOT NULL
);
    
-------------------------------------- 94.
-- UNION
-- 2개의 쿼리를 합치는 키워드
-- 2개의 조건값이 동일해야 된다.
-- UNIQUE키를 기준으로 자동 정렬을 한다

SELECT e.emp_id 사원번호
        ,e.emp_name 직원명
        ,d.dept_title 부서명
        ,j.job_name 직급
        ,'매니저' 구분
FROM employee e
        LEFT JOIN department d ON e.dept_code = d.dept_id
        JOIN job j ON e.job_code = j.job_code
WHERE emp_id IN (
                SELECT DISTINCT manager_id
                FROM employee
                WHERE manager_id IS NOT NULL
)
UNION
SELECT e.emp_id 사원번호
        ,e.emp_name 직원명
        ,d.dept_title 부서명
        ,j.job_name 직급
        ,'사원' 구분
FROM employee e
        LEFT JOIN department d ON e.dept_code = d.dept_id
        JOIN job j ON e.job_code = j.job_code
WHERE emp_id NOT IN (
                SELECT DISTINCT manager_id
                FROM employee
                WHERE manager_id IS NOT NULL
);    
    
-------------------------------------- 95.
-- 조인을 이용하여, <예시> 와 같이 출력되는 SQL 문을 완성하시오.(단, CASE 키워드를 이용하시오.)    
SELECT e.emp_id 사원번호
        ,e.emp_name 직원명
        ,d.dept_title 부서명
        ,j.job_name 직급
        ,CASE
         WHEN emp_id IN (
                            SELECT DISTINCT manager_id
                            FROM employee
                            WHERE manager_id IS NOT NULL
                        )
          THEN '매니저' 
          ELSE '사원'
          END 구분
FROM employee e
        LEFT JOIN department d ON e.dept_code = d.dept_id
        JOIN job j ON e.job_code = j.job_code
ORDER BY e.emp_id;

-------------------------------------- 96.

-- 1) 주민등록번호로부터 나이 구하기
SELECT emp_id 사원번호
        ,emp_name 직원명
        , TO_NUMBER(TO_CHAR(sysdate, 'YY'))+100 - TO_NUMBER(SUBSTR(emp_no,1,2)) 나이
FROM employee;

-- 2) 주민등록번호로부터 성별 구하기
SELECT emp_id 사원번호
        ,emp_name 직원명
        ,CASE
        WHEN SUBSTR(emp_no,8,1) IN ('1','3') THEN '남자'
        WHEN SUBSTR(emp_no,8,1) IN ('2','4') THEN '여자'
        END 성별
FROM employee;

--3) 
SELECT e.emp_id 사원번호
        ,e.emp_name 직원명
        ,d.dept_title 부서명
        ,j.job_name 직급
        ,CASE
         WHEN emp_id IN (
                            SELECT DISTINCT manager_id
                            FROM employee
                            WHERE manager_id IS NOT NULL
                        )
          THEN '매니저' 
          ELSE '사원'
          END 구분
        ,CASE
        WHEN SUBSTR(emp_no,8,1) IN ('1','3') THEN '남자'
        WHEN SUBSTR(emp_no,8,1) IN ('2','4') THEN '여자'
        END 성별
        ,TO_NUMBER(TO_CHAR(sysdate, 'YY'))+100 -1 
        - TO_NUMBER(SUBSTR(emp_no,1,2)) 나이
        ,RPAD(SUBSTR(emp_no,1,8),14,'*') 주민등록번호
FROM employee e
        LEFT JOIN department d ON e.dept_code = d.dept_id
        JOIN job j  USING(job_code);
-- USING : 조인하고자 하는 두 테이블의 컴럼명이 같으면, ON 키워드 대신 조인 조건을 간단하게 작성하는 키워드

-------------------------------------- 96.

SELECT ROWNUM 순번 
        ,e.emp_id 사원번호
        ,e.emp_name 직원명
        ,d.dept_title 부서명
        ,j.job_name 직급
        ,CASE
         WHEN emp_id IN (
                            SELECT DISTINCT manager_id
                            FROM employee
                            WHERE manager_id IS NOT NULL
                        )
          THEN '매니저' 
          ELSE '사원'
          END 구분
        ,CASE
        WHEN SUBSTR(emp_no,8,1) IN ('1','3') THEN '남자'
        WHEN SUBSTR(emp_no,8,1) IN ('2','4') THEN '여자'
        END 성별
        ,TO_NUMBER(TO_CHAR(sysdate, 'YY'))+100 -1 - TO_NUMBER(SUBSTR(emp_no,1,2)) 나이
        ,TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date)/12) 근속연수
        ,RPAD(SUBSTR(emp_no,1,8),14,'*') 주민등록번호
        ,TO_CHAR(hire_date, 'YYYY.MM.DD') 입사일자
        ,TO_CHAR(salary + NVL(salary*bonus, 0) * 12, '999,999,999') 연봉
FROM employee e
        LEFT JOIN department d ON e.dept_code = d.dept_id
        JOIN job j USING(job_code);

        
        