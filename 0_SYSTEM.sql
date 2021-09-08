
/*
여러줄 주석
*/
--　한　줄　주석


--　관리자　계정　：　데이터베이스의　생성과　관리를　담당하는　슈퍼　유저　계정
--                 오브젝트　생성，　변경，　삭제　등의　작업　가능
--                데이터베이스에　대한　모든　권한　및　책임을　가짐
--　사용자　계정　：　데이터베이스에　대한　질의(QUERY)，　갱신，　보고서　작성　등　작업을　수행할　수　있는　계정
--                  일반　계정은　보안을　위해　업무에　필요한　최소한의　권한만　가지는　것을　원칙으로　함

--　１１ｇ　버전
--CREATE USER KH IDENTIFIED BY KH; --　계정　생성　쿼리
--생성    　계정         　비밀번호　지정
--               계정이름                       비밀번호　（앞으로도　계정이름과　비번　동일하게）

--　12c 버전～
--　18c　버전
-- CREATE USER c##KH IDENTIFIED BY KH;
-- c##을　붙이는　일이　번거롭기　때문에　이전　버전처럼　안　붙이고도　계정　생성할　수　있는　세션　설정
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
CREATE USER KH IDENTIFIED BY KH;
GRANT CONNECT, RESOURCE TO KH; -- 권한 부여 쿼리

--　Data Dictionary(DD), 데이터　사전
--　데이터베이스의　데이터를　제외한　DB　전반에　대한　모든　정보　제공
--　SYSTEM(관리자)이　DD에　대한　내용을　변경할　수　있는　권한을　가지고　있고
--　사용자　계정은　단순　조회만　가능（읽기　전용　형태로　제공됨）

-- 테이블 : 행(row)과 열(column)로 구성되는 가장 기본적인 데이터베이스 객체
--         데이터베이스 내에서 모든 데이터는 테이블을 통해 저장
-- 인덱스 : 검색 연산을 최적화하기 위해 데이터베이스 상에 행들의 정보를 구성하는 데이터 구조
--         인덱스를 이용하면 전체 데이터를 검색하지 않고 데이터베이스에서 원하는 정보를 빠르게 검색 가능
--         (수업은 안 하지만 면접 때 중요, 공부해야 함)

alter user KH default tablespace system quota unlimited on system;
-- 테이블 스페이스 용량에 제한을 두지 않고 만들겠다
-- 이름&비밀번호와 리터럴만 대소문자를 가리고 나머지는 대소문자 상관없음
