-- 함수 : 컬럼의 값을 읽어서 계산한 결과 리턴
-- 단일행 함수 : 컬럼에 기록된 n개의 값을 읽어 n개의 결과 리턴
-- 그룹 함수 : 컬럼에 기록된 n개의 값을 읽어 1개의 결과 리턴 
-- 단일행함수 그룹함수는 함께 사용할 수 있다(X)/없다(O) => 결과 행의 개수가 다르기 때문

-- 단일행 함수
-- 1. 문자관련 함수
-- LENGTH/LENGTHB
SELECT LENGTH('오라클'), LENGTHB('오라클')    -- 한글 1글자는 3byte로 인식
FROM DUAL; -- 가상 테이블

SELECT LENGTH(EMAIL), LENGTHB(EMAIL)        -- 영어 1글자는 1byte로 인식
FROM EMPLOYEE;

-- INSTR : 해당 문자열의 가장 앞쪽 위치(오라클에서는 1부터 셈)
SELECT INSTR('AABAACAABBAA', 'B') FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'Z') FROM DUAL;
-- 자바에서 없는 문자의 위치는 -1로 반환, 오라클에서도 1부터 세니까 없는 문자는 0을 반환하게 됨
SELECT INSTR('AABAACAABBAA', 'B', 1) FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', 7) FROM DUAL;     
-- 세번째 조건은 검색을 시작하는 위치, 7번째부터 시작해서 B의 위치를 찾으면 9번째가 됨
SELECT INSTR('AABAACAABBAA', 'B', -1) FROM DUAL;
-- 세번째 조건으로 -1을 넣으면 뒤에서부터 검색
SELECT INSTR('AABAACAABBAA', 'B', 1, 2) FROM DUAL;
-- 1부터 검색 시작하지만 두번째 B를 찾아라

-- EMPLOYEE 테이블에서 이메일의 @ 위치 반환
SELECT INSTR(EMAIL, '@')
FROM EMPLOYEE;

-- LPAD/RPAD
-- 제시한 숫자만큼의 공간을 만들어놓고 남는 공간은 임의의 문자로 왼쪽/오른쪽에 채워넣음
SELECT LPAD(EMAIL, 20) FROM EMPLOYEE;
SELECT LPAD(EMAIL, 20, '#') FROM EMPLOYEE;
-- 길이를 20으로 맞춰놓고 오른쪽 정렬, 왼쪽의 공백을 #으로 채운다
SELECT RPAD(EMAIL, 20, '#') FROM EMPLOYEE;
-- 길이를 20으로 맞춰놓고 왼쪽 정렬, 오른쪽의 공백을 #으로 채운다

-- LTRIM/RTRIM/TRIM
SELECT LTRIM('   KH') FROM DUAL;                --KH
SELECT LTRIM('KH   ') A FROM DUAL;              --KH   )
SELECT LTRIM('   KH', ' ') FROM DUAL;           --KH
SELECT LTRIM('00012345', '0') FROM DUAL;        --12345
SELECT LTRIM('123123KH', '123') FROM DUAL;      --KH
SELECT LTRIM('123123KH123', '123') FROM DUAL;   --KH123
SELECT LTRIM('ACBBAKH', 'ABC') FROM DUAL;
-- A 또는 B 또는 C를 지우는 것! ABC만을 지우는 게 아님
SELECT PHONE, LTRIM(PHONE, '010') FROM EMPLOYEE;
-- 010만을 지우는 게 아니기 때문에 011도 지워짐 017은 01까지만 지워짐

SELECT RTRIM('KH   ') A FROM DUAL;      -- KH
SELECT RTRIM('123123KH123', '123') FROM DUAL;       -- 123123KH
SELECT EMAIL, RTRIM(EMAIL, '@kh.or.kr') FROM EMPLOYEE; --@앞의 h나 j등도 지워진다

SELECT TRIM('   KH   ') A FROM DUAL;
SELECT TRIM('Z' FROM 'ZZZKHZZZ') FROM DUAL;     -- 양쪽의 Z를 지움
SELECT TRIM('123' FROM '123123KH12') FROM DUAL; -- 그냥 트림은 문자 하나만 가능해서 이건 오류
SELECT TRIM(LEADING 'Z' FROM 'ZZZKHZZZ') FROM DUAL;     -- 앞에서부터 / KHZZZ
SELECT TRIM(TRAILING 'Z' FROM 'ZZZKHZZZ') FROM DUAL;    -- 뒤에서부터 / ZZZKH
SELECT TRIM(BOTH 'Z' FROM 'ZZZKHZZZ') FROM DUAL;        -- 양쪽에서   / KH

-- SUBSTR = 자바의 String.subString() / 문자열 일부 반환
SELECT SUBSTR('SHOWMETHEMONEY', 7) FROM DUAL;       -- 7번째부터 끝까지 반환
SELECT SUBSTR('SHOWMETHEMONEY', 5, 2) FROM DUAL;    -- 5번째부터 2글자 반환
SELECT SUBSTR('SHOWMETHEMONEY', 5, 0) FROM DUAL;    -- NULL
SELECT SUBSTR('SHOWMETHEMONEY', -8, 3) FROM DUAL;   -- 거꾸로 8번째인 T부터 오른쪽으로 3글자 / THE


-- EMPLOYEE 테이블의 이름, 이메일, @ 이후를 제외한 아이디 조회
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@') -1) 아이디
FROM EMPLOYEE;
 -- 이메일의 1부터 이메일의 @이 들어가는 자리 바로 전까지 일부 반환

-- 주민등록번호를 이용하여 남/여 판단하여 이름, 성별 조회
SELECT EMP_NAME, SUBSTR(EMP_NO, 8, 1) 성별
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 남자만 조회(사원명, '남')
SELECT EMP_NAME, '남' 성별
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = 1;

-- EMPLOYEE 테이블에서 여자만 조회(사원명, '여')
SELECT EMP_NAME, '여' 성별
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = 2;

-- EMPLOYEE 테이블에서 직원들의 주민번호를 이용하여 사원명, 생년, 생월, 생일 조회
SELECT EMP_NAME, SUBSTR(EMP_NO, 1, 2) || '년' 생년, 
        SUBSTR(EMP_NO, 3, 2) ||'월' 생월, 
        SUBSTR(EMP_NO, 5, 2) ||'일' 생일
FROM EMPLOYEE;

-- LOWER/UPPER/INITCAP
SELECT LOWER('Welcom To My World') LOWER,   -- 모두 소문자로
        UPPER('Welcom To My World') UPPER,  -- 모두 대문자로
        INITCAP('Welcom To My World') INITCAP FROM DUAL;
SELECT INITCAP('WELCOME TO MY WORLD') FROM DUAL;    -- 단어의 맨 앞글자만 대문자로 변환

-- CONCAT : 문자열 합치기
SELECT CONCAT('가나다라', '마바사') FROM DUAL;
SELECT '가나다라' || '마바사' FROM DUAL;

-- REPLACE
SELECT REPLACE('서울시 강남구 역삼동', '역삼동', '삼성동') FROM DUAL;
SELECT REPLACE('박신우강사님은 G강의장에 있습니다', '강사님', '선생님') FROM DUAL;

-- EMPLOYEE 테이블에서 사원명, 주민번호 조회
-- 주민번호는 생년월일만 보이게 하고 '-' 다음은 '*'로 변경
SELECT EMP_NAME 사원명, SUBSTR(EMP_NO, 1, INSTR(EMP_NO, '-')) || '*******' 주민번호
FROM EMPLOYEE;

SELECT EMP_NAME 사원명, REPLACE(EMP_NO, SUBSTR(EMP_NO, INSTR(EMP_NO, '-')+1), '*******') 주민번호
FROM EMPLOYEE;

SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO, 1, INSTR(EMP_NO, '-')), LENGTH(EMP_NO), '*') 주민번호
FROM EMPLOYEE;

-- 2. 숫자관련 함수
-- ABS : 절대값
SELECT ABS(10.9) FROM DUAL; -- 10.9
SELECT ABS(-10.9) FROM DUAL; -- 10.9
SELECT ABS(-10) FROM DUAL; -- 10

-- MOD : 모듈러
SELECT MOD(10, 3) FROM DUAL; -- 1
SELECT MOD(-10, 3) FROM DUAL; -- -1
SELECT MOD(10, -3) FROM DUAL; -- 1  ==> 나누어지는 수인 10의 부호를 따라감

-- ROUND : 반올림
SELECT ROUND(123.456) FROM DUAL; -- 123
SELECT ROUND(123.678) FROM DUAL; -- 124
SELECT ROUND(123.456, 0) FROM DUAL; -- 123 / 소수점 첫째자리에서 반올림
SELECT ROUND(123.456, 1) FROM DUAL; -- 123.5 / 소수점 둘째자리에서 반올림
SELECT ROUND(123.456, 2) FROM DUAL; -- 123.46 // 소수점 셋째자리에서 반올림
SELECT ROUND(123.456, -1) FROM DUAL; -- 소수점 앞인 1의 자리에서 반올림

-- FLOOR : 내림 (수학적 의미)
SELECT FLOOR(123.456) FROM DUAL; -- 123 
SELECT FLOOR(123.678) FROM DUAL; -- 123

-- TRUNC : 소수점 뒤를 삭제 (수학적 의미X)
SELECT TRUNC(123.456) FROM DUAL; -- 123 
SELECT TRUNC(123.678) FROM DUAL; -- 123

-- CEIL : 올림
SELECT CEIL(123.456) FROM DUAL; -- 124
SELECT CEIL(123.678) FROM DUAL; -- 124

-- 3. 날짜관련 함수
-- SYSDATE
SELECT SYSDATE FROM DUAL;

-- MONTHS_BETWEEN : 개월 수의 차이를 숫자로 리턴
-- EMPLOYEE 테이블에서 사원의 이름, 입사일, 근무 개월 수 조회
SELECT EMP_NAME, HIRE_DATE, MONTHS_BETWEEN(SYSDATE, HIRE_DATE)
FROM EMPLOYEE;

SELECT EMP_NAME, HIRE_DATE, ABS(MONTHS_BETWEEN(HIRE_DATE, SYSDATE))
FROM EMPLOYEE;
-- 실수할 수도 있으니 절대값을 넣어준다.

SELECT EMP_NAME, HIRE_DATE, CEIL(ABS(MONTHS_BETWEEN(HIRE_DATE, SYSDATE))) || '개월차' 개월차
FROM EMPLOYEE;
-- 5개월차라고 하면 5개월을 꽉 채운 것이 아니라 숫자만 센 것이기 때문에 개월차를 나타낼 땐 올림을 쓴다.

-- ADD_MONTHS : 날짜에 숫자만큼 개월수를 더하여 날짜 리턴 (오늘 날짜 21/09/09)
SELECT ADD_MONTHS(SYSDATE, 2) FROM DUAL;
SELECT ADD_MONTHS(SYSDATE, 4) FROM DUAL; -- 22/01/09 연도까지도 바뀜

-- NEXT_DAY : 기준 날짜에서 구하려는 요일에 가장 가까운 날짜 리턴
-- 1=일 / 2=월 / 3=화 / 4=수 / 5=목 / 6=금 / 7=토
SELECT SYSDATE, NEXT_DAY(SYSDATE, '금요일') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 6) FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, '금') FROM DUAL;
-- 금요일에 가장 가까운 날짜인 21/09/10 반환, 당일이어도 상관X
SELECT SYSDATE, NEXT_DAY(SYSDATE, '월남쌈 맛있잖아, 그치?') FROM DUAL;   -- 맨 앞에 월이 들어가서 13일 월요일이 나옴
SELECT SYSDATE, NEXT_DAY(SYSDATE, '우뢰와 같은 박수를 보내주세요') FROM DUAL; -- 중간에 수가 들어있지만 결과가 나오지 않음
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'FRIDAY') FROM DUAL;
ALTER SESSION SET NLS_LANGUAGE = AMERICAN; -- 영어로 바꿔주면 FRIDAY는 나오지만 이제 한글 결과는 안 나옴
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'FRI') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'FRIDKJLA;FD;') FROM DUAL; -- 맨 앞이 FRI니까 인식함
ALTER SESSION SET NLS_LANGUAGE = KOREAN; -- 다시 한글로 바꿔주는 작업 필요

-- LAST_DAY : 해당 월의 마지막 날짜를 구하여 리턴
SELECT SYSDATE, LAST_DAY(SYSDATE) FROM DUAL;

-- EMPLOYEE 테이블에서 사원명, 입사일-오늘, 오늘-입사일 조회
--      단 별칭은 근무일수1, 근무일수2로 하고 모두 정수처리(내림)
SELECT EMP_NAME, FLOOR(HIRE_DATE - SYSDATE) 근무일수1, FLOOR(SYSDATE - HIRE_DATE) 근무일수2
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 사번이 홀수인 직원들의 정보 모두 조회
SELECT *
FROM EMPLOYEE
WHERE MOD(EMP_ID, 2) = 1;

-- EMPLOYEE 테이블에서 근무연수가 20년 이상인 직원 정보 조회
SELECT *
FROM EMPLOYEE
--WHERE ABS(MONTHS_BETWEEN(HIRE_DATE, SYSDATE)) >= 240;
--WHERE (SYSDATE-HIRE_DATE)/365 >= 20;
WHERE ADD_MONTHS(HIRE_DATE, 240) <= SYSDATE;
-- 고용일에 20년 더했는데 오늘 날짜보다 크면 20년이 안 됐다는 뜻

-- EXTRACT : 년, 월, 일 정보를 추출하여 리턴
-- EMPLOYEE 테이블에서 사원의 이름, 입사년도, 입사 월, 입사일
SELECT EMP_NAME 이름, 
        EXTRACT(YEAR FROM HIRE_DATE) 입사년도,
        EXTRACT(MONTH FROM HIRE_DATE) "입사 월",
        EXTRACT(DAY FROM HIRE_DATE) 입사일
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 사원의 이름, 입사일, 근무연수 조회
--      단 근무연수는 현재연도 - 입사연도로 조회
SELECT EMP_NAME 이름, HIRE_DATE 입사일,
        (EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)) 근무연수
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 사원명, 입사일, 입사한 달의 근무 일수 조회
SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE) - HIRE_DATE
FROM EMPLOYEE;

-- 4. 형변환 함수
-- TO_CHAR : 날짜/숫자형 데이터를 문자형 데이터로 변경
SELECT TO_CHAR(1234), 1234 AAAAAAA FROM DUAL; -- 1234 / 똑같은 것처럼 보이지만 문자 1234로 바뀌었음
-- 문자는 왼쪽 정렬, 숫자는 오른쪽 정렬 5교시 2시 10분쯤
SELECT TO_CHAR(1234, '99999') A FROM DUAL;  --  1234 : 5칸 오른쪽 정렬, 빈칸 공백
SELECT TO_CHAR(1234, '00000') A FROM DUAL;  -- 01234 : 5칸 오른쪽 정렬, 빈칸 0
SELECT TO_CHAR(1234, 'L99999') FROM DUAL;   --  \1234
SELECT TO_CHAR(1234, 'FML99999') FROM DUAL; -- 1234
-- FM : 공백 제거 / L : 그 나라 화폐단위
SELECT TO_CHAR(1234, '$99999') FROM DUAL;   --  $1234
SELECT TO_CHAR(1234, 'FM$99999') FROM DUAL; -- $1234
SELECT TO_CHAR(1234, '99,999') FROM DUAL;   --  1,234
SELECT TO_CHAR(1234, 'FM99,999') FROM DUAL; -- 1,234
SELECT TO_CHAR(1234, '999') FROM DUAL;      -- ####

-- EMPLOYEE 테이블에서 사원명, 급여 표시
-- 급여 '\9,000,000' 형식으로 표시
SELECT EMP_NAME, TO_CHAR(SALARY, 'FML999,999,999') FROM EMPLOYEE;

SELECT TO_CHAR(SYSDATE, 'PM HH:MI:SS') FROM DUAL; -- 오후 02:31:11
SELECT TO_CHAR(SYSDATE, 'AM HH:MI:SS') FROM DUAL; -- 오후 02:31:11 / 지금 시간이 오후라서 AM으로 바꿔도 오후로 나옴
SELECT TO_CHAR(SYSDATE, 'AM HH24:MI:SS') FROM DUAL; -- 오후 14:32:21
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY') FROM DUAL; -- 2021-09-09 목요일
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-FMDD DAY') FROM DUAL; -- 2021-09-9 목요일
SELECT TO_CHAR(SYSDATE, 'YYYY"년" MM"월" DD"일" DAY') FROM DUAL; -- 2021년 09월 09일 목요일

SELECT TO_CHAR(SYSDATE, 'YYYY'), -- 2021
        TO_CHAR(SYSDATE, 'YY'),  -- 21
        TO_CHAR(SYSDATE, 'YEAR') -- TWENTY TWENTY-ONE
FROM DUAL;
-- 2021	21	TWENTY TWENTY-ONE

SELECT TO_CHAR(SYSDATE, 'MM'),      --09
        TO_CHAR(SYSDATE, 'MONTH'),  --9월
        TO_CHAR(SYSDATE, 'MON'),    --9월
        TO_CHAR(SYSDATE, 'RM')      --IX
FROM DUAL;
-- 09	9월 	9월 	IX  

SELECT TO_CHAR(SYSDATE, 'DDD') "1년 기준", --252
       TO_CHAR(SYSDATE, 'DD') "달 기준",   --09
       TO_CHAR(SYSDATE, 'D') "주 기준"     --5
FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'Q') 분기,   -- 3분기
       TO_CHAR(SYSDATE, 'DAY'),     -- 목요일
       TO_CHAR(SYSDATE, 'DY')       -- 목
FROM DUAL;

-- EMPLOYEE 테이블에서 이름, 입사일 조회
--    입사일 : 0000년 00월 00일 (0)

SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'YYYY"년" MM"월" DD"일 ("DY")"')
FROM EMPLOYEE;
-- EX) 선동일 	1990년 02월 06일 (화) . . .

-- TO_DATE : 문자/숫자형 데이터를 날짜형 데이터로 변경
SELECT TO_DATE('20200202', 'YYYYMMDD') FROM DUAL; -- 20/02/02 / 문자를 날짜로
SELECT TO_DATE(20200202, 'YYYYMMDD') FROM DUAL; -- 20/02/02 / 숫자를 날짜로

SELECT TO_CHAR(TO_DATE('20200202 153824', 'YYYYMMDD HH24MISS'), 'YYYY-MM-DD HH:MI:SS') FROM DUAL;
--문자를 날짜로 바꿨다가 다시 문자로 바꾸는데 내가 원하는 형식을 이용해서 반환

-- TO_DATE에서 두 자리 연도에 YY를 적용시키면 무조건 현재 세기(21세기, 2000년대)가 적용
--                         RR을 적용시키면 두 자리 연도수가 50이상일 때는 이전 세기(20세기, 1900년대),
--                                                     50미만일 때는 현재 세기(21세기, 2000년대) 적용
-- 문자를 날짜로 바꿀 때는 RR을 사용하는 편이 좋음
SELECT TO_CHAR(TO_DATE('990311', 'YYMMDD'), 'YYYYMMDD') "99YY", -- 20990311 
       TO_CHAR(TO_DATE('070108', 'YYMMDD'), 'YYYYMMDD') "07YY", -- 20070108
       TO_CHAR(TO_DATE('990311', 'RRMMDD'), 'YYYYMMDD') "99RR", -- 19990311
       TO_CHAR(TO_DATE('070108', 'RRMMDD'), 'YYYYMMDD') "07RR"  -- 20070108
FROM DUAL;

-- TO_NUMBER : 문자형 데이터를 숫자형 데이터로 변경
SELECT TO_NUMBER('12345') FROM DUAL;
SELECT 1111 + 2222 FROM DUAL; -- 3333
SELECT '1111' + '2222' FROM DUAL; -- 3333 / 문자여도 자동으로 숫자로 변환해서 더해줌
SELECT '1,111' + '2,222' FROM DUAL; -- ,는 숫자로 바꿀 수 없기 때문에 오류 뜸
SELECT TO_NUMBER('1,111', '999,999') + TO_NUMBER('2,222', '9,999') -- 3333 / 숫자로 바꾸기만 하면 연산 가능
FROM DUAL;

-- 5. NULL처리 함수
-- NVL
SELECT EMP_NAME, BONUS, NVL(BONUS, 0)   -- 보너스가 NULL이면 0으로 출력 / EX) 송종기 (null)	0
FROM EMPLOYEE;

SELECT EMP_NAME, BONUS, NVL(BONUS, 0), DEPT_CODE, NVL(DEPT_CODE, '부서X')
FROM EMPLOYEE;
-- 하동운 	0.1	 0.1 (null)	부서X / 부서가 null이면 부서X으로 출력

-- NVL2
SELECT EMP_NAME, BONUS, NVL2(BONUS, 0.7, 0.5) 
FROM EMPLOYEE;
-- 선동일	 0.3	0.7
-- 송종기	(null)	0.5
-- BONUS 값이 있으면 첫 번째인 0.7, 없으면(null) 두 번째인 0.5

-- NULLIF
SELECT NULLIF(123, 123), NULLIF(123, 132) FROM DUAL; -- (null)	123
-- 두 값이 같으면 null, 같지 않으면 123

-- 6. 선택함수
-- DECODE : DECODE(계산식|컬럼명, 조건값1, 선택값1, 조건값2, 선택값2, ...) 
-- 비교하고자 하는 값/컬럼이 조건식과 같으면 선택값 반환
SELECT EMP_ID, EMP_NAME, EMP_NO,
       DECODE(SUBSTR(EMP_NO, 8, 1), 1, '남', 2, '여') 성별
FROM EMPLOYEE;

SELECT EMP_ID, EMP_NAME, EMP_NO,
       DECODE(SUBSTR(EMP_NO, 8, 1), 1, '남', '여') 성별
FROM EMPLOYEE;
-- 결과가 두 가지밖에 없으니 이렇게 써주면 1은 남, 나머지는 모두 여로 반환됨

-- 직급코드가 J7이면 직원의 급여를 10% 인상
-- 직급코드가 J6이면 직원의 급여를 15% 인상
-- 직급코드가 J5이면 직원의 급여를 20% 인상
-- 그 외 직급은 급여를 5% 인상
-- 직원명, 직급 코드, 급여, 인상 급여 조회

SELECT EMP_NAME 직원명 , JOB_CODE "직급 코드", SALARY 급여, 
       DECODE(JOB_CODE, 'J7', SALARY*1.1, 
                        'J6', SALARY*1.15, 
                        'J5', SALARY*1.2, 
                        SALARY*1.05) "인상 급여"
FROM EMPLOYEE;

SELECT EMP_NAME 직원명 , JOB_CODE "직급 코드", SALARY 급여, 
       SALARY * (1 + DECODE(JOB_CODE, 'J7', 0.1, 
                                      'J6', 0.15, 
                                      'J5', 0.2, 
                                      0.05)) "인상 급여"
FROM EMPLOYEE;

-- CASE WHEN
-- CASE WHEN 조건식 THEN 결과값
--      WHEN 조건식 THEN 결과값
--      ELSE 결과값
-- END
-- 비교하고자 하는 값 또는 컬럼이 조건식과 같으면 결과값 반환
-- 조건은 범위 값 가능(DECODE와 차이)

SELECT EMP_ID, EMP_NAME, EMP_NO,
       CASE WHEN SUBSTR(EMP_NO, 8, 1) = 1 THEN '남자'
            WHEN SUBSTR(EMP_NO, 8, 1) = 2 THEN '여자'
       END 성별
FROM EMPLOYEE;

SELECT EMP_ID, EMP_NAME, EMP_NO,
       CASE WHEN SUBSTR(EMP_NO, 8, 1) = 1 THEN '남자'
            ELSE '여자'
       END 성별
FROM EMPLOYEE;

-- 직급코드가 J7이면 직원의 급여를 10% 인상
-- 직급코드가 J6이면 직원의 급여를 15% 인상
-- 직급코드가 J5이면 직원의 급여를 20% 인상
-- 그 외 직급은 급여를 5% 인상
-- 직원명, 직급 코드, 급여, 인상 급여 조회

SELECT EMP_NAME, JOB_CODE, SALARY,
       CASE WHEN JOB_CODE = 'J7' THEN SALARY*1.1
            WHEN JOB_CODE = 'J6' THEN SALARY*1.15
            WHEN JOB_CODE = 'J5' THEN SALARY*1.2
            ELSE SALARY*1.05
            END 인상급여
FROM EMPLOYEE;

SELECT EMP_NAME, JOB_CODE, SALARY,
       CASE JOB_CODE WHEN 'J7' THEN SALARY*1.1
                     WHEN 'J6' THEN SALARY*1.15
                     WHEN 'J5' THEN SALARY*1.2
                     ELSE SALARY*1.05
       END 인상급여
FROM EMPLOYEE;

-- 사번, 사원명, 급여, 등급 조회
-- 등급 조건 : 급여가 500만보다 크면 1등급, 350만보다 크면 2등급, 200만보다 크면 3등급, 나머지는 4등급
SELECT EMP_ID, EMP_NAME, SALARY,
       CASE WHEN SALARY > 5000000 THEN '1등급'
            WHEN SALARY > 3500000 THEN '2등급'
            WHEN SALARY > 2000000 THEN '3등급'
            ELSE '4등급'
       END 등급
FROM EMPLOYEE;

-- 사번, 사원명, 급여
-- 급여가 500만원 이상이면 '고급'
-- 급여가 300~500만원이면 '중급'
-- 그 이하는 '초급'으로 출력처리하고 별칭은 '구분'으로 한다.

SELECT EMP_ID, EMP_NAME,
       CASE WHEN SALARY >= 5000000 THEN '고급'
            WHEN SALARY >= 3000000 THEN '중급'
            ELSE '초급'
       END 구분
FROM EMPLOYEE;


-- 그룹함수
-- SUM
-- EMPLOYEE 테이블에서 전 사원의 급여 총합
SELECT SUM(SALARY)
-- SELECT SUM(SALARY), SALARY 라고 쓰면 그룹함수가 아니기 때문의 출력되지 않음
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 남자 사원의 급여 총합 조회
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = 1;

-- EMPLOYEE 테이블에서 부서코드가 D5인 직원의 보너스 포함된 연봉 합계 조회
SELECT SUM(SALARY*(1 + NVL(BONUS, 0))* 12) "연봉 합계"
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

-- AVG
-- EMPLOYEE 테이블에서 전 사원의 급여 평균
SELECT AVG(SALARY)
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 전 사원의 보너스 평균을 소수 셋째자리에서 반올림 조회
SELECT ROUND(AVG(BONUS), 2)     -- NULL값은 평균 계산에서 제외됨
FROM EMPLOYEE; -- 0.22

SELECT ROUND(AVG(NVL(BONUS, 0)), 2) --보너스가 NULL인 직원은 0으로 만들어줘야 제대로 된 값이 나옴
FROM EMPLOYEE; -- 0.08

SELECT AVG(BONUS), AVG(DISTINCT BONUS), AVG(NVL(BONUS, 0))
FROM EMPLOYEE;

-- MIN/MAX : 숫자, 문자, 날짜 적용 가능
-- EMPLOYEE 테이블에서 가장 적은 급여, 알파벳 순서가 가장 빠른 이메일, 가장 빠른 입사일 조회
SELECT MIN(SALARY), MIN(EMAIL), MIN(HIRE_DATE)
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 가장 많은 급여, 알파벳 순서가 가장 늦은 이메일, 가장 최근 입사일 조회
SELECT MAX(SALARY), MAX(EMAIL), MAX(HIRE_DATE)
FROM EMPLOYEE;

-- COUNT
-- COUNT(컬럼명) : 해당 컬럼에 대한 개수 리턴(NULL 제외)
-- COUNT(DISTINCT 컬럼명) : 중복 제거된 행 개수 리턴
-- COUNT(*) : NULL을 포함한 전체 행 개수 리턴

-- 전체 사원 수, 부서코드가 있는 사원 수, 사원들이 속해 있는 부서 수
SELECT COUNT(*), COUNT(DEPT_CODE), COUNT(DISTINCT DEPT_CODE)
FROM EMPLOYEE;

