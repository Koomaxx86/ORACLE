-- 커서 실행 단축키 : ctrl + enter
-- 문서 전체 실행 : F5
SELECT 1+1
FROM dual;

-------------------------------------- 1. 계정 접속 명령어
-- conn 계정명/비밀번호
-- conn system/123456;

-------------------------------------- 2. 
-- SQL은 대/소문자 구분이 없다.
-- 명령어 키워드 대문자, 식별자는 소문자를 주로 사용한다. (각자 스타일데로)
SELECT user_id, username
FROM all_users
WHERE username = 'HR';

-- # 기본 계정 생성 하기
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
CREATE USER HR IDENTIFIED BY 123456;
ALTER USER HR DEFAULT TABLESPACE users;
ALTER USER HR QUOTA UNLIMITED ON users;
GRANT connect, resource to HR;


-------------------------------------- 3.
-- 테이블 EMPLOYEES 의 테이블 구조를 조회하는 SQL 문을 작성하시오.
DESC employees;

-- 테이블 EMPLOYEES 에서 EMPLOYEE_ID, FIRST_NAME (회원번호, 이름)을 조회하는 SQL문을 작성하시오
-- 사원테이블의 사원번호와, 이름을 조회
SELECT employee_id, first_name
FROM employees;

-------------------------------------- 4.
-- 한글 별칭을 부여하여 조회
-- AS (alias) : 출력되는 컬럼명에 별명을 짓는 명령어

-- 테이블 EMPLOYEES 이 <예시>와 같이 출력되도록 조회하는 SQL 문을 작성하시오.
SELECT employee_id AS "사원 번호" -- 띄어쓰기가 있으면, " "로 표기
        , first_name 이름        -- AS 생략가능(문자에 공백이 없어야 함)
        , last_name AS 성
        , email AS 이메일
        , phone_number AS 전화번호
        , hire_date AS 입사일자
        , salary AS 급여
FROM employees;

--
SELECT *                -- (*) [애스터리크] : 모든 컬럼 지정
FROM employees;

-------------------------------------- 5.
-- DISTINCT 컴럼명 : 중복된 데이터를 제거하고 조회하는 키워드

-- 테이블 EMPLOYEES 의 JOB_ID를 중복된 데이터를 제거하고 조회하는 SQL 문을 작성하시오.
SELECT DISTINCT job_id
FROM employees;

-------------------------------------- 6.
-- WHERE 조건 : 조회 조건을 작성하는 구문

-- 테이블 EMPLOYEES 의 SALARY(급여)가 6000을 초과하는 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
SELECT *
FROM employees
WHERE salary > 6000;

-------------------------------------- 7.
-- 테이블 EMPLOYEES 의 SALARY(급여)가 10000인 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
SELECT *
FROM employees
WHERE salary = 10000;

-------------------------------------- 8.
-- 정렬 명령어
-- ORDER BY 컬럼명 [ASC/DESC];
-- ASC      : 오름차순
-- DESC     : 내림차순
-- (생략)    : 오름차순이 기본값

-- 테이블 EMPLOYEES 의 모든 속성들을 SALARY 를 기준으로 내림차순 정렬하고, FIRST_NAME 을 기준으로 오름차순 정렬하여 조회하는 SQL 문을 작성하시오.
SELECT *
FROM employees
ORDER by salary DESC, first_name ASC ;

-------------------------------------- 9.
-- OR 연산 : ~또는, ~이거나
-- WHERE A OR B;

-- 테이블 EMPLOYEES 의 JOB_ID가 ‘FI_ACCOUNT’ 이거나 ‘IT_PROG’ 인 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
SELECT *
FROM employees
WHERE job_id = 'FI_ACCOUNT' 
   OR job_id = 'IT_PROG';

-------------------------------------- 10.
-- 테이블 EMPLOYEES 의 JOB_ID가 ‘FI_ACCOUNT’ 이거나 ‘IT_PROG’ 인 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
-- <조건> IN 키워드를 사용하여 SQL 쿼리를 완성하시오.
-- 컬럼명 IN ('A','B'...)  : OR 연산을 대체하여 사용할 수 있는 키워드
SELECT *
FROM employees
WHERE job_id IN('FI_ACCOUNT','IT_PROG');

-------------------------------------- 11.
-- 테이블 EMPLOYEES 의 JOB_ID가 ‘FI_ACCOUNT’ 이거나 ‘IT_PROG’ 아닌 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
-- <조건> IN 키워드를 사용하여 SQL 쿼리를 완성하시오.
SELECT *
FROM employees
WHERE job_id NOT IN('FI_ACCOUNT','IT_PROG');

-------------------------------------- 12.
-- 테이블 EMPLOYEES 의 JOB_ID가 ‘IT_PROG’ 이면서 SALARY 가 6000 이상인 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
-- 조건 연산
-- AND 연산 : ~이면서, 그리고, 동시에
-- WHERE A AND B;
SELECT *
FROM employees
WHERE job_id = 'IT_PROG' AND salary >= 6000;

-------------------------------------- 13.
-- 테이블 EMPLOYEES 의 FIRST_NAME 이 ‘S’로 시작하는 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
SELECT *
FROM employees
WHERE first_name LIKE 'S%';

-------------------------------------- 14.
-- 테이블 EMPLOYEES 의 FIRST_NAME 이 ‘s’로 끝나는 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
SELECT *
FROM employees
WHERE first_name LIKE '%s';

-------------------------------------- 15.
-- 테이블 EMPLOYEES 의 FIRST_NAME 에 ‘s’가 포함되는 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
SELECT *
FROM employees
WHERE first_name LIKE '%s%';

-------------------------------------- 16.
-- 테이블 EMPLOYEES 의 FIRST_NAME 이 5글자인 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
SELECT *
FROM employees
WHERE first_name LIKE '_____';

-- LENGTH(컬럼명) : 글자 수를 반환하는 함수
SELECT *
FROM employees
WHERE LENGTH(first_name) = 5; 

-------------------------------------- 17.
-- 테이블 EMPLOYEES 의 COMMISSION_PCT가 NULL 인 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
-- IS NULL : NULL값인지 확인
SELECT *
FROM employees
WHERE commission_pct IS NULL;

-------------------------------------- 18.
-- 테이블 EMPLOYEES 의 COMMISSION_PCT가 NULL이 아닌 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
SELECT *
FROM employees
WHERE commission_pct IS NOT NULL;

-------------------------------------- 19.
-- 테이블 EMPLOYEES 의 사원의 HIRE_DATE가 04년 이상인 모든 컬럼을 조회하는 SQL 문을 작성하시오.
SELECT *
FROM employees
WHERE hire_date >= '04/01/01';      -- SQL Developer 에서 문자형 데이터를 날짜형 데이터로 자동 변환

-- TO_DATE 문자형 데이터를 날짜형으로 변경
-- TO_DATE('문자형 데이터','원하는 날짜 형식')
SELECT *
FROM employees
WHERE hire_date >= TO_DATE('20040101','YYYYMMDD');

-------------------------------------- 20.
-- 테이블 EMPLOYEES 의 사원의 HIRE_DATE가 04년도부터 05년도인 모든 컬럼을 조회하는 SQL 문을 작성하시오.
SELECT *
FROM employees
WHERE hire_date >= TO_DATE('20040101','YYYYMMDD')
  AND hire_date <= TO_DATE('20051231','YYYYMMDD');
  
  SELECT *
FROM employees
WHERE hire_date >= '2004/01/01'
  AND hire_date <= '2005/12/31';
-- 컬럼 BETWEEN A AND B
-- : A 보다 크거나 같고 B 보다 작거나 같은 조건 (사이)
SELECT *
FROM employees
WHERE hire_date BETWEEN TO_DATE('20040101','YYYYMMDD')
  AND TO_DATE('20051231','YYYYMMDD');
  
SELECT *
FROM employees
WHERE hire_date BETWEEN '04/01/01' AND '05/12/31';

-------------------------------------- 21.
-- dual : 산술연산, 함수결과 등을 확인해볼 수 있는 임시 테이블
-- CEIL() "천장"
-- : 지정한 값보다 크거나 같은 정수 중 제일 작은 수를 반환하는 함수

-- 12.45, -12.45 보다 크거나 같은 정수 중 제일 작은 수를 계산하는 SQL 문을 각각 작성하시오.
SELECT CEIL(12.45) FROM dual;
SELECT CEIL(-12.45) FROM dual;
SELECT CEIL(12.45), CEIL(-12.45) FROM dual;  

-------------------------------------- 22.
-- FLOOR() "바닥"
-- : 지정한 값보다 작거나 같은 정수 중 가장 큰 수를 반환하는 함수

-- 12.55와 -12.55 보다 작거나 같은 정수 중 가장 큰 수를 계산하는 SQL 문을 각각 작성하시오.
SELECT FLOOR(12.55) FROM dual;
SELECT FLOOR(-12.55) FROM dual;
SELECT FLOOR(12.55), FLOOR(-12.55) FROM dual;  

-------------------------------------- 23.
-- ROUND(값, 자리수)
-- : 지정한 값을, 해당 자리수에서 반올림하는 함수
-- a a a a a.bbbb
-- ...-2 -1  0123

-- 각 소문제에 제시된 수와 자리 수를 이용하여 반올림하는 SQL문을 작성하시오.
-- 0.54 를 소수점 아래 첫째 자리에서 반올림하시오. → 결과 : 1
SELECT ROUND(0.54,0)
FROM dual;
-- 0.54 를 소수점 아래 둘째 자리에서 반올림하시오. → 결과 : 0.5
SELECT ROUND(0.54,1)
FROM dual;
-- 125.67 을 일의 자리에서 반올림하시오. → 결과 : 130
SELECT ROUND(125.67,-1)
FROM dual;
-- 125.67 을 십의 자리에서 반올림하시오. → 결과 : 100
SELECT ROUND(125.67,-2)
FROM dual;

-------------------------------------- 24.
-- MOD(A, B)
-- : A를 B로 나눈 나머지를 구하는 함수

-- 각 소문제에 제시된 두 수를 이용하여 나머지를 구하는 SQL문을 작성하시오.
-- 3을 8로 나눈 나머지를 구하시오. → 결과 : 3
SELECT MOD(3, 8)
FROM dual;
-- 30을 4로 나눈 나머지를 구하시오. → 결과 : 2
SELECT MOD(30, 4)
FROM dual;

-------------------------------------- 25.
-- POWER(A, B)
-- : A의 B제곱을 구하는 함수

-- 각 소문제에 제시된 두 수를 이용하여 제곱수를 구하는 SQL문을 작성하시오.
-- 2의 10제곱을 구하시오. → 결과 : 1024
SELECT POWER(2, 10)
FROM dual;
-- 2의 31제곱을 구하시오. → 결과 : 2147483648
SELECT POWER(2, 31)
FROM dual;

-------------------------------------- 26.
-- SQRT(A)
-- : A의 제곱근을 구하는 함수
-- : A는 양의 정수와 실수만 사용 가능

--각 소문제에 제시된 수를 이용하여 제곱근을 구하는 SQL문을 작성하시오.
-- 2의 제곱근을 구하시오. → 결과 : 1.41421...
SELECT SQRT(2)
FROM dual;
-- 100의 제곱근을 구하시오. → 결과 : 10
SELECT SQRT(100)
FROM dual;

-------------------------------------- 27.
-- TRUNC(값, 자리수)
-- : 지정한 값을, 해당 자리수에서 절삭하는 함수
-- a a a a a.bbbb
-- ...-2 -1  0123

-- 각 소문제에 제시된 수와 자리 수를 이용하여 해당 수를 절삭하는 SQL문을 작성하시오.
-- 527425.1234 을 소수점 아래 첫째 자리에서 절삭하시오.
SELECT TRUNC(527425.1234,0)
FROM dual;
-- 527425.1234 을 소수점 아래 둘째 자리에서 절삭하시오.
SELECT TRUNC(527425.1234,1)
FROM dual;
-- 527425.1234 을 일의 자리에서 절삭하시오.
SELECT TRUNC(527425.1234,-1)
FROM dual;
-- 527425.1234 을 십의 자리에서 절삭하시오.
SELECT TRUNC(527425.1234,-2)
FROM dual;

-------------------------------------- 28.
-- ABS(A)
-- : 값 A 의 절댓값을 구하여 반환하는 함수

-- 각 소문제에 제시된 수를 이용하여 절댓값을 구하는 SQL문을 작성하시오.
-- -20 의 절댓값을 구하시오.
SELECT ABS(-20)
FROM dual;
-- -12.456 의 절댓값을 구하시오.
SELECT ABS(-12.456)
FROM dual;

-------------------------------------- 29.
-- UPPER : 대문자
-- LOWER : 소문자
-- INITCAP : 첫글자만 대문자

-- <예시>와 같이 문자열을 대문자, 소문자, 첫글자만 대문자로 변환하는 SQL문을 작성하시오
--     원문              대문자              소문자            첫글자만 대문자
-- AlOhA WoRlD~!     ALOHA WORLD~!      aloha world~!       Aloha World~!
SELECT 'AlOhA WoRlD~!' AS 원문
        ,UPPER('AlOhA WoRlD~!') AS 대문자
        ,LOWER('AlOhA WoRlD~!') AS 소문자
        ,INITCAP('AlOhA WoRlD~!') AS "첫글자만 대문자"
FROM dual;
 
 
-------------------------------------- 30.
-- LENGTH('문자열')    : 글자 수
-- LENGTHB('문자열')   : 바이트 수
-- 영문, 숫자, 빈칸 : 1BYTE
-- 한글           : 3BYTE

-- <예시>와 같이 문자열의 글자 수와 바이트 수를 출력하는 SQL문을 작성하시오.
-- <예시1>
-- 문자열 : ‘ALOHA WORLD’
-- 글자 수 바이트 수
--   6       16
SELECT LENGTH('ALOHA WORLD') AS "글자 수"
        ,LENGTHB('ALOHA WORLD') AS "바이트 수"
FROM dual;
-- <예시2>
-- 문자열 : ‘알로하 월드’
-- 글자 수 바이트 수
--   11      11
SELECT LENGTH('알로하 월드') AS "글자 수"
        ,LENGTHB('알로하 월드') AS "바이트 수"
FROM dual;
 
-------------------------------------- 31.
-- CONCAT : 문자열 연결하는 함수
-- || 문자를 병합하는 기호

-- <예시>와 같이 각각 함수와 기호를 이용하여 두 문자열을 병합하여 출력하는 SQL문을 작성하시오.
-- <예시>
-- 문자열1 : ‘ALOHA’
-- 문자열2 : ‘WORLD’
--    함수          기호
-- ALOHAWORLD   ALOHAWORLD
SELECT CONCAT('ALOHA', 'WORLD') AS "함수"
        ,'ALOHA' || 'WORLD' || '123' AS "기호"
FROM dual;

-------------------------------------- 32.
-- SUBSTR(문자열, 시작번호, 글자수)
-- 글자수는 뒤에서부터 -(마이나스)로 순서를 지정할수 있다.

-- <예시>와 같이 주어진 문자열의 일부만 출력하는 SQL문을 작성하시오.
-- <예시>
-- 문자열 : ‘www.alohacampus.com’
--  1       2       3
-- www alohacampus com
SELECT SUBSTR('www.alohacampus.com',1,3) AS "1"
        ,SUBSTR('www.alohacampus.com',5,11) AS "2"
        ,SUBSTR('www.alohacampus.com',-3,3) AS "3"
FROM dual;
-- 문자열 : ‘www.알로하캠퍼스.com’
--  1      2       3
-- www 알로하캠퍼스 com
SELECT SUBSTR('www.알로하캠퍼스.com',1,3) AS "1"
        ,SUBSTR('www.알로하캠퍼스.com',5,6) AS "2"
        ,SUBSTR('www.알로하캠퍼스.com',-3,3) AS "3"
FROM dual;
-- SUBSTRB 바이트로 계산
SELECT SUBSTRB('www.알로하캠퍼스.com',1,3) AS "1"
        ,SUBSTRB('www.알로하캠퍼스.com',5,6*3) AS "2"
        ,SUBSTRB('www.알로하캠퍼스.com',-3,3) AS "3"
FROM dual;

-------------------------------------- 33.
-- INSTR(문자열, 찾을문자, 시작번호, 순서)
-- 단어도 가능하다.

-- <예시>와 같이 문자열에서 특정 문자의 위치를 구하는 SQL문을 작성하시오.
-- <예시>
-- 문자열 : ‘ALOHACAMPUS’
-- 1번째 A    2번째 A   3번째 A
--   1          5        7
SELECT INSTR('ALOHACAMPUS','A',1,1)
FROM dual;
SELECT INSTR('ALOHACAMPUS','A',1,2)
FROM dual;
SELECT INSTR('ALOHACAMPUS','A',1,3)
FROM dual;

-------------------------------------- 34.
-- LPAD(문자열,칸의 수,채울 문자) 
-- : 문자열에 지정한 칸을 확보하고, 왼쪽에 특정 문자로 채움
-- RPAD(문자열,칸의 수,채울 문자) 
-- : 문자열에 지정한 칸을 확보하고, 오른쪽에 특정 문자로 채움

-- <예시>와 같이 대상 문자열을 왼쪽/오른쪽에 출력하고 빈공간을 특정 문자로 채우는 SQL문을 작성하시오.
-- <예시>
-- 문자열: ‘ALOHACAMPUS’
-- 문자 : ‘#’
--          왼쪽                   오른쪽
-- #########ALOHACAMPUS     ALOHACMAPUS#########
SELECT LPAD('ALOHACAMPUS',20,'#') AS "왼쪽"
        ,RPAD('ALOHACAMPUS',20,'#') AS "오른쪽"
FROM dual;

-------------------------------------- 35.
-- TO_CHAR(데이터, '날짜/숫자 형식')
-- : 특정 데이터를 문자열 형식으로 변환하는 함수
-- : 날짜형 -> 문자형

-- 테이블 EMPLOYEES 의 FIRST_NAME과 HIRE_DATE 를 검색하되 <예시>와 같이 날짜 형식을 지정하는 SQL 문을 작성하시오. (HR 계정 샘플 데이터)
-- <예시>
-- 이름                   입사일자
-- Steven       2003-06-17 (화) 12:00:00
-- Neena        2005-09-21 (수) 12:00:00
-- Lex          2001-01-13 (토) 12:00:00
-- Alexander    2006-01-03 (화) 12:00:00
-- Bruce        2007-05-21 (월) 12:00:00
-- David        2005-06-25 (토) 12:00:00
SELECT first_name AS 이름 
            ,TO_CHAR(hire_date, 'YYYY-MM-DD (dy) HH:MI:SS') AS 입사일자
FROM employees;

-------------------------------------- 36.
-- 9는 유효한 숫자범위로 실제 데이터가 있는 자리수만큼만 출력
-- 0은 무조건 출력. 데이터가 없으면 0으로 출력

-- 테이블 EMPLOYEES 의 FIRST_NAME과 SALARY 를 검색하되 <예시>와 같이 날짜 형식을 지정하는 SQL 문을 작성하시오. (HR 계정 샘플 데이터)
-- <예시>
-- 이름           급여
-- Steven       $24,000
-- Neena        $17,000
-- Lex          $17,000
-- Alexander    $9,000
-- Bruce        $6,000
-- David        $4,800
SELECT first_name AS "이름"
    , salary AS "급여"
    , TO_CHAR(salary, '$999,999,999.00') "급여"
FROM employees;

-------------------------------------- 37.
-- TO_DATE(데이터)
-- : 문자형 데이터를 날짜형 데이터로 변환하는 함수
-- : 해당 문자형 데이터를 날짜형으로 분석할 수 있는 형식을 지정해야함.

-- <예시> 와 같이 문자형으로 주어진 데이터를 날짜형 데이터로 변환하는 SQL 문을 작성하시오.
-- <예시>
--   문자         날짜
-- 20220712     22/07/12.
SELECT '20220712' AS "문자"
    ,TO_DATE('20220712', 'YYYYMMDD') AS "날짜"
FROM dual;

-------------------------------------- 38.
-- TO_NUMBER(데이터)
-- : 문자형 데이터를 숫자형 데이터로 변환하는 함수

-- <예시> 와 같이 문자형으로 주어진 데이터를 숫자형 데이터로 변환하는 SQL 문을 작성하시오.
-- <예시>
--   문자         숫자
-- 1,200,000    1200000
SELECT '1,200,000' AS "문자"
    , TO_NUMBER('1,200,000', '999,999,999,999') AS "숫자"
FROM dual;

-------------------------------------- 39.
-- SYSDATE : 현재 날짜/시간 정보를 가지고 있는 키워드

-- <예시>와 같이 현재 날짜를 반환하는 SQL 문을 작성하시오.
-- <예시>
--    어제          오늘         내일
-- 2022/08/01   2022/08/02   2022/08/03
SELECT SYSDATE-1 AS "어제"
    ,SYSDATE AS "오늘"
    ,SYSDATE+1 AS "내일"
FROM dual;

-------------------------------------- 40.
-- MONTHS_BETWEEN(A, B)
-- : 날짜 A부터 B까지 개월 수 차이를 반환하는 함수
-- : (단, A > B 즉, A가 더 최근 날짜로 지정되어야 양수로 반환)

-- <예시> 와 같이 입사일자와 오늘 날짜를 계산하여 근무달수와 근속연수를 구하는 SQL 문을 작성하시오.
-- <예시>
-- 이름           입사일자            오늘         근무달수     근속연수
-- Steven       2003.06.17      2021.06.29      216개월       18년
-- Neena        2005.09.21      2021.06.29      189개월       15년
-- Lex          2001.01.13      2021.06.29      245개월       20년
-- Alexander    2006.01.03      2021.06.29      185개월       15년
-- Bruce        2007.05.21      2021.06.29      169개월       14년
-- David        2005.06.25      2021.06.29      192개월       16년
SELECT first_name AS "이름"
    , TO_CHAR(hire_date, 'YYYY.MM.DD')  AS "입사일자"
    , TO_CHAR(SYSDATE, 'YYYY.MM.DD') AS "오늘"
    , TRUNC (SYSDATE - hire_date, 0) AS "근무일수"
    , TRUNC(MONTHS_BETWEEN( SYSDATE, hire_date)) || '개월' AS "근무달수"
    , TRUNC(MONTHS_BETWEEN( SYSDATE, hire_date)/12) || '년' AS "근속연수"
FROM employees;

-------------------------------------- 41.
-- ADD_MONTHS(날짜, 개월 수)
-- : 지정한 날짜로부터 해당 개월 수 후의 날짜를 반환하는 함수

-- <예시> 와 같이 오늘 날짜와 6개월 후의 날짜를 출력하는 SQL 문을 작성하시오.<예시>
--   오늘         6개월후
-- 22/06/01     22/12/01
SELECT SYSDATE AS "오늘"
    , ADD_MONTHS(SYSDATE, 6) AS "6개월 후"
FROM dual;

SELECT '2023/07/25' AS "개강"
    , ADD_MONTHS('2023/07/25', 6) AS "종강"
FROM dual;

-------------------------------------- 42.
-- NEXT_DAY(날짜, 요일)
-- : 지정한 날짜 이후 돌아오는 요일을 반환하는 함수
-- 일  월  화  수  목  금  토
-- 1   2   3  4   5   6  7

-- <예시> 와 같이 오늘 날짜와 오늘 이후 돌아오는 토요일의 날짜를 출력하는 SQL 문을 작성하시오.
-- <예시>
--   오늘        다음 토요일
-- 22/08/01      22/08/06
SELECT SYSDATE AS "오늘"
    , NEXT_DAY(SYSDATE, 7) AS "다음 토요일"
FROM dual;

SELECT NEXT_DAY(SYSDATE, 1) AS "다음 일요일"
,NEXT_DAY(SYSDATE, 2) AS "다음 월요일"
,NEXT_DAY(SYSDATE, 3) AS "다음 화요일"
,NEXT_DAY(SYSDATE, 4) AS "다음 수요일"
,NEXT_DAY(SYSDATE, 5) AS "다음 목요일"
,NEXT_DAY(SYSDATE, 6) AS "다음 금요일"
,NEXT_DAY(SYSDATE, 7) AS "다음 토요일"
FROM dual;

-------------------------------------- 43.
-- LAST_DAY(날짜)
-- : 지정한 날짜와 동일한 월의 월말 일자를 반환하는 함수
-- 날짜 : XXXX.YYYYYY
-- 1970년01월01일 00시00분00초00ms -> 현재 날짜 시간
-- 지난 일자를 정수로 계산, 시간정보는 소수부분으로 계산
-- xxxxx.yyyyy 날짜 데이터를 월 단위로 절삭하면, 월초를 구할 수 있다.

-- <예시> 와 같이 오늘 날짜와 월초, 월말 일자를 구하는 SQL 문을 작성하시오.
-- <예시>
--    오늘         월초         월말
-- 22/08/15     22/08/01    22/08/31
SELECT TRUNC(SYSDATE, 'MM') AS "월초" -- 월 기준 절삭
        , SYSDATE AS "오늘"
        , LAST_DAY(SYSDATE) AS "월말"
FROM dual;

-------------------------------------- 44.
-- NVL(값, 대체할 값)
-- : 해당 값이 NULL 이면 지정된 값으로 변환하는 함수

-- 테이블 EMPLOYEES 의 COMMISSION_PCT 를 중복없이 검색하되, NULL 이면 0으로 조회하고 내림차순으로 정렬하는SQL 문을 작성하시오. (HR 계정 샘플 데이터)
-- <예시>
-- 커미션(%)
-- 0.4
-- 0.35
-- 0.3
-- 0.25
-- 0.2
-- 0.15
-- 0.1
-- 0
-- 1단계
SELECT DISTINCT commission_pct
FROM employees;
-- 2단계
SELECT DISTINCT NVL(commission_pct,0)
FROM employees;
-- 3단계
-- SELECT 문 실행순서
-- FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY
-- 별칭으로 지정한 "커미션"DMS SELECT에서 선언했기에 ORDER BY에서 호출해서 사용가능하다.
SELECT DISTINCT NVL(commission_pct,0) AS "커미션(%)"
FROM employees
ORDER BY "커미션(%)" DESC;

-------------------------------------- 45.
-- NVL2(값, NULL 아닐 떄 값, NULL 일 때 값)

-- 테이블 EMPLOYEES 의 FIRST_NAME, SALARY, COMMISSION_PCT 속성을 이용하여 <예시>와 같이 SQL 문을 작성하시오. (HR 계정 샘플 데이터)
-- <조건>
--  최종급여 = 급여 + (급여x커미션)
--  최종급여를 기준으로 내림차순 정렬
-- <예시>
--  이름      급여   커미션   최종급여
-- Steven   24000   0       24000
-- John     14000   0.4     19600
-- Karen    13500   0.3     17550
-- Lex      17000   0       17000
-- Neena    17000   0       17000
-- Alberto  12000   0.3     15600
SELECT first_name AS "이름"
    , salary AS "급여"
    , NVL(commission_pct, 0) AS "커미션"
    , salary +(salary * NVL(commission_pct, 0)) AS "최종급여1"
    , NVL2(commission_pct, salary + salary * commission_pct, salary) AS "최종급여2" 
FROM employees;

-------------------------------------- 46.
-- DECODE( 컬럼명, 조건값1, 반환값1, 조건값2, 반환값2,...)
-- : 지정한 컬럼의 값이 조건값에 일치하면 바로 뒤에 반환값을 출력하는 함수

-- 테이블 EMPLOYEES 의 FIRST_NAME, DEPARTMENT_ID 속성을 이용하여 <예시>와 같이 SQL 문을 작성하시오.(HR 계정 샘플 데이터)
-- <조건>
-- DECODE 함수를 이용하시오.
-- 부서명은 HR 계정의 DEPARTMENTS 테이블을 참조하시오.
-- <예시>
--  이름          부서
-- Steven       Marketing
-- Neena        Marketing
-- Alexander    IT
-- Bruce        IT
-- David        IT
-- Valli        IT
SELECT first_name AS "이름"
    , DECODE( department_id, 10, 'Administration',
                             20, 'Marketing',
                             30, 'Purchasing',
                             40, 'Human Resources',
                             50, 'Shipping',
                             60, 'IT',
                             70, 'Public Relations',
                             80, 'Sales',
                             90, 'Executive',
                             100, 'Finance') AS "부서"
FROM employees;

-------------------------------------- 47.
-- CASE 문
-- : 조건식을 만족할 때, 출력할 값을 지정하는 구문
-- CASE
--  WHEN 조건식 THEN 반환값1
--  WHEN 조건식 THEN 반환값2
--  WHEN 조건식 THEN 반환값3
-- END

-- 테이블 EMPLOYEES 의 FIRST_NAME, DEPARTMENT_ID 속성을 이용하여 <예시>와 같이 SQL 문을 작성하시오.(HR 계정 샘플 데이터)
-- <조건>
-- CASE 함수를 이용하시오.
-- 부서명은 HR 계정의 DEPARTMENTS 테이블을 참조하시오.
-- <예시>
--  이름          부서
-- Steven       Marketing
-- Neena        Marketing
-- Alexander    IT
-- Bruce        IT
-- David        IT
-- Valli        IT
-- 한 줄 복사 : ctrl + shift + d
SELECT first_name 이름
        , CASE WHEN department_id = 10 THEN 'Administration'
              WHEN department_id = 20 THEN 'Marketing'
              WHEN department_id = 30 THEN 'Purchasing'
              WHEN department_id = 40 THEN 'Human Resources'
              WHEN department_id = 50 THEN 'Shipping'
              WHEN department_id = 60 THEN 'IT'
              WHEN department_id = 70 THEN 'Public Relations'
              WHEN department_id = 80 THEN 'Sales'
              WHEN department_id = 90 THEN 'Executive'
              WHEN department_id = 100 THEN 'Finance'
        END 부서
FROM employees;

-------------------------------------- 48.
-- COUNT( 컬럼명 )
-- : 컬럼을 지정하여 NULL을 제외한 데이터 개수를 반환하는 함수
-- : NULL 이 없는 데이터라면 어떤 컬럼을 지정하더라도 개수가 같기 떄문에,
--   일반적으로, COUNT(*) 로 개수를 구한다.
-- 다음 <예시> 와 같이 테이블 EMPLOYEES 의 사원 수를 구하는 SQL 문을 작성하시오.
SELECT COUNT(*) 사원수
        ,COUNT(commission_pct) 커미션받는사원수
        ,COUNT(department_id) 부서가있는사원수
FROM employees;

-------------------------------------- 49.

-- 테이블 EMPLOYEES 의 최고급여, 최저급여를 구하는 SQL 문을 작성하시오.
SELECT MAX(salary) 최고급여
    , MIN(salary) 최저급여
FROM employees;

-------------------------------------- 50.

-- 테이블 EMPLOYEES 의 급여합계, 급여평균을 구하는 SQL 문을 작성하시오.
SELECT SUM(salary) 급여합계
    , TRUNC(AVG(salary),2) 급여평균
FROM employees;

-------------------------------------- 51.

-- 테이블 EMPLOYEES 의 급여표준편자와 급여분산을 구하는 SQL 문을 작성하시오.
SELECT ROUND(STDDEV(salary),2) 급여표준편차
    , ROUND(VARIANCE(salary),2) 급여분산
FROM employees;

-------------------------------------- 52.

-- MS_STUDENT 테이블에 속성을 추가하는 SQL 문을 작성하시오.
-- 테이블 생성
/*
    CREATE TABLE 테이블명 (
        컴럼명1    타입  [DEFAULT 기본값] [NOT NULL/NULL] [제약조건],
        컴럼명1    타입  [DEFAULT 기본값] [NOT NULL/NULL] [제약조건],
        컴럼명1    타입  [DEFAULT 기본값] [NOT NULL/NULL] [제약조건],
        ...
    );      
*/

CREATE TABLE MS_STUDENT (
    ST_NO       NUMBER          NOT NULL                    PRIMARY KEY
    ,NAME       VARCHAR2(20)    NOT NULL
    ,CTZ_NO     CHAR(14)        NOT NULL
    ,EMAIL      VARCHAR2(100)   NOT NULL                    UNIQUE
    ,ADDRESS    VARCHAR2(1000)  NULL
    ,DEPT_NO    NUMBER          NOT NULL
    ,MJ_NO      NUMBER          NOT NULL
    ,REG_DATE   DATE            DEFAULT sysdate NOT NULL
    ,UPD_DATE   DATE            DEFAULT sysdate NOT NULL
    ,ETC        VARCHAR2(1000)  DEFAULT '없음' NULL
    );
    
COMMENT ON TABLE MS_STUDENT IS '학생들의 정보를 관리한다.';
COMMENT ON COLUMN MS_STUDENT.ST_NO IS '학생 번호';
COMMENT ON COLUMN MS_STUDENT.NAME IS '이름';
COMMENT ON COLUMN MS_STUDENT.CTZ_NO IS '주민등록번호';
COMMENT ON COLUMN MS_STUDENT.EMAIL IS '이메일';
COMMENT ON COLUMN MS_STUDENT.ADDRESS IS '주소';
COMMENT ON COLUMN MS_STUDENT.DEPT_NO IS '학부번호';
COMMENT ON COLUMN MS_STUDENT.MJ_NO IS '전공번호';
COMMENT ON COLUMN MS_STUDENT.REG_DATE IS '등록일자';
COMMENT ON COLUMN MS_STUDENT.UPD_DATE IS '수정일자';
COMMENT ON COLUMN MS_STUDENT.ETC IS '특이사항';

DROP TABLE MS_STUDENT;
-------------------------------------- 53.
-- 테이블에 속성 추가
-- ALTER TABLE 테이블명 ADD 컴럼명 타입 DEFAULT 기본값 [NOT NULL];

-- MS_STUDENT 테이블에 속성을 추가하는 SQL 문을 작성하시오.
ALTER TABLE MS_STUDENT ADD GENDER CHAR(6) DEFAULT '기타' NOT NULL;
COMMENT ON COLUMN MS_STUDENT.GENDER IS '성별';

ALTER TABLE MS_STUDENT ADD STATUS VARCHAR2(10) DEFAULT '대기' NOT NULL;
COMMENT ON COLUMN MS_STUDENT.STATUS IS '재적';

ALTER TABLE MS_STUDENT ADD ADM_DATE DATE NULL;
COMMENT ON COLUMN MS_STUDENT.ADM_DATE IS '입학일자';

ALTER TABLE MS_STUDENT ADD GRD_DATE DATE NULL;
COMMENT ON COLUMN MS_STUDENT.GRD_DATE IS '졸업일자';

-- 테이블 속성 삭제
-- ALTER TABLE 테이블명 DROP COLUMN 컬럼명;
ALTER TABLE MS_STUDENT DROP COLUMN GENDER;
ALTER TABLE MS_STUDENT DROP COLUMN STATUS;
ALTER TABLE MS_STUDENT DROP COLUMN ADM_DATE;
ALTER TABLE MS_STUDENT DROP COLUMN GRD_DATE;

DESC MS_STUDENT;

-------------------------------------- 54.

-- MS_STUDENT 테이블의 주민번호 속성을 생년월일 속성으로 수정하는 SQL 문을 작성하시오.
-- RENAME A TO B 
-- : 이름변경
ALTER TABLE MS_STUDENT RENAME COLUMN CTZ_NO TO BIRTH;
-- MODIFY A B 
-- : 속성변경
ALTER TABLE MS_STUDENT MODIFY BIRTH DATE;
COMMENT ON COLUMN MS_STUDENT.BIRTH IS '생년월일';

-- 속성 변경 - 타입변경
ALTER TABLE MS_STUDENT MODIFY BIRTH DATE;
-- 속성 변경 - NULL 여부변경
ALTER TABLE MS_STUDENT MODIFY BIRTH NULL;
-- 속성 변경 - DEFAULT 변경
ALTER TABLE MS_STUDENT MODIFY BIRTH DEFAULT sysdate;

-- 동시에 적용 가능
ALTER TABLE MS_STUDENT MODIFY BIRTH DATE DEFAULT sysdate NOT NULL;

-------------------------------------- 55.

-- MS_STUDENT 테이블의 학부번호 속성을 삭제하는 SQL 문을 작성하시오.
ALTER TABLE MS_STUDENT DROP COLUMN DEPT_NO;

-------------------------------------- 56.

-- MS_STUDENT 테이블을 삭제하는 SQL 문을 작성하시오.
DROP TABLE MS_STUDENT;

-------------------------------------- 57.

-- TABLE 기술서를 참고하여 MS_STUDENT 테이블을 생성하는 SQL 문을 작성하시오.
CREATE TABLE MS_STUDENT (
     ST_NO      NUMBER          NOT NULL   PRIMARY KEY
    ,NAME       VARCHAR2(20)    NOT NULL
    ,BIRTH      DATE            NOT NULL
    ,EMAIL      VARCHAR2(100)   NOT NULL
    ,ADDRESS    VARCHAR2(1000)  NULL
    ,MJ_NO      VARCHAR2(10)          NOT NULL
    ,GENDER     CHAR(6)         DEFAULT '기타'    NOT NULL
    ,STATUS     VARCHAR2(10)    DEFAULT '대기'    NOT NULL
    ,ADM_DATE   DATE    NULL
    ,GRD_DATE   DATE    NULL
    ,REG_DATE   DATE    DEFAULT sysdate NOT NULL
    ,UPD_DATE   DATE    DEFAULT sysdate NOT NULL
    ,ETC        VARCHAR2(1000)  DEFAULT '없음' NULL
);
COMMENT ON TABLE MS_STUDENT IS '학생들의 정보를 관리한다.';
COMMENT ON COLUMN MS_STUDENT.ST_NO IS '학생 번호';
COMMENT ON COLUMN MS_STUDENT.NAME IS '이름';
COMMENT ON COLUMN MS_STUDENT.BIRTH IS '생년월일';
COMMENT ON COLUMN MS_STUDENT.EMAIL IS '이메일';
COMMENT ON COLUMN MS_STUDENT.ADDRESS IS '주소';
COMMENT ON COLUMN MS_STUDENT.MJ_NO IS '전공번호';

COMMENT ON COLUMN MS_STUDENT.GENDER IS '성별';
COMMENT ON COLUMN MS_STUDENT.STATUS IS '재적';
COMMENT ON COLUMN MS_STUDENT.ADM_DATE IS '입학일자';
COMMENT ON COLUMN MS_STUDENT.GRD_DATE IS '졸업일자';

COMMENT ON COLUMN MS_STUDENT.REG_DATE IS '등록일자';
COMMENT ON COLUMN MS_STUDENT.UPD_DATE IS '수정일자';
COMMENT ON COLUMN MS_STUDENT.ETC IS '특이사항';

-------------------------------------- 57.

-- MS_STUDENT 테이블에 데이터를 삽입하는 SQL 문을 작성하시오.
INSERT INTO MS_STUDENT ( ST_NO,NAME,BIRTH,EMAIL,ADDRESS,MJ_NO,
                        GENDER,STATUS,ADM_DATE,GRD_DATE,REG_DATE,
                        UPD_DATE,ETC)
                        
VALUES( '20180001', '최서아', '991005', 'csa@univ.ac.kr', '서울', 'I01',
        '여', '재학', '2018/03/01', NULL, sysdate, sysdate, NULL);
        
INSERT INTO MS_STUDENT ( ST_NO, NAME, BIRTH, EMAIL, ADDRESS, MJ_NO, 
                        GENDER, STATUS, ADM_DATE, GRD_DATE, REG_DATE, UPD_DATE, ETC )
                        
VALUES ( '20210001', '박서준', TO_DATE('2002/05/04', 'YYYY/MM/DD'), 'psj@univ.ac.kr', '서울', 'B02',
         '남', '재학', TO_DATE('2021/03/01', 'YYYY/MM/DD'), NULL, sysdate, sysdate, NULL );


INSERT INTO MS_STUDENT ( ST_NO, NAME, BIRTH, EMAIL, ADDRESS, MJ_NO, 
                        GENDER, STATUS, ADM_DATE, GRD_DATE, REG_DATE, UPD_DATE, ETC )
VALUES ( '20210002', '김아윤', TO_DATE('2002/05/04', 'YYYY/MM/DD'), 'kay@univ.ac.kr', '인천', 'S01',
         '여', '재학', TO_DATE('2021/03/01', 'YYYY/MM/DD'), NULL, sysdate, sysdate, NULL );

INSERT INTO MS_STUDENT ( ST_NO, NAME, BIRTH, EMAIL, ADDRESS, MJ_NO, 
                        GENDER, STATUS, ADM_DATE, GRD_DATE, REG_DATE, UPD_DATE, ETC )
VALUES ( '20160001', '정수안', TO_DATE('1997/02/10', 'YYYY/MM/DD'), 'jsa@univ.ac.kr', '경남', 'J01',
         '여', '재학', TO_DATE('2016/03/01', 'YYYY/MM/DD'), NULL, sysdate, sysdate, NULL );

INSERT INTO MS_STUDENT ( ST_NO, NAME, BIRTH, EMAIL, ADDRESS, MJ_NO, 
                        GENDER, STATUS, ADM_DATE, GRD_DATE, REG_DATE, UPD_DATE, ETC )
VALUES ( '20150010', '윤도현', TO_DATE('1996/03/11', 'YYYY/MM/DD'), 'ydh@univ.ac.kr', '제주', 'K01',
         '남', '재학', TO_DATE('2016/03/01', 'YYYY/MM/DD'), NULL, sysdate, sysdate, NULL );


INSERT INTO MS_STUDENT ( ST_NO, NAME, BIRTH, EMAIL, ADDRESS, MJ_NO, 
                        GENDER, STATUS, ADM_DATE, GRD_DATE, REG_DATE, UPD_DATE, ETC )
VALUES ( '20130007', '안아람', TO_DATE('1994/11/24', 'YYYY/MM/DD'), 'aar@univ.ac.kr', '경기', 'Y01',
         '여', '재학', TO_DATE('2013/03/01', 'YYYY/MM/DD'), NULL, sysdate, sysdate, '영상예술 특기자' );


INSERT INTO MS_STUDENT ( ST_NO, NAME, BIRTH, EMAIL, ADDRESS, MJ_NO, 
                        GENDER, STATUS, ADM_DATE, GRD_DATE, REG_DATE, UPD_DATE, ETC )
VALUES ( '20110002', '한성호', TO_DATE('1992/10/07', 'YYYY/MM/DD'), 'hsh@univ.ac.kr', '서울', 'E03',
         '남', '재학', TO_DATE('2015/03/01', 'YYYY/MM/DD'), NULL, sysdate, sysdate, NULL );

SELECT * FROM MS_STUDENT;

-------------------------------------- 59.

-- MS_STUDENT 테이블에 데이터를 수정하는 SQL 문을 작성하시오.
/*
    UPDATE 테이블명
        SET 컬럼1 = 변경할 값,
            컴럼2 = 변경할 값,
            ...
    WHERE 조건;        
*/
-- 1) 학생번호가 20160001인 학생의 주소를 '서울'로, 재적상태를 '휴학'으로 수정하시오
UPDATE MS_STUDENT
    SET address = '서울'
        ,status = '휴학'
WHERE ST_NO = '20160001';        

--2) 
UPDATE MS_STUDENT
    SET address = '서울'
        ,status = '졸업'
        ,GRD_DATE = '20200220'
        ,UPD_DATE = SYSDATE
        ,ETC = '수석'
WHERE ST_NO = '20150010'; 

--3)
UPDATE MS_STUDENT
    SET status = '졸업'
        ,GRD_DATE = '20200220'
        ,UPD_DATE = SYSDATE
WHERE ST_NO = '20130007'; 

--4)
UPDATE MS_STUDENT
    SET status = '퇴학'
        ,ETC = '자진 퇴학'
        ,UPD_DATE = SYSDATE
WHERE ST_NO = '20110002'; 

SELECT *
FROM MS_STUDENT;

-------------------------------------- 60.

-- MS_STUDENT 테이블에 데이터를 삭제하는 SQL 문을 작성하시오.
DELETE FROM MS_STUDENT
WHERE ST_NO = '20110002';

-------------------------------------- 61.

-- MS_STUDENT 테이블의 모든 속성을 조회하는 SQL 문을 작성하시오.
SELECT *
FROM MS_STUDENT;

-------------------------------------- 62.

-- MS_STUDENT 테이블의 모든 속성을 조회하여 MS_STUDENT_BACK 테이블을 생성하는 SQL 문을 작성하시오.
-- 백업 테이블 만들기
CREATE TABLE MS_STUDENT_BACK -- 백업용 테이블 생성 
AS SELECT * -- 모든 데이터 선택
FROM MS_STUDENT; -- 백업할 파일 선택

SELECT *
FROM MS_STUDENT_BACK;

-------------------------------------- 63.

-- MS_STUDENT 테이블의 튜플을 삭제하는 SQL 문을 작성하시오.
DELETE FROM MS_STUDENT; -- 행 전체를 삭제하기에 컬럼만 선택이 불가능하다.

-------------------------------------- 64.

-- MS_STUDENT_BACK 테이블의 모든 속성을 조회하여 MS_STUDENT 테이블에 삽입하는 SQL 문을 작성하시오.
INSERT INTO MS_STUDENT
SELECT *
FROM MS_STUDENT_BACK;

SELECT *
FROM MS_STUDENT;

-------------------------------------- 65.

-- MS_STUDENT 테이블의 성별 속성이 (‘여’, ‘남‘, ‘기타‘ ) 값만 입력가능하도록 하는 제약조건을 추가하시오.
ALTER TABLE MS_STUDENT
ADD CONSTRAINT MS_STD_GENDER_CHECK
CHECK (gender IN ('여', '남', '기타'));

UPDATE MS_STUDENT
    SET GENDER = '???';
    
-- CHECK 제약조건
-- 지정한 값이 아닌 다른 값을 입력/수정하는 경우
-- "체크 제약조건이 위배되었습니다" 에러 발생

-- 제약조건
-- 기본키 (PRIMARY KEY)
-- : 중복 불가, NULL 불가 (필수 입력)
-- * 해당 테이블의 데이터를 고유하게 구분할 수 있는 속성으로 지정

-- 고유키 (UNIQUE KEY)
-- : 중복 불가, NULL 허용
-- * 중복되지 않아야할 데이터(ID, 주민번호, 이메일, ...)

-- CHECK
-- 지정한 값만 입력/수정 가능하도록 제한하는 조건
-- 지정한 값이 아닌 다른 값을 입력/수정하는 경우
-- "체크 제약조건이 위배되었습니다" 에러 발생