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
     
-- 대리 직급의 직원 중 과장 직급의 최소 급여보다 많이 받는 직원의 사번, 이름, 직급, 급여 조회
-- 1) 대리 직급 직원 조회
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
     JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '대리';

-- 2) 과장 직급 직원 급여
SELECT SALARY
FROM EMPLOYEE
     JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '과장';

-- 1) + 2)
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
     JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '대리'
      AND SALARY > ANY(SELECT SALARY
                       FROM EMPLOYEE
                            JOIN JOB USING(JOB_CODE)
                       WHERE JOB_NAME = '과장');
                       
-- 다른 방법
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
     JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '대리'
      AND SALARY > (SELECT MIN(SALARY)  -- 이렇게 해도 됨
                    FROM EMPLOYEE
                         JOIN JOB USING(JOB_CODE)
                    WHERE JOB_NAME = '과장');

-- 차장 직급 급여의 가장 큰 값보다 많이 받는 과장 직급의 사번, 이름, 직급, 급여 조회
-- 1) 과장 직급의 사번, 이름, 직급 급여
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
     JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '과장';

-- 2) 차장 직급의 급여
SELECT SALARY
FROM EMPLOYEE
     JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '차장';

-- 1) + 2)
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
     JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '과장'
      AND SALARY > ALL(SELECT SALARY
                       FROM EMPLOYEE 
                            JOIN JOB USING(JOB_CODE)
                       WHERE JOB_NAME = '차장');
                       
-- 다른 방법
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
     JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '과장'
      AND SALARY > (SELECT MAX(SALARY)
                    FROM EMPLOYEE 
                         JOIN JOB USING(JOB_CODE)
                    WHERE JOB_NAME = '차장');
                    
-- 다중열 서브쿼리
-- 퇴사한 여직원과 같은 부서, 같은 직급에 해당하는 사원의 이름, 직급코드, 부서코드, 입사일 조회
-- 1) 퇴사한 여직원의 부서, 직급 조회
SELECT JOB_CODE, DEPT_CODE
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = 2
      AND ENT_YN = 'Y';
      
-- 2) 퇴사 직원과 같은 부서, 같은 직급
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                   FROM EMPLOYEE
                   WHERE SUBSTR(EMP_NO, 8, 1) = 2 AND ENT_YN = 'Y')
      AND JOB_CODE = (SELECT JOB_CODE
                      FROM EMPLOYEE
                      WHERE SUBSTR(EMP_NO, 8, 1) = 2 AND ENT_YN = 'Y')
      AND EMP_NAME != (SELECT EMP_NAME
                       FROM EMPLOYEE
                       WHERE SUBSTR(EMP_NO, 8, 1) = 2 AND ENT_YN = 'Y');

SELECT EMP_NAME, JOB_CODE, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE JOB_CODE = (SELECT JOB_CODE FROM EMPLOYEE WHERE ENT_YN = 'Y')
      AND DEPT_CODE = (SELECT DEPT_CODE FROM EMPLOYEE WHERE ENT_YN = 'Y');
-- 이거 내가 대충 한 거
      
-- 다중열 서브쿼리 적용
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE ) IN (SELECT DEPT_CODE, JOB_CODE
                                FROM EMPLOYEE
                                WHERE SUBSTR(EMP_NO, 8, 1) = 2 AND ENT_YN = 'Y')
       AND EMP_NAME != (SELECT EMP_NAME
                        FROM EMPLOYEE
                        WHERE SUBSTR(EMP_NO, 8, 1) = 2 AND ENT_YN = 'Y');
                        
-- 다중행 다중열 서브쿼리
-- 자기 직급의 평균 급여를 받고 있는 직원의 사번, 이름, 직급코드, 급여 조회
-- 단, 급여와 급여 평균은 십만원단위로 계산 TRUNC(컬럼명, -5)
-- 1) 직급 별 평균 급여
SELECT JOB_CODE, TRUNC(AVG(SALARY), -5)
FROM EMPLOYEE
GROUP BY JOB_CODE;

-- 2) 자기 직급의 평균 급여를 받고 있는 직원
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (JOB_CODE, SALARY) IN (SELECT JOB_CODE, TRUNC(AVG(SALARY), -5)
                             FROM EMPLOYEE
                             GROUP BY JOB_CODE);
                             
-- 인라인뷰 : FROM절에 들어간 서브쿼리
-- 전 직원 중 급여가 높은 상위 5명의 순위, 이름, 급여 조회
SELECT ROWNUM, EMP_NAME, SALARY -- ROWNUM : 행 번호 의미, FROM절 수행할 때 붙여짐
FROM EMPLOYEE
ORDER BY SALARY DESC; -- 선동일, 송종기, 정중하, 대북혼, 노옹철
-- ROWNUM 먼저 가져온 뒤 내림차순으로 정렬되어서 ROWNUM순서대로 출력되지 않음

SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE ROWNUM <= 5
ORDER BY SALARY DESC; -- 선동일, 송종기, 노옹철, 유재식, 송은희
-- 테이블에서 먼저 5명을 가져온 뒤 급여순 내림차순 정렬해서 상위 5명이 제대로 나오지 않았음

SELECT ROWNUM, EMP_NAME, SALARY
FROM (SELECT EMP_NAME, SALARY -- SELECT * 라고 해도 된다 (범위를 더 늘리는 것이므로)
-- 만약 여기서 SALARY를 빼면 컬럼 범위가 더 좁아져서 오류남
-- FROM절에서 서브쿼리를 만들어놓고 여기서 상단의 ROWNUM, EMP_NAME, SALARY를 뽑아와야 하므로 범위가 더 좁으면 안 됨
      FROM EMPLOYEE
      ORDER BY SALARY DESC)
WHERE ROWNUM <= 5
ORDER BY SALARY DESC;
-- FROM절에서 미리 급여순으로 내림차순 정렬한 뒤 5개를 가져오니까 상위 5명이 제대로 나옴
-- TOP-N분석

-- 급여 평균 3위 안에 드는 부서의 부서코드와 부서명, 평균 급여 조회

SELECT DEPT_CODE, DEPT_TITLE, /*AVG(SALARY)*/ 평균급여 -- 2. 여기도 같은 별칭으로 넣어주면 된다
FROM (SELECT DEPT_CODE, DEPT_TITLE, AVG(SALARY) 평균급여 
-- 1. 여기서 AVG(SALARY)를 컬럼이 아닌 함수값으로 인지해버려서 오류가 남(별칭 붙여 해결)
      FROM EMPLOYEE
           JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
      GROUP BY DEPT_CODE, DEPT_TITLE
      ORDER BY AVG(SALARY) DESC)
WHERE ROWNUM <= 3;

-- WITH : 서브쿼리에 이름을 붙여줌
-- 같은 서브쿼리가 여러번 사용이 될 때 중복 작성을 줄임
-- 실행 속도도 빨라짐
WITH TOPN_SAL AS (SELECT *
                  FROM EMPLOYEE
                  ORDER BY SALARY DESC)
SELECT ROWNUM, EMP_NAME, SALARY
FROM TOPN_SAL;


WITH AVG_SAL AS (SELECT DEPT_CODE, DEPT_TITLE, AVG(SALARY) 평균급여 
              FROM EMPLOYEE
                   JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
              GROUP BY DEPT_CODE, DEPT_TITLE
              ORDER BY AVG(SALARY) DESC)
SELECT DEPT_CODE, DEPT_TITLE, /*AVG(SALARY)*/ 평균급여
FROM AVG_SAL
WHERE ROWNUM <= 3;

-- RANK() OVER / DENSE_RANK() OVER
-- RANK() OVER : 동일한 순위 이후의 등수를 동일한 인원 수만큼 건너뛰고 계산
SELECT RANK() OVER(ORDER BY SALARY DESC) 순위, EMP_NAME, SALARY
FROM EMPLOYEE;

-- DENSE_RANK() OVER : 중복되는 순위 이후의 등수를 이후 등수로 계산
SELECT DENSE_RANK() OVER(ORDER BY SALARY DESC) 순위, EMP_NAME, SALARY
FROM EMPLOYEE;