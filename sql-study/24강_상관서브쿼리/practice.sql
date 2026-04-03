-- ================================================
-- 24강. 상관 서브쿼리
-- ================================================

-- 실습용 테이블 및 데이터 준비
-- ------------------------------------------------
DROP TABLE IF EXISTS sample551;
DROP TABLE IF EXISTS sample552;

CREATE TABLE sample551 (
    no INTEGER,
    a  VARCHAR(10)
);

CREATE TABLE sample552 (
    no2 INTEGER
);

INSERT INTO sample551 VALUES (1, NULL);
INSERT INTO sample551 VALUES (2, NULL);
INSERT INTO sample551 VALUES (3, NULL);
INSERT INTO sample551 VALUES (4, NULL);
INSERT INTO sample551 VALUES (5, NULL);

INSERT INTO sample552 VALUES (1);
INSERT INTO sample552 VALUES (3);
INSERT INTO sample552 VALUES (5);

SELECT * FROM sample551;
SELECT * FROM sample552;

-- ------------------------------------------------
-- 1. EXISTS — 행이 존재하면 업데이트
-- ------------------------------------------------

-- sample552에 대응하는 no가 있으면 '있음'으로 업데이트
UPDATE sample551 SET a = '있음'
WHERE EXISTS (
    SELECT * FROM sample552 WHERE sample552.no2 = sample551.no
);

SELECT * FROM sample551;  -- 결과 확인


-- ------------------------------------------------
-- 2. NOT EXISTS — 행이 존재하지 않으면 업데이트
-- ------------------------------------------------

-- sample552에 대응하는 no가 없으면 '없음'으로 업데이트
UPDATE sample551 SET a = '없음'
WHERE NOT EXISTS (
    SELECT * FROM sample552 WHERE sample552.no2 = sample551.no
);

SELECT * FROM sample551;  -- 결과 확인


-- ------------------------------------------------
-- 3. IN — 집합 비교
-- ------------------------------------------------

-- 직접 집합 지정
SELECT * FROM sample551 WHERE no IN (1, 3, 5);

-- 서브쿼리로 집합 지정
SELECT * FROM sample551 WHERE no IN (SELECT no2 FROM sample552);

-- NOT IN
SELECT * FROM sample551 WHERE no NOT IN (SELECT no2 FROM sample552);


-- ------------------------------------------------
-- 4. IN과 NULL 주의
-- ------------------------------------------------

-- NULL이 포함된 집합으로 NOT IN 사용 시 결과 확인
-- (UNKNOWN이 되어 아무 행도 반환되지 않음!)
INSERT INTO sample552 VALUES (NULL);

SELECT * FROM sample551 WHERE no NOT IN (SELECT no2 FROM sample552);
-- 결과: 0건 (NULL 때문에 모두 UNKNOWN 처리)

-- NULL 제거 후 다시 확인
SELECT * FROM sample551 WHERE no NOT IN (
    SELECT no2 FROM sample552 WHERE no2 IS NOT NULL
);