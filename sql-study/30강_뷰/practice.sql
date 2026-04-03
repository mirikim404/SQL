-- ================================================
-- 30강. 뷰 작성과 삭제
-- ================================================

-- ------------------------------------------------
-- 1. 실습용 테이블 및 데이터 준비
-- ------------------------------------------------

DROP TABLE IF EXISTS sample54;

CREATE TABLE sample54 (
    no   INTEGER,
    name VARCHAR(20),
    age  INTEGER
);

INSERT INTO sample54 VALUES (1, 'Alice',   25);
INSERT INTO sample54 VALUES (2, 'Bob',     30);
INSERT INTO sample54 VALUES (3, 'Charlie', 22);
INSERT INTO sample54 VALUES (4, 'Diana',   28);
INSERT INTO sample54 VALUES (5, 'Eve',     35);

SELECT * FROM sample54;


-- ------------------------------------------------
-- 2. 뷰 작성 — CREATE VIEW
-- ------------------------------------------------

-- 기본 뷰 (열 이름 생략 → SELECT 구의 열 이름 그대로 사용)
DROP VIEW IF EXISTS view_sample;

CREATE VIEW view_sample AS
SELECT * FROM sample54 WHERE age >= 28;

-- 뷰 조회 (테이블처럼 사용)
SELECT * FROM view_sample;


-- ------------------------------------------------
-- 3. 뷰에 열 이름 직접 지정
-- ------------------------------------------------

DROP VIEW IF EXISTS view_sample2;

CREATE VIEW view_sample2 (번호, 이름, 나이) AS
SELECT no, name, age FROM sample54;

SELECT * FROM view_sample2;


-- ------------------------------------------------
-- 4. 뷰 vs 서브쿼리 비교
-- ------------------------------------------------

-- 서브쿼리 방식 (매번 이렇게 써야 함)
SELECT * FROM (SELECT * FROM sample54 WHERE age >= 28) sq;

-- 뷰 방식 (훨씬 간결!)
SELECT * FROM view_sample;


-- ------------------------------------------------
-- 5. 뷰 활용 — 집계와 조합
-- ------------------------------------------------

DROP VIEW IF EXISTS view_agg;

CREATE VIEW view_agg AS
SELECT age, COUNT(*) AS cnt
FROM sample54
GROUP BY age;

SELECT * FROM view_agg;

-- 뷰를 FROM 구에서 서브쿼리처럼 활용
SELECT * FROM view_agg WHERE cnt >= 1 ORDER BY age;


-- ------------------------------------------------
-- 6. 뷰에 INSERT/UPDATE 주의 확인
-- ------------------------------------------------

-- 단순 뷰는 INSERT 가능하지만 원본 테이블에 반영됨
INSERT INTO view_sample VALUES (6, 'Frank', 40);
SELECT * FROM sample54;     -- 원본 테이블에 추가된 것 확인
SELECT * FROM view_sample;  -- 뷰에도 반영됨

-- 집계 뷰는 INSERT 불가
-- INSERT INTO view_agg VALUES (26, 2);  -- 에러!


-- ------------------------------------------------
-- 7. 뷰 삭제 — DROP VIEW
-- ------------------------------------------------

DROP VIEW IF EXISTS view_sample;
DROP VIEW IF EXISTS view_sample2;
DROP VIEW IF EXISTS view_agg;

-- 뷰 삭제 후 확인 (에러 발생)
-- SELECT * FROM view_sample;  -- 에러!

-- 원본 테이블은 그대로 유지됨
SELECT * FROM sample54;