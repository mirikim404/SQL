-- ================================================
-- 28강. 인덱스 구조
-- ================================================
-- 이 강은 개념 위주라 실습은 인덱스 유무에 따른
-- 검색 방식 차이를 EXPLAIN으로 확인하는 데 집중한다.
-- ------------------------------------------------

-- ------------------------------------------------
-- 1. 실습용 테이블 및 데이터 준비
-- ------------------------------------------------

DROP TABLE IF EXISTS sample_index;

CREATE TABLE sample_index (
    no   INTEGER,
    name VARCHAR(50),
    age  INTEGER
);

-- 데이터 여러 건 삽입 (인덱스 효과를 보려면 데이터가 많을수록 좋음)
INSERT INTO sample_index VALUES (1,  'Alice',   25);
INSERT INTO sample_index VALUES (2,  'Bob',     30);
INSERT INTO sample_index VALUES (3,  'Charlie', 22);
INSERT INTO sample_index VALUES (4,  'Diana',   28);
INSERT INTO sample_index VALUES (5,  'Eve',     35);
INSERT INTO sample_index VALUES (6,  'Frank',   27);
INSERT INTO sample_index VALUES (7,  'Grace',   31);
INSERT INTO sample_index VALUES (8,  'Henry',   24);
INSERT INTO sample_index VALUES (9,  'Iris',    29);
INSERT INTO sample_index VALUES (10, 'Jack',    33);

SELECT * FROM sample_index;


-- ------------------------------------------------
-- 2. 인덱스 없을 때 EXPLAIN — 풀 테이블 스캔 확인
-- ------------------------------------------------

-- type이 'ALL'이면 풀 테이블 스캔 (인덱스 미사용)
EXPLAIN SELECT * FROM sample_index WHERE no = 5;


-- ------------------------------------------------
-- 3. 인덱스 생성
-- ------------------------------------------------

CREATE INDEX idx_no ON sample_index (no);


-- ------------------------------------------------
-- 4. 인덱스 있을 때 EXPLAIN — 인덱스 사용 확인
-- ------------------------------------------------

-- type이 'ref' 또는 'range'이면 인덱스 사용 중
EXPLAIN SELECT * FROM sample_index WHERE no = 5;

-- 실제 검색
SELECT * FROM sample_index WHERE no = 5;


-- ------------------------------------------------
-- 5. 인덱스가 효율 없는 경우 확인
-- ------------------------------------------------

-- 종류가 적은 열 (age는 중복값 많음)
CREATE INDEX idx_age ON sample_index (age);

-- EXPLAIN으로 인덱스 사용 여부 확인
-- 데이터가 적으면 풀스캔이 더 빠르다고 판단해 인덱스 안 쓸 수 있음!
EXPLAIN SELECT * FROM sample_index WHERE age > 25;