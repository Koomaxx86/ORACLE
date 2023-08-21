-- Ŀ�� ���� ����Ű : ctrl + enter
-- ���� ��ü ���� : F5
SELECT 1+1
FROM dual;

-- 1. ���� ���� ��ɾ�
-- conn ������/��й�ȣ
-- conn system/123456;

-- 2. 
-- SQL�� ��/�ҹ��� ������ ����.
-- ��ɾ� Ű���� �빮��, �ĺ��ڴ� �ҹ��ڸ� �ַ� ����Ѵ�. (���� ��Ÿ�ϵ���)
SELECT user_id, username
FROM all_users
WHERE username = 'HR';

-- # �⺻ ���� ���� �ϱ�
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
CREATE USER HR IDENTIFIED BY 123456;
ALTER USER HR DEFAULT TABLESPACE users;
ALTER USER HR QUOTA UNLIMITED ON users;
GRANT connect, resource to HR;


-- 3.
-- ���̺� EMPLOYEES �� ���̺� ������ ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
DESC employees;

-- ���̺� EMPLOYEES ���� EMPLOYEE_ID, FIRST_NAME (ȸ����ȣ, �̸�)�� ��ȸ�ϴ� SQL���� �ۼ��Ͻÿ�
-- ������̺��� �����ȣ��, �̸��� ��ȸ
SELECT employee_id, first_name
FROM employees;

-- 4.
-- ���̺� EMPLOYEES �� <����>�� ���� ��µǵ��� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
-- �ѱ� ��Ī�� �ο��Ͽ� ��ȸ
-- AS (alias) : ��µǴ� �÷��� ������ ���� ��ɾ�
SELECT employee_id AS "��� ��ȣ" -- ���Ⱑ ������, " "�� ǥ��
        , first_name �̸�        -- AS ��������(���ڿ� ������ ����� ��)
        , last_name AS ��
        , email AS �̸���
        , phone_number AS ��ȭ��ȣ
        , hire_date AS �Ի�����
        , salary AS �޿�
FROM employees;

--
SELECT *                -- (*) [�ֽ��͸�ũ] : ��� �÷� ����
FROM employees;

-- 5.
-- ���̺� EMPLOYEES �� JOB_ID�� �ߺ��� �����͸� �����ϰ� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
-- DISTINCT �ķ��� : �ߺ��� �����͸� �����ϰ� ��ȸ�ϴ� Ű����
SELECT DISTINCT job_id
FROM employees;

-- 6.
-- ���̺� EMPLOYEES �� SALARY(�޿�)�� 6000�� �ʰ��ϴ� ����� ��� �÷��� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
-- WHERE ���� : ��ȸ ������ �ۼ��ϴ� ����
SELECT *
FROM employees
WHERE salary > 6000;

-- 7.
-- ���̺� EMPLOYEES �� SALARY(�޿�)�� 10000�� ����� ��� �÷��� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT *
FROM employees
WHERE salary = 10000;

-- 8.
-- ���� ��ɾ�
-- ���̺� EMPLOYEES �� ��� �Ӽ����� SALARY �� �������� �������� �����ϰ�, FIRST_NAME �� �������� �������� ����
-- �Ͽ� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
-- ORDER BY �÷��� [ASC/DESC];
-- ASC      : ��������
-- DESC     : ��������
-- (����)    : ���������� �⺻��
SELECT *
FROM employees
ORDER by salary DESC, first_name ASC ;

-- 9.
-- ���̺� EMPLOYEES �� JOB_ID�� ��FI_ACCOUNT�� �̰ų� ��IT_PROG�� �� ����� ��� �÷��� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
-- OR ���� : ~�Ǵ�, ~�̰ų�
-- WHERE A OR B;
SELECT *
FROM employees
WHERE job_id = 'FI_ACCOUNT' 
   OR job_id = 'IT_PROG';

-- 10.
-- ���̺� EMPLOYEES �� JOB_ID�� ��FI_ACCOUNT�� �̰ų� ��IT_PROG�� �� ����� ��� �÷��� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
-- <����> IN Ű���带 ����Ͽ� SQL ������ �ϼ��Ͻÿ�.
-- �÷��� IN ('A','B'...)  : OR ������ ��ü�Ͽ� ����� �� �ִ� Ű����
SELECT *
FROM employees
WHERE job_id IN('FI_ACCOUNT','IT_PROG');

-- 11.
-- ���̺� EMPLOYEES �� JOB_ID�� ��FI_ACCOUNT�� �̰ų� ��IT_PROG�� �ƴ� ����� ��� �÷��� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
-- <����> IN Ű���带 ����Ͽ� SQL ������ �ϼ��Ͻÿ�.
SELECT *
FROM employees
WHERE job_id NOT IN('FI_ACCOUNT','IT_PROG');

-- 12.
-- ���̺� EMPLOYEES �� JOB_ID�� ��IT_PROG�� �̸鼭 SALARY �� 6000 �̻��� ����� ��� �÷��� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
-- ���� ����
-- AND ���� : ~�̸鼭, �׸���, ���ÿ�
-- WHERE A AND B;
SELECT *
FROM employees
WHERE job_id = 'IT_PROG' AND salary >= 6000;

-- 13.
-- ���̺� EMPLOYEES �� FIRST_NAME �� ��S���� �����ϴ� ����� ��� �÷��� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT *
FROM employees
WHERE first_name LIKE 'S%';

-- 14.
-- ���̺� EMPLOYEES �� FIRST_NAME �� ��s���� ������ ����� ��� �÷��� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT *
FROM employees
WHERE first_name LIKE '%s';

-- 15.
-- ���̺� EMPLOYEES �� FIRST_NAME �� ��s���� ���ԵǴ� ����� ��� �÷��� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT *
FROM employees
WHERE first_name LIKE '%s%';

-- 16.
-- ���̺� EMPLOYEES �� FIRST_NAME �� 5������ ����� ��� �÷��� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT *
FROM employees
WHERE first_name LIKE '_____';

-- LENGTH(�÷���) : ���� ���� ��ȯ�ϴ� �Լ�
SELECT *
FROM employees
WHERE LENGTH(first_name) = 5; 

-- 17.
-- ���̺� EMPLOYEES �� COMMISSION_PCT�� NULL �� ����� ��� �÷��� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
-- IS NULL : NULL������ Ȯ��
SELECT *
FROM employees
WHERE commission_pct IS NULL;

-- 18.
-- ���̺� EMPLOYEES �� COMMISSION_PCT�� NULL�� �ƴ� ����� ��� �÷��� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT *
FROM employees
WHERE commission_pct IS NOT NULL;

-- 19.
-- ���̺� EMPLOYEES �� ����� HIRE_DATE�� 04�� �̻��� ��� �÷��� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT *
FROM employees
WHERE hire_date >= '04/01/01';      -- SQL Developer ���� ������ �����͸� ��¥�� �����ͷ� �ڵ� ��ȯ

-- TO_DATE ������ �����͸� ��¥������ ����
-- TO_DATE('������ ������','���ϴ� ��¥ ����')
SELECT *
FROM employees
WHERE hire_date >= TO_DATE('20040101','YYYYMMDD');

-- 20.
-- ���̺� EMPLOYEES �� ����� HIRE_DATE�� 04�⵵���� 05�⵵�� ��� �÷��� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT *
FROM employees
WHERE hire_date >= TO_DATE('20040101','YYYYMMDD')
  AND hire_date <= TO_DATE('20051231','YYYYMMDD');
  
  SELECT *
FROM employees
WHERE hire_date >= '2004/01/01'
  AND hire_date <= '2005/12/31';
  
-- �÷� BETWEEN A AND B
-- : A ���� ũ�ų� ���� B ���� �۰ų� ���� ���� (����)
SELECT *
FROM employees
WHERE hire_date BETWEEN TO_DATE('20040101','YYYYMMDD')
  AND TO_DATE('20051231','YYYYMMDD');
  
SELECT *
FROM employees
WHERE hire_date BETWEEN '04/01/01' AND '05/12/31';
