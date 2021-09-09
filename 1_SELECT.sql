-- SELECT : ������ ��ȸ(�˻�)
-- SELECT�� ���� �����͸� ��ȸ�ϸ� ������� Result Set ��ȯ

-- EMPLOYEE ���̺��� ���, �̸�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� ��� ���� ��ȸ
-- SELECT EMP_ID, EMP_NAME, EMP_NO, EMAIL, PHONE, DEPT_CODE, JOB_CODE,
--        SAL_LEVEL, SALARY, BONUMS, MANAGER_ID, HIRE_DATE, ENT_DATE, ENT_YN
-- FROM EMPLOYEE;
SELECT *        -- * : �ƽ�Ʈ��
FROM EMPLOYEE;

-- JOB ���̺��� ��� ���� ��ȸ
-- JOB ���̺��� ���� �̸� ��ȸ
-- DEPARTMENT ���̺��� ��� ���� ��ȸ
-- EMPLOYEE ���̺��� ������, �̸���, ��ȭ��ȣ, ����� ��ȸ
-- EMPLOYEE ���̺��� �����, ��� �̸�, ���� ��ȸ

SELECT *
FROM JOB;

SELECT JOB_NAME
FROM JOB;

SELECT *
FROM DEPARTMENT;

SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE
FROM EMPLOYEE;

SELECT HIRE_DATE, EMP_NAME, SALARY
FROM EMPLOYEE;


-- �÷� �� ����
-- EMPLOYEE ���̺��� ������, ����(����*12) ��ȸ
SELECT EMP_NAME, SALARY*12
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� ������, ����, ���ʽ��� �߰��� ���� ��ȸ
SELECT EMP_NAME, SALARY*12, (SALARY*(1+BONUS))*12 -- (SALARY+(SALARY*BONUS))*12�� �ص� ��
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� �̸�, ����, �Ѽ��ɾ�(���ʽ� ����), �Ǽ��ɾ�(�Ѽ��ɾ�-(����*����3%)) ��ȸ
-- EMPLOYEE ���̺��� �̸�, �����, �ٹ��ϼ�(���ó�¥(SYSDATE)-�����) ��ȸ

SELECT EMP_NAME, SALARY*12, (SALARY*(1+BONUS))*12, (SALARY*(1+BONUS))*12-(SALARY*12*0.03)
FROM EMPLOYEE;

SELECT EMP_NAME, HIRE_DATE, SYSDATE-HIRE_DATE -- �ð����� ���� �Ҽ��� ����� ����
FROM EMPLOYEE;

-- �÷� ��Ī
-- �÷��� AS ��Ī        �÷��� "��Ī"        �÷��� AS "��Ī"         �÷��� ��Ī
-- ��Ī�� "" ����ϴ� ��� : ��Ī�� Ư������ �� ���

SELECT EMP_NAME AS �����, SALARY*12 ����, (SALARY*(1+BONUS))*12 AS "���ʽ� ���� ����" --""���� ����� ������ Ư������ �ν���
FROM EMPLOYEE;

SELECT EMP_NAME "��� ��", SALARY*12 ����, 
       (SALARY*(1+BONUS))*12 AS "�Ѽ��ɾ�(���ʽ�����)", 
       (SALARY*(1+BONUS))*12-(SALARY*12*0.03) AS �Ǽ��ɾ�
FROM EMPLOYEE;

-- ���ͷ�
-- EMPLOYEE ���̺��� ���� ��ȣ, �����, �޿�, ����(��) ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, '��' ����    -- ��ġ ���̺��� ���� ������ ��ó�� ��������
FROM EMPLOYEE;
-- ����Ŭ������ ""�� ��Ī�� ��Ÿ���� ''�� ���ڸ� ������(�������ڿ��� ���X)

-- DISTINCT : �÷��� ���Ե� �ߺ� ���� �� ������ ǥ���ϰ��� �� ��
-- EMPLOYEE ���̺��� ������ ���� �ڵ� ��ȸ
SELECT JOB_CODE
FROM EMPLOYEE;

SELECT DISTINCT JOB_CODE FROM EMPLOYEE;

-- EMPLOYEE ���̺��� �μ��ڵ�� �����ڵ� ��ȸ
SELECT DEPT_CODE, JOB_CODE
FROM EMPLOYEE;

-- SELECT DISTINCT DEPT_CODE, DISTINCT JOB_CODE
-- FROM EMPLOYEE;
-- DISTINCT�� SELECT���� �� �� ���� �� �� ����
SELECT DISTINCT DEPT_CODE, JOB_CODE
FROM EMPLOYEE;

-- WHERE�� : ��ȸ�� ������ ����ϴ� �κ�
-- �� ������
-- = ����, > ũ��, < �۳�, >= ũ�ų� ����, <= �۰ų� ����
-- !=, ^= <> ���� �ʳ�

-- EMPLOYEE ���̺��� �μ��ڵ尡 D9�� ������ �̸�, �μ��ڵ� ��ȸ
SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- EMPLOYEE ���̺��� �޿��� 4000000 �̻��� ������ �̸�, �޿� ��ȸ
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY >= 4000000;

-- EMPLOYEE ���̺��� �μ��ڵ尡 D9�� �ƴ� ����� ���, �̸�, �μ��ڵ� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
-- WHERE DEPT_CODE != 'D9';
-- WHERE DEPT_CODE ^= 'D9';
WHERE DEPT_CODE <> 'D9';

-- EMPLOYEE ���̺��� ��� ���ΰ� N�� ������ ��ȸ�ϰ� �ٹ� ���θ� ���������� ǥ���Ͽ�
-- ���, �̸�, �����, �ٹ� ���� ��ȸ
SELECT EMP_ID, EMP_NAME, HIRE_DATE, '������' "�ٹ� ����"
FROM EMPLOYEE
WHERE ENT_YN = 'N';

-- EMPLOYEE ���̺��� ������ 3000000 �̻��� ����� �̸�, ����, ����� ��ȸ
-- EMPLOYEE ���̺��� SAL_LEVEL�� S1�� ����� �̸�, ����, �����, ����ó ��ȸ
-- EMPLOYEE ���̺��� �Ǽ��ɾ�(�Ѽ��ɾ�-(����*����3%))DL 5õ���� �̻��� ����� �̸�, ����, �Ǽ��ɾ�, ����� ��ȸ
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY >= 3000000;

SELECT EMP_NAME, SALARY, HIRE_DATE, PHONE
FROM EMPLOYEE
WHERE SAL_LEVEL = 'S1';

SELECT EMP_NAME, SALARY, (SALARY*(1+BONUS))*12 - (SALARY*12*0.03) AS �Ǽ��ɾ�, HIRE_DATE
FROM EMPLOYEE
WHERE (SALARY*(1+BONUS))*12- (SALARY*12*0.03) >= 50000000;

-- �� ������ : AND / OR
-- AND : ~��, ���ÿ�, �̸鼭 (&&)
-- OR : �Ǵ�, �̰ų� (||)
-- EMPLOYEE ���̺��� �μ��ڵ尡 D6�̰� �޿��� 3�鸸���� ���� �޴� ������ �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE ='D6' AND SALARY >= 3000000;

-- EMPLOYEE ���̺��� �μ��ڵ尡 D6�̰ų� �޿��� 3�鸸���� ���� �޴� ������ �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' OR SALARY > 3000000;

-- EMPLOYEE ���̺��� �޿��� 350�� �̻� 600�� ���ϸ� �޴� ������ ���, �̸�, �޿�, �μ��ڵ�, �����ڵ� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE SALARY >= 3500000 AND SALARY <= 6000000;

-- EMPLOYEE ���̺� ������ 4000000 �̻��̰� JOB_CODE�� J2�� ����� ��ü ���� ��ȸ
-- EMPLOYEE ���̺� DEPT_CODE�� D9�̰ų� D5�� ��� �� ������� 02�� 1�� 1�Ϻ��� ���� ����� �̸�, �μ��ڵ�, ����� ��ȸ

SELECT *
FROM EMPLOYEE
WHERE SALARY >= 4000000 AND JOB_CODE = 'J2';

SELECT EMP_NAME, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE = 'D9' OR DEPT_CODE = 'D5') AND HIRE_DATE < '02/1/1'; -- ��ȣ�� ���� ������ AND ���� ����ǰ� OR�� ����

-- BETWEEN AND : ���Ѱ� �̻� ���Ѱ� ����
-- �÷��� BETWEEN ���Ѱ� AND ���Ѱ�
-- EMPLOYEE ���̺��� �޿��� 350�� �̻� 600�� ���ϸ� �޴� ������ ���, �̸�, �޿�, �μ��ڵ�, �����ڵ� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE SALARY >= 3500000 AND SALARY <= 6000000;
-- �Ʒ�ó�� ���ָ� ����� �Ȱ��� ���´�
SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 6000000;

-- 350�� �̸� �Ǵ� 600�� �ʰ��ϴ� ������ ���, �̸�, �޿�, �μ��ڵ�, �����ڵ� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
--WHERE NOT SALARY BETWEEN 3500000 AND 6000000;
WHERE SALARY NOT BETWEEN 3500000 AND 6000000;

-- EMPLOYEE ���̺��� ������� 90/1/1 ~ 01/1/1�� ����� ��ü ���� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/01/01';

-- LIKE : Ư�� ������ ������Ű���� ��ȸ
-- % _
-- % : 0���� �̻�
-- _ : 1����
-- '����%' : ���ڷ� �����ϴ� �� EX. ����, ���ڹ���... ETC
-- '%����%' : ���ڰ� ���Ե� �� EX. ����, ���ڹ���, ������... ETC
-- '%����' : ���ڷ� ������ �� EX. �ױ���, ����
-- '��%��' : �۷� �����ؼ� �ڷ� ������ �� EX. ���ǳ���, ����
-- '_' : �� ����
-- '__' : �� ����
-- '___' : �� ����

-- EMPLOYEE ���̺��� ���� ������ ����� ���, �̸�, ����� ��ȸ
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '��%';

-- EMPLOYEE ���̺��� �̸��� '��'�� ���Ե� ������ �̸�, �ֹι�ȣ, �μ��ڵ� ��ȸ
-- EMPLOYEE ���̺��� ��ȭ��ȣ 4��° �ڸ��� 9�� �����ϴ� ����� ���, �̸�, ��ȭ��ȣ ��ȸ
-- EMPLOYEE ���̺��� �达 ���� �ƴ� ����� ���, �̸�, ����� ��ȸ

SELECT EMP_NAME, EMP_NO, DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��%';

SELECT EMP_ID, EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE LIKE '___9%';

SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME NOT LIKE '��%';
-- WHERE NOT EMP_NAME LIKE '��%';

-- EMPLOYEE ���̺��� �̸��� �� _�� �� ���ڰ� 3�ڸ��� �̸��� �ּҸ� ���� ����� ���, �̸�, �̸��� �ּ� ��ȸ
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___%';    -- �� ���� 3�ڸ��� ���ϴ� �����_�� ���ϵ�ī��
-- ���ϵ�ī�� ���ڿ� ������ Ư�� ���ڰ� ������ ��� � ���� ���ϵ�ī��� � ���� Ư���������� ����X
-- Ư������ ��ü�� �����ͷ� ó���ϱ� ���� ������ �� �ִ� ��ġ �ʿ� = ESCAPE OPTION
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___!_%' ESCAPE '!';

-- EMPLOYEE ���̺��� �̸� ���� '��'���� ������ ��� �̸� ��ȸ
-- EMPLOYEE ���̺��� ��ȭ��ȣ ó�� 3�ڸ��� 010�� �ƴ� ����� �̸�, ��ȭ��ȣ ��ȸ
-- EMPLOYEE ���̺��� �����ּ� _���� 4�����̸鼭 DEPT_CODE�� D9 �Ǵ� D6�̰�
-- ������� 90/01/01~00/12/01�̰�, �޿��� 270�� �̻��� ��� ��ü ��ȸ

SELECT EMP_NAME
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��';

SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';

SELECT *
FROM EMPLOYEE
WHERE EMAIL LIKE '____!_%' ESCAPE '!' AND (DEPT_CODE = 'D9' OR DEPT_CODE = 'D6') AND 
        (HIRE_DATE BETWEEN '90/01/01' AND '00/12/01') AND SALARY >= 2700000;
        
-- IS NULL/ IS NOT NULL : �÷����� NULL���� �� �ִ��� ���� �Ǻ�
-- EMPLOYEE ���̺��� ���ʽ��� ���� �ʴ� ����� ���, �̸�, �޿�, ���ʽ� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NULL;

-- EMPLOYEE ���̺��� ���ʽ��� �޴� ����� ���, �̸� �޿�, ���ʽ� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;
--WHERE NOT BONUS IS NULL;

-- EMPLOYEE ���̺��� �����ڵ� ���� �μ� ��ġ�� ���� ���� ������ �̸�, ������, �μ��ڵ� ��ȸ
-- EMPLOYEE ���̺��� �μ� ��ġ�� ���� �ʾ����� ���ʽ��� ���޹޴� ������ �̸�, ���ʽ�, �μ��ڵ� ��ȸ

SELECT EMP_NAME, MANAGER_ID, DEPT_CODE
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;

SELECT EMP_NAME, BONUS, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;

-- IN : ��Ͽ� ��ġ�ϴ� ���� ������ TRUE ��ȯ
-- D6 �μ��� D9 �μ������� �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
-- WHERE DEPT_CODE = 'D6' OR DEPT_CODE = 'D9'; -- AND�� �ϸ� D6�̸鼭 D9�� ������ �����ؾ� �ϱ� ������ ����� ����
WHERE DEPT_CODE IN ('D6', 'D9');

-- �����ڵ尡 J1, J2, J3, J4�� ������� �̸�, �����ڵ�, �޿� ��ȸ
SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
-- WHERE JOB_CODE = 'J1' OR JOB_CODE = 'J2' OR JOB_CODE = 'J3' OR JOB_CODE = 'J4';
WHERE JOB_CODE IN ('J1', 'J2', 'J3', 'J4');

-- ���� ������ ||
-- EMPLOYEE ���̺��� ���, �̸�, �޿��� �����Ͽ� ��ȸ
SELECT EMP_ID || EMP_NAME || SALARY
FROM EMPLOYEE;

SELECT EMP_ID, EMP_NAME, SALARY || '��'
FROM EMPLOYEE;

-- ORDER BY : ������ �� �ۼ��ϴ� ����
-- SELECT���� ���� �������� �ۼ�, ���� ������ ���� ������
-- �÷���/��Ī/�÷����� ���Ĺ�� NULLS FIRST/NULLS LAST
-- �������� : ASC(�⺻, ��������) / �������� : DESC(��� �ʿ�)
SELECT EMP_ID ���, EMP_NAME �̸�, SALARY �޿�, BONUS ���ʽ�
FROM EMPLOYEE
-- ORDER BY EMP_ID;
-- ORDER BY EMP_ID DESC;
-- ORDER BY EMP_ID ASC;
-- ORDER BY EMP_NAME ASC;
-- ORDER BY EMP_NAME;
-- ORDER BY EMP_NAME DESC;
-- ORDER BY �̸� DESC;
-- ORDER BY 3 DESC;    -- SELECT������ 3��° ������ ����
ORDER BY BONUS DESC NULLS LAST;     -- NULL�� �ڷ� ����
