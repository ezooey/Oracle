-- 서브쿼리 : 하나의 sql문 안에 또다른 sql문이 포함되는 것
-- 부서코드가 노옹철 사원과 같은 소속의 직원 명단 조회
-- 1) 노옹철 사원의 부서코드
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '노옹철'; -- D9
-- 2) 부서코드가 D9인 직원 명단 조회
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';
-- 1) + 2)
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                   FROM EMPLOYEE
                   WHERE EMP_NAME = '노옹철');
                   
-- 전 직원의 평균 급여보다 많은 급여를 받고 있는 직원의 사번, 이름, 직급코드, 급여
-- 1) 전 직원의 평균 급여
SELECT AVG(SALARY)
FROM EMPLOYEE; -- 3047662.60869565217391304347826086956522
-- 2) 평균 급여보다 많이 받는 직원
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3047662.60869565217391304347826086956522;
-- 1) + 2)
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE);

-- 서브쿼리 유형
-- 단일행 서브쿼리 : 서브쿼리의 결과 값이 1개일 때
-- 다중행 서브쿼리 : 서브쿼리의 결과 값이 여러 개일 때
-- 다중열 서브쿼리 : 서브쿼리의 결과 항목이 여러 개일 때
-- 다중행 다중열 서브쿼리 : 서브쿼리의 결과 항목 및 개수가 여러 개일 때

-- 단일행 서브쿼리 : 일반적으로 단일행 서브쿼리 앞에는 일반 연산자가 들어감
-- <, >, <=, >=, =, !=/<>/^=
-- 노옹철 사원의 급여보다 많이 받는 직원의 사번, 이름, 부서코드, 직급코드, 급여 조회
-- 1) 노옹철 사원의 급여 조회
SELECT SALARY
FROM EMPLOYEE
WHERE EMP_NAME = '노옹철'; -- 3700000
-- 2) 3700000보다 많이 받는 직원 정보
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3700000;
-- 1) + 2)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME = '노옹철');

-- 가장 적은 급여를 받는 직원의 사번, 이름, 직급코드, 부서코드, 급여, 입사일
SELECT EMP_ID, EMP_NAME, JOB_CODE, DEPT_CODE, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY) FROM EMPLOYEE);

-- 전 직원의 급여 평균보다 적은 급여를 받는 직원의 이름, 직급코드, 부서코드, 급여 조회(직급 순으로 정렬)
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY < (SELECT AVG(SALARY) FROM EMPLOYEE)
ORDER BY JOB_CODE;

-- 부서 별 급여 합계 중 가장 큰 부서의 부서명, 급여 합계 조회
-- 1) 부서 별 급여 합계
SELECT DEPT_TITLE, SUM(SALARY)
FROM EMPLOYEE
     LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
GROUP BY DEPT_TITLE;

-- 2) 급여 합계가 가장 큰 부서의 급여 합계
SELECT MAX(SUM(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 1) + 2)
SELECT DEPT_TITLE, SUM(SALARY)
FROM EMPLOYEE
     LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
GROUP BY DEPT_TITLE
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY))
                      FROM EMPLOYEE
                      GROUP BY DEPT_CODE);
                      
-- 다중행 서브쿼리 : 일반 비교연산자 사용X
-- IN/NOT IN : 여러 개의 결과 값 중 한 개라도 일치하는 값이 있다면/없다면
-- > ANY, < ANY : 여러 개의 결과 값 중 한 개라도 큰/작은 경우
--                가장 작은 값보다 크냐 / 가장 큰 값보다 작냐
-- > ALL, < ALL : 모든 값보다 큰/작은 경우
--                가장 큰 값보다 크냐 / 가장 작은 값보다 작냐
-- EXISTS/NOT EXISTS : 값이 존재/존재하지 않는지
-- IN과 EXISTS의 차이 : IN 같은 경우 값을 찾아 반환
--                     EXISTS는 TRUE/FALSE만 반환

-- 부서 별로 최고 급여를 받는 직원의 이름, 직급코드, 부서코드, 급여 조회
-- 1) 부서 별 최고 급여
SELECT MAX(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

SELECT EMP_NAME, JOB_CODE, DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE SALARY IN (SELECT MAX(SALARY)
                 FROM EMPLOYEE 
                 GROUP BY DEPT_CODE);
                 
-- 관리자와 일반 직원에 해당하는 사원 정보 추출 : 사번, 이름, 부서명, 직급, 구분(관리자/직원)
-- 1) 관리자에 해당하는 사원 번호 조회
--SELECT DISTINCT(E.EMP_ID)
--FROM EMPLOYEE
--WHERE EMP_ID IN (SELECT MANAGER_ID FROM EMPLOYEE);

SELECT DISTINCT MANAGER_ID
FROM EMPLOYEE
WHERE MANAGER_ID IS NOT NULL;
-- 선생님 답

-- 2) 직원의 사번, 이름, 부서명, 직급 조회
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
     LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
     JOIN JOB USING(JOB_CODE);
     
-- 3) 관리자에 해당하는 직원에 대한 정보 추출 (1 + 2)
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, '관리자' 구분
FROM EMPLOYEE
     LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
     JOIN JOB USING(JOB_CODE)
WHERE EMP_ID IN (SELECT DISTINCT MANAGER_ID 
                 FROM EMPLOYEE 
                 WHERE MANAGER_ID IS NOT NULL);
-- 4) 일반 사원에 해당하는 직원 정보 추출
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, '직원' 구분
FROM EMPLOYEE
     LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
     JOIN JOB USING(JOB_CODE)
WHERE EMP_ID NOT IN (SELECT DISTINCT MANAGER_ID
                     FROM EMPLOYEE
                     WHERE MANAGER_ID IS NOT NULL);

-- 5) 3) + 4)
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, '관리자' 구분
FROM EMPLOYEE
     LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
     JOIN JOB USING(JOB_CODE)
WHERE EMP_ID IN (SELECT DISTINCT MANAGER_ID 
                 FROM EMPLOYEE 
                 WHERE MANAGER_ID IS NOT NULL)
UNION                 
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, '직원' 구분
FROM EMPLOYEE
     LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
     JOIN JOB USING(JOB_CODE)
WHERE EMP_ID NOT IN (SELECT DISTINCT MANAGER_ID
                     FROM EMPLOYEE
                     WHERE MANAGER_ID IS NOT NULL);
     
-- 더 간단한 방법                
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME,
       CASE WHEN EMP_ID IN (SELECT DISTINCT MANAGER_ID
                            FROM EMPLOYEE
                            WHERE MANAGER_ID IS NOT NULL) THEN '관리자'
            ELSE '직원'
       END 구분
FROM EMPLOYEE
     LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
     JOIN JOB USING(JOB_CODE);