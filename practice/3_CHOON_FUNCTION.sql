-- 1. 영문과(학과코드 002) 학생들의 학번, 이름, 입학연도를 연도가 빠른 순으로 조회
-- (단, 헤더는 "학번", "이름", "입학연도" 가 표시되도록 한다.)
SELECT STUDENT_NO 학번, STUDENT_NAME 이름, ENTRANCE_DATE 입학연도
FROM TB_STUDENT
WHERE DEPARTMENT_NO = 002
ORDER BY ENTRANCE_DATE;

-- 2. 이름이 세 글자가 아닌 교수의 이름과 주민번호 조회하기
SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE PROFESSOR_NAME NOT LIKE '___';

-- 3. 나이가 적은 순으로 남교수 이름과 만 나이 출력
-- (단, 2000년 이후 출생자는 없으며 출력 헤더는 "교수이름", "나이"로 한다.)
SELECT PROFESSOR_NAME 교수이름, 
       (TO_CHAR(SYSDATE, 'YY') + 100) - SUBSTR(PROFESSOR_SSN, 1, 2) 나이
FROM TB_PROFESSOR
WHERE SUBSTR(PROFESSOR_SSN, 8, 1) = 1
ORDER BY 나이;

-- 4. 교수들의 성을 제외한 이름만 조회(출력 헤더는 "이름"이 찍히도록 한다.)
SELECT SUBSTR(PROFESSOR_NAME, 2) 이름
FROM TB_PROFESSOR;

-- 5. 재수생 입학자 조회(19살 입학은 재수 아닌 것으로 간주)
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE EXTRACT(YEAR FROM ENTRANCE_DATE) - 
      EXTRACT(YEAR FROM TO_DATE((SUBSTR(STUDENT_SSN, 1, 6)), 'RRMMDD')) > 19;
--      EXTRACT(YEAR FROM TO_DATE((19 || SUBSTR(STUDENT_SSN, 1, 6)), 'YYMMDD')) > 19;

-- 6. 2020년 크리스마스는 무슨 요일인가?
SELECT TO_CHAR(TO_DATE('20/12/25'), 'DY') || '요일' "2020년 크리스마스"
FROM DUAL;

-- 7. 
SELECT TO_CHAR(TO_DATE('99/10/11', 'YY/MM/DD'), 'YYYYMMDD') "99YY",
       TO_CHAR(TO_DATE('49/10/11', 'YY/MM/DD'), 'YYYYMMDD') "49YY",
       TO_CHAR(TO_DATE('99/10/11', 'RR/MM/DD'), 'YYYYMMDD') "99RR",
       TO_CHAR(TO_DATE('49/10/11', 'RR/MM/DD'), 'YYYYMMDD') "49RR"
FROM DUAL;

-- 8. 2000년도 이전 학번 학생 조회
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE EXTRACT(YEAR FROM ENTRANCE_DATE) < 2000;
--WHERE STUDENT_NO NOT LIKE 'A%';

-- 9. 학번 A517178 한아름 학생의 총 평점(단, 헤더는 "평점"으로, 점수는 소수점 첫째자리까지 표시)
SELECT ROUND(AVG(POINT), 1) 평점
FROM TB_GRADE
WHERE STUDENT_NO = 'A517178';

-- 10. 학과별 학생수를 구하여 "학과번호", "학생수(명)"의 형태로 출력
SELECT DEPARTMENT_NO 학과번호, COUNT(*) "학생수(명)"
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY DEPARTMENT_NO;

-- 11. 지도교수가 없는 학생의 수 조회
SELECT COUNT(*)
FROM TB_STUDENT
WHERE COACH_PROFESSOR_NO IS NULL;

-- 12. 학번 A112113 김고운 학생의 연도 별 평점
--(출력 헤더는 "연도", "연도 별 평점"으로 하며 점수는 소수점 첫째자리까지 표시)
SELECT SUBSTR(TERM_NO, 1, 4) 연도, ROUND(AVG(POINT), 1) "연도 별 평점"
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY SUBSTR(TERM_NO, 1, 4)
ORDER BY SUBSTR(TERM_NO, 1, 4); -- 1;로 해도 됨

-- 13. 학과 번호와 학과 별 휴학생 수 조회(헤더 "학과코드명", "휴학생 수")
SELECT DEPARTMENT_NO 학과코드명, SUM(DECODE(ABSENCE_YN, 'Y', 1, 'N', 0)) "휴학생 수"
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY DEPARTMENT_NO;

-- 14. 동명이인 찾기(헤더 "동일이름", 동명인 수)
SELECT STUDENT_NAME 동일이름, COUNT(*) "동명인 수"
FROM TB_STUDENT
GROUP BY STUDENT_NAME
HAVING COUNT(*) >= 2;

-- 15. 학번 A112113 김고운 학생의 연도 별, 학기 별 평점과 연도 별 누적 평점, 총 평점 조회
-- (단, 평점은 소수점 첫째자리까지 표시)
SELECT SUBSTR(TERM_NO, 1, 4) 연도, SUBSTR(TERM_NO, 5, 2) 학기, ROUND(AVG(POINT), 1) 평점
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY ROLLUP(SUBSTR(TERM_NO, 1, 4), SUBSTR(TERM_NO, 5, 2));

