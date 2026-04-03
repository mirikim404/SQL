-- ================================================
-- 23강. 서브쿼리
-- ================================================

-- 실습용 테이블 및 데이터 준비
-- ------------------------------------------------
DROP TABLE IF EXISTS sample54;
DROP TABLE IF EXISTS sample51;
DROP TABLE IF EXISTS sample541;

CREATE TABLE sample54 (
    no INTEGER,
    a  INTEGER
);

INSERT INTO sample54 VALUES (1, 10);
INSERT INTO sample54 VALUES (2, 30);
INSERT INTO sample54 VALUES (3, 50);
INSERT INTO sample54 VALUES (4, 10);
INSERT INTO sample54 VALUES (5, 20);

CREATE TABLE sample51 (
    no       INTEGER,
    name     VARCHAR(20),
    quantity INTEGER
);

INSERT INTO sample51 VALUES (1, 'A', 10);
INSERT INTO sample51 VALUES (2, 'A', 20);
INSERT INTO sample51 VALUES (3, 'B', 10);
INSERT INTO sample51 VALUES (4, 'C', NULL);
INSERT INTO sample51 VALUES (5, NULL, 30);

CREATE TABLE sample541 (
    a INTEGER,
    b INTEGER
);

SELECT * FROM sample54;
SELECT * FROM sample51;

-- ------------------------------------------------
-- 1. DELETE + 서브쿼리
-- ------------------------------------------------

-- a열의 최솟값을 가진 행 삭제
-- (MySQL에서는 임시 테이블로 우회해야 함)
DELETE FROM sample54
WHERE a = (SELECT a FROM (SELECT MIN(a) AS a FROM sample54) AS x);

SELECT * FROM sample54;  -- 결과 확인


-- ------------------------------------------------
-- 2. 스칼라 서브쿼리 — SELECT 구에서 사용
-- ------------------------------------------------

SELECT
    (SELECT COUNT(*) FROM sample51) AS sample51_cnt,
    (SELECT COUNT(*) FROM sample54) AS sample54_cnt;


-- ------------------------------------------------
-- 3. 스칼라 서브쿼리 — SET 구에서 사용 (UPDATE)
-- ------------------------------------------------

-- a열 전체를 현재 최댓값으로 업데이트
UPDATE sample54 SET a = (SELECT a FROM (SELECT MAX(a) AS a FROM sample54) AS x);

SELECT * FROM sample54;  -- 결과 확인


-- ------------------------------------------------
-- 4. FROM 구에서 서브쿼리 사용
-- ------------------------------------------------

-- 기본 중첩
SELECT * FROM (SELECT * FROM sample51) sq;

-- 정렬 후 상위 2건 추출 (MySQL 방식)
SELECT * FROM (SELECT * FROM sample51 ORDER BY quantity DESC) sq LIMIT 2;


-- ------------------------------------------------
-- 5. INSERT + 서브쿼리
-- ------------------------------------------------

-- VALUES 구에 스칼라 서브쿼리
INSERT INTO sample541
VALUES (
    (SELECT COUNT(*) FROM sample51),
    (SELECT COUNT(*) FROM sample54)
);

SELECT * FROM sample541;

-- INSERT SELECT (열 수·자료형 일치하면 됨)
INSERT INTO sample541 SELECT 1, 2;

SELECT * FROM sample541;