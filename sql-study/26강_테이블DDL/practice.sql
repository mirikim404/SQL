-- ================================================
-- 26강. 테이블 작성·삭제·변경
-- ================================================

-- ------------------------------------------------
-- 1. CREATE TABLE — 테이블 작성
-- ------------------------------------------------

DROP TABLE IF EXISTS sample62;

CREATE TABLE sample62 (
    no INTEGER      NOT NULL,
    a  VARCHAR(30),
    b  DATE
);

-- 테이블 구조 확인
DESC sample62;

-- 데이터 삽입
INSERT INTO sample62 VALUES (1, 'hello', '2024-01-01');
INSERT INTO sample62 VALUES (2, 'world', '2024-06-15');

SELECT * FROM sample62;


-- ------------------------------------------------
-- 2. DROP TABLE / DELETE / TRUNCATE 비교
-- ------------------------------------------------

-- 실습용 임시 테이블
DROP TABLE IF EXISTS sample_del;

CREATE TABLE sample_del (
    no INTEGER,
    name VARCHAR(20)
);

INSERT INTO sample_del VALUES (1, 'A');
INSERT INTO sample_del VALUES (2, 'B');
INSERT INTO sample_del VALUES (3, 'C');

SELECT * FROM sample_del;

-- DELETE : 조건에 맞는 행만 삭제 (테이블 구조 유지)
DELETE FROM sample_del WHERE no = 1;
SELECT * FROM sample_del;

-- TRUNCATE : 전체 행 삭제 (WHERE 불가, 빠름)
TRUNCATE TABLE sample_del;
SELECT * FROM sample_del;  -- 빈 테이블

-- DROP : 테이블 자체 삭제
DROP TABLE sample_del;
-- SELECT * FROM sample_del;  -- 에러 발생 (테이블 없음)


-- ------------------------------------------------
-- 3. ALTER TABLE — 열 추가
-- ------------------------------------------------

-- 열 추가
ALTER TABLE sample62 ADD new_col INTEGER;
DESC sample62;

SELECT * FROM sample62;  -- 기존 행의 new_col은 NULL

-- 기본값 지정해서 열 추가
ALTER TABLE sample62 ADD new_col2 INTEGER DEFAULT 0;
DESC sample62;

SELECT * FROM sample62;  -- 기존 행의 new_col2는 0


-- ------------------------------------------------
-- 4. ALTER TABLE — 열 속성 변경 (MODIFY)
-- ------------------------------------------------

-- VARCHAR 최대길이 늘리기
ALTER TABLE sample62 MODIFY a VARCHAR(100);
DESC sample62;

-- NOT NULL 추가
ALTER TABLE sample62 MODIFY new_col2 INTEGER NOT NULL DEFAULT 0;
DESC sample62;


-- ------------------------------------------------
-- 5. ALTER TABLE — 열 이름 변경 (CHANGE)
-- ------------------------------------------------

-- 열 이름 + 속성 변경
ALTER TABLE sample62 CHANGE new_col new_column VARCHAR(20);
DESC sample62;


-- ------------------------------------------------
-- 6. ALTER TABLE — 열 삭제 (DROP)
-- ------------------------------------------------

ALTER TABLE sample62 DROP new_column;
ALTER TABLE sample62 DROP new_col2;
DESC sample62;

SELECT * FROM sample62;