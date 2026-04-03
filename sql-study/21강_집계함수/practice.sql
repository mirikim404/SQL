-- ================================================
-- 21강. COUNT 이외의 집계함수
-- ================================================

-- 실습용 테이블 및 데이터 준비 (20강에서 이어짐)
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
-- 1. SUM — 합계
-- ------------------------------------------------

-- quantity 합계 (NULL은 자동 제외)
SELECT SUM(quantity) FROM sample51;


-- ------------------------------------------------
-- 2. AVG — 평균
-- ------------------------------------------------

-- quantity 평균 (NULL 제외하고 계산 → 분모도 NULL 제외한 행 수)
SELECT AVG(quantity) FROM sample51;

-- NULL을 0으로 치환해서 평균 계산 (분모가 달라짐, 결과 비교!)
SELECT AVG(CASE WHEN quantity IS NULL THEN 0 ELSE quantity END) AS avgnull0
FROM sample51;


-- ------------------------------------------------
-- 3. MIN / MAX — 최솟값 / 최댓값
-- ------------------------------------------------

-- 수치형
SELECT MIN(quantity), MAX(quantity) FROM sample51;

-- 문자열형 (알파벳 순서로 비교)
SELECT MIN(name), MAX(name) FROM sample51;


-- ------------------------------------------------
-- 4. 한번에 모아보기
-- ------------------------------------------------
SELECT
    COUNT(*)        AS 전체행수,
    COUNT(quantity) AS quantity행수_NULL제외,
    SUM(quantity)   AS 합계,
    AVG(quantity)   AS 평균_NULL제외,
    MIN(quantity)   AS 최솟값,
    MAX(quantity)   AS 최댓값
FROM sample51;