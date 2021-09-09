-- �Լ� : �÷��� ���� �о ����� ��� ����
-- ������ �Լ� : �÷��� ��ϵ� n���� ���� �о� n���� ��� ����
-- �׷� �Լ� : �÷��� ��ϵ� n���� ���� �о� 1���� ��� ���� 
-- �������Լ� �׷��Լ��� �Բ� ����� �� �ִ�(X)/����(O) => ��� ���� ������ �ٸ��� ����

-- ������ �Լ�
-- 1. ���ڰ��� �Լ�
-- LENGTH/LENGTHB
SELECT LENGTH('����Ŭ'), LENGTHB('����Ŭ')    -- �ѱ� 1���ڴ� 3byte�� �ν�
FROM DUAL; -- ���� ���̺�

SELECT LENGTH(EMAIL), LENGTHB(EMAIL)        -- ���� 1���ڴ� 1byte�� �ν�
FROM EMPLOYEE;

-- INSTR : �ش� ���ڿ��� ���� ���� ��ġ(����Ŭ������ 1���� ��)
SELECT INSTR('AABAACAABBAA', 'B') FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'Z') FROM DUAL;
-- �ڹٿ��� ���� ������ ��ġ�� -1�� ��ȯ, ����Ŭ������ 1���� ���ϱ� ���� ���ڴ� 0�� ��ȯ�ϰ� ��
SELECT INSTR('AABAACAABBAA', 'B', 1) FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', 7) FROM DUAL;     
-- ����° ������ �˻��� �����ϴ� ��ġ, 7��°���� �����ؼ� B�� ��ġ�� ã���� 9��°�� ��
SELECT INSTR('AABAACAABBAA', 'B', -1) FROM DUAL;
-- ����° �������� -1�� ������ �ڿ������� �˻�
SELECT INSTR('AABAACAABBAA', 'B', 1, 2) FROM DUAL;
-- 1���� �˻� ���������� �ι�° B�� ã�ƶ�

-- EMPLOYEE ���̺��� �̸����� @ ��ġ ��ȯ
SELECT INSTR(EMAIL, '@')
FROM EMPLOYEE;

-- LPAD/RPAD
-- ������ ���ڸ�ŭ�� ������ �������� ���� ������ ������ ���ڷ� ����/�����ʿ� ä������
SELECT LPAD(EMAIL, 20) FROM EMPLOYEE;
SELECT LPAD(EMAIL, 20, '#') FROM EMPLOYEE;
-- ���̸� 20���� ������� ������ ����, ������ ������ #���� ä���
SELECT RPAD(EMAIL, 20, '#') FROM EMPLOYEE;
-- ���̸� 20���� ������� ���� ����, �������� ������ #���� ä���

-- LTRIM/RTRIM/TRIM
SELECT LTRIM('   KH') FROM DUAL;                --KH
SELECT LTRIM('KH   ') A FROM DUAL;              --KH   )
SELECT LTRIM('   KH', ' ') FROM DUAL;           --KH
SELECT LTRIM('00012345', '0') FROM DUAL;        --12345
SELECT LTRIM('123123KH', '123') FROM DUAL;      --KH
SELECT LTRIM('123123KH123', '123') FROM DUAL;   --KH123
SELECT LTRIM('ACBBAKH', 'ABC') FROM DUAL;
-- A �Ǵ� B �Ǵ� C�� ����� ��! ABC���� ����� �� �ƴ�
SELECT PHONE, LTRIM(PHONE, '010') FROM EMPLOYEE;
-- 010���� ����� �� �ƴϱ� ������ 011�� ������ 017�� 01������ ������

SELECT RTRIM('KH   ') A FROM DUAL;      -- KH
SELECT RTRIM('123123KH123', '123') FROM DUAL;       -- 123123KH
SELECT EMAIL, RTRIM(EMAIL, '@kh.or.kr') FROM EMPLOYEE; --@���� h�� j� ��������

SELECT TRIM('   KH   ') A FROM DUAL;
SELECT TRIM('Z' FROM 'ZZZKHZZZ') FROM DUAL;     -- ������ Z�� ����
SELECT TRIM('123' FROM '123123KH12') FROM DUAL; -- �׳� Ʈ���� ���� �ϳ��� �����ؼ� �̰� ����
SELECT TRIM(LEADING 'Z' FROM 'ZZZKHZZZ') FROM DUAL;     -- �տ������� / KHZZZ
SELECT TRIM(TRAILING 'Z' FROM 'ZZZKHZZZ') FROM DUAL;    -- �ڿ������� / ZZZKH
SELECT TRIM(BOTH 'Z' FROM 'ZZZKHZZZ') FROM DUAL;        -- ���ʿ���   / KH

-- SUBSTR = �ڹ��� String.subString() / ���ڿ� �Ϻ� ��ȯ
SELECT SUBSTR('SHOWMETHEMONEY', 7) FROM DUAL;       -- 7��°���� ������ ��ȯ
SELECT SUBSTR('SHOWMETHEMONEY', 5, 2) FROM DUAL;    -- 5��°���� 2���� ��ȯ
SELECT SUBSTR('SHOWMETHEMONEY', 5, 0) FROM DUAL;    -- NULL
SELECT SUBSTR('SHOWMETHEMONEY', -8, 3) FROM DUAL;   -- �Ųٷ� 8��°�� T���� ���������� 3���� / THE


-- EMPLOYEE ���̺��� �̸�, �̸���, @ ���ĸ� ������ ���̵� ��ȸ
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@') -1) ���̵�
FROM EMPLOYEE;
 -- �̸����� 1���� �̸����� @�� ���� �ڸ� �ٷ� ������ �Ϻ� ��ȯ

-- �ֹε�Ϲ�ȣ�� �̿��Ͽ� ��/�� �Ǵ��Ͽ� �̸�, ���� ��ȸ
SELECT EMP_NAME, SUBSTR(EMP_NO, 8, 1) ����
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� ���ڸ� ��ȸ(�����, '��')
SELECT EMP_NAME, '��' ����
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = 1;

-- EMPLOYEE ���̺��� ���ڸ� ��ȸ(�����, '��')
SELECT EMP_NAME, '��' ����
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = 2;

-- EMPLOYEE ���̺��� �������� �ֹι�ȣ�� �̿��Ͽ� �����, ����, ����, ���� ��ȸ
SELECT EMP_NAME, SUBSTR(EMP_NO, 1, 2) || '��' ����, 
        SUBSTR(EMP_NO, 3, 2) ||'��' ����, 
        SUBSTR(EMP_NO, 5, 2) ||'��' ����
FROM EMPLOYEE;

-- LOWER/UPPER/INITCAP
SELECT LOWER('Welcom To My World') LOWER,   -- ��� �ҹ��ڷ�
        UPPER('Welcom To My World') UPPER,  -- ��� �빮�ڷ�
        INITCAP('Welcom To My World') INITCAP FROM DUAL;
SELECT INITCAP('WELCOME TO MY WORLD') FROM DUAL;    -- �ܾ��� �� �ձ��ڸ� �빮�ڷ� ��ȯ

-- CONCAT : ���ڿ� ��ġ��
SELECT CONCAT('�����ٶ�', '���ٻ�') FROM DUAL;
SELECT '�����ٶ�' || '���ٻ�' FROM DUAL;

-- REPLACE
SELECT REPLACE('����� ������ ���ﵿ', '���ﵿ', '�Ｚ��') FROM DUAL;
SELECT REPLACE('�ڽſ찭����� G�����忡 �ֽ��ϴ�', '�����', '������') FROM DUAL;

-- EMPLOYEE ���̺��� �����, �ֹι�ȣ ��ȸ
-- �ֹι�ȣ�� ������ϸ� ���̰� �ϰ� '-' ������ '*'�� ����
SELECT EMP_NAME �����, SUBSTR(EMP_NO, 1, INSTR(EMP_NO, '-')) || '*******' �ֹι�ȣ
FROM EMPLOYEE;

SELECT EMP_NAME �����, REPLACE(EMP_NO, SUBSTR(EMP_NO, INSTR(EMP_NO, '-')+1), '*******') �ֹι�ȣ
FROM EMPLOYEE;

SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO, 1, INSTR(EMP_NO, '-')), LENGTH(EMP_NO), '*') �ֹι�ȣ
FROM EMPLOYEE;

-- 2. ���ڰ��� �Լ�
-- ABS : ���밪
SELECT ABS(10.9) FROM DUAL; -- 10.9
SELECT ABS(-10.9) FROM DUAL; -- 10.9
SELECT ABS(-10) FROM DUAL; -- 10

-- MOD : ��ⷯ
SELECT MOD(10, 3) FROM DUAL; -- 1
SELECT MOD(-10, 3) FROM DUAL; -- -1
SELECT MOD(10, -3) FROM DUAL; -- 1  ==> ���������� ���� 10�� ��ȣ�� ����

-- ROUND : �ݿø�
SELECT ROUND(123.456) FROM DUAL; -- 123
SELECT ROUND(123.678) FROM DUAL; -- 124
SELECT ROUND(123.456, 0) FROM DUAL; -- 123 / �Ҽ��� ù°�ڸ����� �ݿø�
SELECT ROUND(123.456, 1) FROM DUAL; -- 123.5 / �Ҽ��� ��°�ڸ����� �ݿø�
SELECT ROUND(123.456, 2) FROM DUAL; -- 123.46 // �Ҽ��� ��°�ڸ����� �ݿø�
SELECT ROUND(123.456, -1) FROM DUAL; -- �Ҽ��� ���� 1�� �ڸ����� �ݿø�

-- FLOOR : ���� (������ �ǹ�)
SELECT FLOOR(123.456) FROM DUAL; -- 123 
SELECT FLOOR(123.678) FROM DUAL; -- 123

-- TRUNC : �Ҽ��� �ڸ� ���� (������ �ǹ�X)
SELECT TRUNC(123.456) FROM DUAL; -- 123 
SELECT TRUNC(123.678) FROM DUAL; -- 123

-- CEIL : �ø�
SELECT CEIL(123.456) FROM DUAL; -- 124
SELECT CEIL(123.678) FROM DUAL; -- 124

-- 3. ��¥���� �Լ�
-- SYSDATE
SELECT SYSDATE FROM DUAL;

-- MONTHS_BETWEEN : ���� ���� ���̸� ���ڷ� ����
-- EMPLOYEE ���̺��� ����� �̸�, �Ի���, �ٹ� ���� �� ��ȸ
SELECT EMP_NAME, HIRE_DATE, MONTHS_BETWEEN(SYSDATE, HIRE_DATE)
FROM EMPLOYEE;

SELECT EMP_NAME, HIRE_DATE, ABS(MONTHS_BETWEEN(HIRE_DATE, SYSDATE))
FROM EMPLOYEE;
-- �Ǽ��� ���� ������ ���밪�� �־��ش�.

SELECT EMP_NAME, HIRE_DATE, CEIL(ABS(MONTHS_BETWEEN(HIRE_DATE, SYSDATE))) || '������' ������
FROM EMPLOYEE;
-- 5��������� �ϸ� 5������ �� ä�� ���� �ƴ϶� ���ڸ� �� ���̱� ������ �������� ��Ÿ�� �� �ø��� ����.

-- ADD_MONTHS : ��¥�� ���ڸ�ŭ �������� ���Ͽ� ��¥ ���� (���� ��¥ 21/09/09)
SELECT ADD_MONTHS(SYSDATE, 2) FROM DUAL;
SELECT ADD_MONTHS(SYSDATE, 4) FROM DUAL; -- 22/01/09 ���������� �ٲ�

-- NEXT_DAY : ���� ��¥���� ���Ϸ��� ���Ͽ� ���� ����� ��¥ ����
-- 1=�� / 2=�� / 3=ȭ / 4=�� / 5=�� / 6=�� / 7=��
SELECT SYSDATE, NEXT_DAY(SYSDATE, '�ݿ���') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 6) FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, '��') FROM DUAL;
-- �ݿ��Ͽ� ���� ����� ��¥�� 21/09/10 ��ȯ, �����̾ ���X
SELECT SYSDATE, NEXT_DAY(SYSDATE, '������ �����ݾ�, ��ġ?') FROM DUAL;   -- �� �տ� ���� ���� 13�� �������� ����
SELECT SYSDATE, NEXT_DAY(SYSDATE, '��ڿ� ���� �ڼ��� �����ּ���') FROM DUAL; -- �߰��� ���� ��������� ����� ������ ����
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'FRIDAY') FROM DUAL;
ALTER SESSION SET NLS_LANGUAGE = AMERICAN; -- ����� �ٲ��ָ� FRIDAY�� �������� ���� �ѱ� ����� �� ����
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'FRI') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'FRIDKJLA;FD;') FROM DUAL; -- �� ���� FRI�ϱ� �ν���
ALTER SESSION SET NLS_LANGUAGE = KOREAN; -- �ٽ� �ѱ۷� �ٲ��ִ� �۾� �ʿ�

-- LAST_DAY : �ش� ���� ������ ��¥�� ���Ͽ� ����
SELECT SYSDATE, LAST_DAY(SYSDATE) FROM DUAL;

-- EMPLOYEE ���̺��� �����, �Ի���-����, ����-�Ի��� ��ȸ
--      �� ��Ī�� �ٹ��ϼ�1, �ٹ��ϼ�2�� �ϰ� ��� ����ó��(����)
SELECT EMP_NAME, FLOOR(HIRE_DATE - SYSDATE) �ٹ��ϼ�1, FLOOR(SYSDATE - HIRE_DATE) �ٹ��ϼ�2
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� ����� Ȧ���� �������� ���� ��� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE MOD(EMP_ID, 2) = 1;

-- EMPLOYEE ���̺��� �ٹ������� 20�� �̻��� ���� ���� ��ȸ
SELECT *
FROM EMPLOYEE
--WHERE ABS(MONTHS_BETWEEN(HIRE_DATE, SYSDATE)) >= 240;
--WHERE (SYSDATE-HIRE_DATE)/365 >= 20;
WHERE ADD_MONTHS(HIRE_DATE, 240) <= SYSDATE;
-- ����Ͽ� 20�� ���ߴµ� ���� ��¥���� ũ�� 20���� �� �ƴٴ� ��

-- EXTRACT : ��, ��, �� ������ �����Ͽ� ����
-- EMPLOYEE ���̺��� ����� �̸�, �Ի�⵵, �Ի� ��, �Ի���
SELECT EMP_NAME �̸�, 
        EXTRACT(YEAR FROM HIRE_DATE) �Ի�⵵,
        EXTRACT(MONTH FROM HIRE_DATE) "�Ի� ��",
        EXTRACT(DAY FROM HIRE_DATE) �Ի���
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� ����� �̸�, �Ի���, �ٹ����� ��ȸ
--      �� �ٹ������� ���翬�� - �Ի翬���� ��ȸ
SELECT EMP_NAME �̸�, HIRE_DATE �Ի���,
        (EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)) �ٹ�����
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� �����, �Ի���, �Ի��� ���� �ٹ� �ϼ� ��ȸ
SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE) - HIRE_DATE
FROM EMPLOYEE;

-- 4. ����ȯ �Լ�
-- TO_CHAR : ��¥/������ �����͸� ������ �����ͷ� ����
SELECT TO_CHAR(1234), 1234 AAAAAAA FROM DUAL; -- 1234 / �Ȱ��� ��ó�� �������� ���� 1234�� �ٲ����
-- ���ڴ� ���� ����, ���ڴ� ������ ���� 5���� 2�� 10����
SELECT TO_CHAR(1234, '99999') A FROM DUAL;  --  1234 : 5ĭ ������ ����, ��ĭ ����
SELECT TO_CHAR(1234, '00000') A FROM DUAL;  -- 01234 : 5ĭ ������ ����, ��ĭ 0
SELECT TO_CHAR(1234, 'L99999') FROM DUAL;   --  \1234
SELECT TO_CHAR(1234, 'FML99999') FROM DUAL; -- 1234
-- FM : ���� ���� / L : �� ���� ȭ�����
SELECT TO_CHAR(1234, '$99999') FROM DUAL;   --  $1234
SELECT TO_CHAR(1234, 'FM$99999') FROM DUAL; -- $1234
SELECT TO_CHAR(1234, '99,999') FROM DUAL;   --  1,234
SELECT TO_CHAR(1234, 'FM99,999') FROM DUAL; -- 1,234
SELECT TO_CHAR(1234, '999') FROM DUAL;      -- ####

-- EMPLOYEE ���̺��� �����, �޿� ǥ��
-- �޿� '\9,000,000' �������� ǥ��
SELECT EMP_NAME, TO_CHAR(SALARY, 'FML999,999,999') FROM EMPLOYEE;

SELECT TO_CHAR(SYSDATE, 'PM HH:MI:SS') FROM DUAL; -- ���� 02:31:11
SELECT TO_CHAR(SYSDATE, 'AM HH:MI:SS') FROM DUAL; -- ���� 02:31:11 / ���� �ð��� ���Ķ� AM���� �ٲ㵵 ���ķ� ����
SELECT TO_CHAR(SYSDATE, 'AM HH24:MI:SS') FROM DUAL; -- ���� 14:32:21
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY') FROM DUAL; -- 2021-09-09 �����
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-FMDD DAY') FROM DUAL; -- 2021-09-9 �����
SELECT TO_CHAR(SYSDATE, 'YYYY"��" MM"��" DD"��" DAY') FROM DUAL; -- 2021�� 09�� 09�� �����

SELECT TO_CHAR(SYSDATE, 'YYYY'), -- 2021
        TO_CHAR(SYSDATE, 'YY'),  -- 21
        TO_CHAR(SYSDATE, 'YEAR') -- TWENTY TWENTY-ONE
FROM DUAL;
-- 2021	21	TWENTY TWENTY-ONE

SELECT TO_CHAR(SYSDATE, 'MM'),      --09
        TO_CHAR(SYSDATE, 'MONTH'),  --9��
        TO_CHAR(SYSDATE, 'MON'),    --9��
        TO_CHAR(SYSDATE, 'RM')      --IX
FROM DUAL;
-- 09	9�� 	9�� 	IX  

SELECT TO_CHAR(SYSDATE, 'DDD') "1�� ����", --252
       TO_CHAR(SYSDATE, 'DD') "�� ����",   --09
       TO_CHAR(SYSDATE, 'D') "�� ����"     --5
FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'Q') �б�,   -- 3�б�
       TO_CHAR(SYSDATE, 'DAY'),     -- �����
       TO_CHAR(SYSDATE, 'DY')       -- ��
FROM DUAL;

-- EMPLOYEE ���̺��� �̸�, �Ի��� ��ȸ
--    �Ի��� : 0000�� 00�� 00�� (0)

SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'YYYY"��" MM"��" DD"�� ("DY")"')
FROM EMPLOYEE;
-- EX) ������ 	1990�� 02�� 06�� (ȭ) . . .

-- TO_DATE : ����/������ �����͸� ��¥�� �����ͷ� ����
SELECT TO_DATE('20200202', 'YYYYMMDD') FROM DUAL; -- 20/02/02 / ���ڸ� ��¥��
SELECT TO_DATE(20200202, 'YYYYMMDD') FROM DUAL; -- 20/02/02 / ���ڸ� ��¥��

SELECT TO_CHAR(TO_DATE('20200202 153824', 'YYYYMMDD HH24MISS'), 'YYYY-MM-DD HH:MI:SS') FROM DUAL;
--���ڸ� ��¥�� �ٲ�ٰ� �ٽ� ���ڷ� �ٲٴµ� ���� ���ϴ� ������ �̿��ؼ� ��ȯ

-- TO_DATE���� �� �ڸ� ������ YY�� �����Ű�� ������ ���� ����(21����, 2000���)�� ����
--                         RR�� �����Ű�� �� �ڸ� �������� 50�̻��� ���� ���� ����(20����, 1900���),
--                                                     50�̸��� ���� ���� ����(21����, 2000���) ����
-- ���ڸ� ��¥�� �ٲ� ���� RR�� ����ϴ� ���� ����
SELECT TO_CHAR(TO_DATE('990311', 'YYMMDD'), 'YYYYMMDD') "99YY", -- 20990311 
       TO_CHAR(TO_DATE('070108', 'YYMMDD'), 'YYYYMMDD') "07YY", -- 20070108
       TO_CHAR(TO_DATE('990311', 'RRMMDD'), 'YYYYMMDD') "99RR", -- 19990311
       TO_CHAR(TO_DATE('070108', 'RRMMDD'), 'YYYYMMDD') "07RR"  -- 20070108
FROM DUAL;

-- TO_NUMBER : ������ �����͸� ������ �����ͷ� ����
SELECT TO_NUMBER('12345') FROM DUAL;
SELECT 1111 + 2222 FROM DUAL; -- 3333
SELECT '1111' + '2222' FROM DUAL; -- 3333 / ���ڿ��� �ڵ����� ���ڷ� ��ȯ�ؼ� ������
SELECT '1,111' + '2,222' FROM DUAL; -- ,�� ���ڷ� �ٲ� �� ���� ������ ���� ��
SELECT TO_NUMBER('1,111', '999,999') + TO_NUMBER('2,222', '9,999') -- 3333 / ���ڷ� �ٲٱ⸸ �ϸ� ���� ����
FROM DUAL;

-- 5. NULLó�� �Լ�
-- NVL
SELECT EMP_NAME, BONUS, NVL(BONUS, 0)   -- ���ʽ��� NULL�̸� 0���� ��� / EX) ������ (null)	0
FROM EMPLOYEE;

SELECT EMP_NAME, BONUS, NVL(BONUS, 0), DEPT_CODE, NVL(DEPT_CODE, '�μ�X')
FROM EMPLOYEE;
-- �ϵ��� 	0.1	 0.1 (null)	�μ�X / �μ��� null�̸� �μ�X���� ���

-- NVL2
SELECT EMP_NAME, BONUS, NVL2(BONUS, 0.7, 0.5) 
FROM EMPLOYEE;
-- ������	 0.3	0.7
-- ������	(null)	0.5
-- BONUS ���� ������ ù ��°�� 0.7, ������(null) �� ��°�� 0.5

-- NULLIF
SELECT NULLIF(123, 123), NULLIF(123, 132) FROM DUAL; -- (null)	123
-- �� ���� ������ null, ���� ������ 123

-- 6. �����Լ�
-- DECODE : DECODE(����|�÷���, ���ǰ�1, ���ð�1, ���ǰ�2, ���ð�2, ...) 
-- ���ϰ��� �ϴ� ��/�÷��� ���ǽİ� ������ ���ð� ��ȯ
SELECT EMP_ID, EMP_NAME, EMP_NO,
       DECODE(SUBSTR(EMP_NO, 8, 1), 1, '��', 2, '��') ����
FROM EMPLOYEE;

SELECT EMP_ID, EMP_NAME, EMP_NO,
       DECODE(SUBSTR(EMP_NO, 8, 1), 1, '��', '��') ����
FROM EMPLOYEE;
-- ����� �� �����ۿ� ������ �̷��� ���ָ� 1�� ��, �������� ��� ���� ��ȯ��

-- �����ڵ尡 J7�̸� ������ �޿��� 10% �λ�
-- �����ڵ尡 J6�̸� ������ �޿��� 15% �λ�
-- �����ڵ尡 J5�̸� ������ �޿��� 20% �λ�
-- �� �� ������ �޿��� 5% �λ�
-- ������, ���� �ڵ�, �޿�, �λ� �޿� ��ȸ

SELECT EMP_NAME ������ , JOB_CODE "���� �ڵ�", SALARY �޿�, 
       DECODE(JOB_CODE, 'J7', SALARY*1.1, 
                        'J6', SALARY*1.15, 
                        'J5', SALARY*1.2, 
                        SALARY*1.05) "�λ� �޿�"
FROM EMPLOYEE;

SELECT EMP_NAME ������ , JOB_CODE "���� �ڵ�", SALARY �޿�, 
       SALARY * (1 + DECODE(JOB_CODE, 'J7', 0.1, 
                                      'J6', 0.15, 
                                      'J5', 0.2, 
                                      0.05)) "�λ� �޿�"
FROM EMPLOYEE;

-- CASE WHEN

-- �׷��Լ�