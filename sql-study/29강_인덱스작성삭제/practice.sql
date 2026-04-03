-- ================================================
-- 29강. 인덱스 작성과 삭제
-- ================================================

-- ------------------------------------------------
-- 1. 실습용 테이블 및 데이터 준비
-- ------------------------------------------------

DROP TABLE IF EXISTS sample_idx;

CREATE TABLE sample_idx (
    no   INTEGER,
    name VARCHAR(50),
    age  INTEGER
);

INSERT INTO sample_idx VALUES (1, 'Alice',   25);
INSERT INTO sample_idx VALUES (2, 'Bob',     30);
INSERT INTO sample_idx VALUES (3, 'Charlie', 22);
INSERT INTO sample_idx VALUES (4, 'Diana',   28);
INSERT INTO sample_idx VALUES (5, 'Eve',     35);

SELECT * FROM sample_idx;


-- ------------------------------------------------
-- 2. 인덱스 작성 — CREATE INDEX
-- ------------------------------------------------

-- 단일 열 인덱스
CREATE INDEX idx_no ON sample_idx (no);

-- 복수 열 인덱스
CREATE INDEX idx_name_age ON sample_idx (name, age);

-- 현재 테이블의 인덱스 목록 확인
SHOW INDEX FROM sample_idx;


-- ------------------------------------------------
-- 3. EXPLAIN — 실행 계획 확인
-- ------------------------------------------------

-- 인덱스가 걸린 열로 검색 → 인덱스 사용 여부 확인
EXPLAIN SELECT * FROM sample_idx WHERE no = 3;

-- 인덱스가 없는 열로 검색 → 풀 테이블 스캔
EXPLAIN SELECT * FROM sample_idx WHERE age = 28;

-- 실제 검색 실행
SELECT * FROM sample_idx WHERE no = 3;


-- ------------------------------------------------
-- 4. 인덱스 삭제 — DROP INDEX
-- ------------------------------------------------

-- MySQL: DROP INDEX 인덱스명 ON 테이블명
DROP INDEX idx_no ON sample_idx;
DROP INDEX idx_name_age ON sample_idx;

-- 인덱스 삭제 후 확인
SHOW INDEX FROM sample_idx;

-- 인덱스 삭제 후 EXPLAIN — 다시 풀 테이블 스캔으로 바뀜
EXPLAIN SELECT * FROM sample_idx WHERE no = 3;


-- ------------------------------------------------
-- 5. DROP TABLE 시 인덱스 자동 삭제 확인
-- ------------------------------------------------

-- 인덱스 다시 생성
CREATE INDEX idx_no ON sample_idx (no);
SHOW INDEX FROM sample_idx;

-- 테이블 삭제 → 인덱스도 함께 사라짐
DROP TABLE sample_idx;
-- SHOW INDEX FROM sample_idx;  -- 에러 (테이블 없음)