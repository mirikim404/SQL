-- ================================================
-- 25강. 데이터베이스 객체
-- ================================================
-- 이 강에서는 객체와 스키마 개념을 확인한다.
-- 직접 스키마(데이터베이스)를 만들고 그 안에 테이블을 생성해보자.
-- ------------------------------------------------

-- ------------------------------------------------
-- 1. 스키마(데이터베이스) 확인
-- ------------------------------------------------

-- 현재 존재하는 데이터베이스 목록 확인
SHOW DATABASES;

-- 현재 사용 중인 데이터베이스 확인
SELECT DATABASE();


-- ------------------------------------------------
-- 2. 스키마(데이터베이스) 생성 및 이동
-- ------------------------------------------------

-- 새 스키마 생성
CREATE DATABASE IF NOT EXISTS schema_a;
CREATE DATABASE IF NOT EXISTS schema_b;

-- schema_a로 이동
USE schema_a;

-- schema_a 안에 테이블 생성
CREATE TABLE IF NOT EXISTS test_table (
    no   INTEGER,
    name VARCHAR(20)
);

INSERT INTO test_table VALUES (1, 'schema_a의 테이블');

SELECT * FROM test_table;


-- ------------------------------------------------
-- 3. 같은 이름, 다른 스키마 — 충돌 없음 확인
-- ------------------------------------------------

-- schema_b로 이동
USE schema_b;

-- schema_a와 동일한 이름의 테이블 생성 (충돌 없음!)
CREATE TABLE IF NOT EXISTS test_table (
    no   INTEGER,
    name VARCHAR(20)
);

INSERT INTO test_table VALUES (1, 'schema_b의 테이블');

SELECT * FROM test_table;

-- 스키마명.테이블명 형식으로 다른 스키마 테이블 조회
SELECT * FROM schema_a.test_table;
SELECT * FROM schema_b.test_table;


-- ------------------------------------------------
-- 4. 정리 (실습 후 삭제)
-- ------------------------------------------------
DROP DATABASE IF EXISTS schema_a;
DROP DATABASE IF EXISTS schema_b;