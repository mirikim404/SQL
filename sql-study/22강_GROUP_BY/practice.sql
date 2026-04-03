-- ================================================
-- 22강. 그룹화 — GROUP BY
-- ================================================
 
-- 실습용 테이블 및 데이터 준비
-- ------------------------------------------------
DROP TABLE IF EXISTS sample51;

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

SELECT * FROM sample51;


-- ------------------------------------------------
-- 1. GROUP BY 기본
-- ------------------------------------------------

-- name 열로 그룹화
SELECT name FROM sample51 GROUP BY name;

-- DISTINCT와 결과 비교 (결과는 같아 보이지만 의미가 다름!)
SELECT DISTINCT name FROM sample51;

-- ------------------------------------------------
-- 2. GROUP BY + 집계함수
-- ------------------------------------------------

-- name별 행 수, quantity 합계
SELECT name, COUNT(name), SUM(quantity) FROM sample51 GROUP BY name;


-- ------------------------------------------------
-- 3. HAVING — 그룹 조건 필터
-- ------------------------------------------------

-- 에러 발생 확인 (WHERE에 집계함수 사용 불가)
-- SELECT name, COUNT(name), SUM(quantity) FROM sample51 WHERE COUNT(name) = 1 GROUP BY name;

-- HAVING으로 해결
SELECT name, COUNT(name) FROM sample51 GROUP BY name HAVING COUNT(name) = 1;

-- WHERE + GROUP BY + HAVING 조합
-- name이 NULL이 아닌 행만 대상으로, 그룹별 quantity 합계가 10 초과인 그룹만
SELECT name, COUNT(name), SUM(quantity) FROM sample51 
WHERE name IS NOT NULL GROUP BY name
HAVING SUM(quantity) > 10;


-- ------------------------------------------------
-- 4. ORDER BY로 정렬
-- ------------------------------------------------
 
-- quantity 합계 기준 내림차순 정렬
SELECT name, COUNT(name), SUM(quantity)
FROM sample51
GROUP BY name
ORDER BY SUM(quantity) DESC;