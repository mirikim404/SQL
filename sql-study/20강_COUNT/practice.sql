-- ================================================
-- 20강. 행 개수 구하기 — COUNT
-- ================================================

-- 실습용 테이블 및 데이터 준비
-- ------------------------------------------------
DROP TABLE IF EXISTS sample51;

CREATE TABLE sample51 (
    no      INTEGER,
    name    VARCHAR(20),
    quantity INTEGER
);

INSERT INTO sample51 VALUES (1, 'A', 10);
INSERT INTO sample51 VALUES (2, 'A', 20);
INSERT INTO sample51 VALUES (3, 'B', 10);
INSERT INTO sample51 VALUES (4, 'C', NULL);
INSERT INTO sample51 VALUES (5, NULL, 30);

SELECT * FROM sample51;

-- ------------------------------------------------
-- 1. COUNT로 행 개수 구하기
-- ------------------------------------------------

-- 테이블 전체 행 수
SELECT COUNT(*) FROM sample51;

-- WHERE 조건에 맞는 행 수
SELECT COUNT(*) FROM sample51 WHERE name = 'A';


-- ------------------------------------------------
-- 2. 집계함수와 NULL 값
-- ------------------------------------------------

-- COUNT(*) : NULL 포함해서 카운트
SELECT COUNT(*) FROM sample51;

-- COUNT(열명) : NULL 제외하고 카운트
SELECT COUNT(name) FROM sample51;

-- 결과 비교 (차이 확인!)
SELECT COUNT(*), COUNT(name) FROM sample51;


-- ------------------------------------------------
-- 3. DISTINCT로 중복 제거
-- ------------------------------------------------

-- ALL (기본값) : 중복 포함
SELECT ALL name FROM sample51;

-- DISTINCT : 중복 제거
SELECT DISTINCT name FROM sample51;


-- ------------------------------------------------
-- 4. 집계함수에서 DISTINCT
-- ------------------------------------------------

-- NULL 제외 + 중복 포함 개수 vs NULL 제외 + 중복 제거 개수
SELECT COUNT(ALL name), COUNT(DISTINCT name) FROM sample51;