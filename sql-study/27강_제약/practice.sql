-- ================================================
-- 27강. 제약
-- ================================================

-- ------------------------------------------------
-- 1. 열 제약 / 테이블 제약
-- ------------------------------------------------

DROP TABLE IF EXISTS sample631;

-- 열 제약: 열 정의 옆에 바로 기술
-- 테이블 제약: 열 정의 끝난 후 별도로 기술
CREATE TABLE sample631 (
    a INTEGER      NOT NULL,          -- 열 제약: NOT NULL
    b INTEGER      NOT NULL UNIQUE,   -- 열 제약: NOT NULL + UNIQUE
    c VARCHAR(30),
    CONSTRAINT pkey_sample631 PRIMARY KEY (a)  -- 테이블 제약: PRIMARY KEY (이름 지정)
);

DESC sample631;

-- 데이터 삽입
INSERT INTO sample631 VALUES (1, 10, 'hello');
INSERT INTO sample631 VALUES (2, 20, 'world');
INSERT INTO sample631 VALUES (3, 30, NULL);   -- c는 NULL 허용

SELECT * FROM sample631;


-- ------------------------------------------------
-- 2. 제약 위반 확인
-- ------------------------------------------------

-- NOT NULL 위반
-- INSERT INTO sample631 VALUES (NULL, 40, 'test');  -- 에러!

-- UNIQUE 위반 (b=10 이미 존재)
-- INSERT INTO sample631 VALUES (4, 10, 'test');     -- 에러!

-- PRIMARY KEY 중복 위반 (a=1 이미 존재)
-- INSERT INTO sample631 VALUES (1, 40, 'test');     -- 에러!

-- UPDATE에서도 기본키 중복 위반
-- UPDATE sample631 SET a = 1 WHERE a = 3;           -- 에러!


-- ------------------------------------------------
-- 3. 제약 추가
-- ------------------------------------------------

-- 열 제약 추가 (MODIFY)
ALTER TABLE sample631 MODIFY c VARCHAR(30) NOT NULL DEFAULT 'none';

DESC sample631;

-- 기존 NULL 데이터 먼저 업데이트 후 제약 추가해야 에러 안 남
UPDATE sample631 SET c = 'none' WHERE c IS NULL;
ALTER TABLE sample631 MODIFY c VARCHAR(30) NOT NULL;

DESC sample631;


-- ------------------------------------------------
-- 4. 제약 삭제
-- ------------------------------------------------

-- 열 제약 삭제 (NOT NULL 제거)
ALTER TABLE sample631 MODIFY c VARCHAR(30);
DESC sample631;

-- 테이블 제약 삭제 (제약명으로)
ALTER TABLE sample631 DROP PRIMARY KEY;
DESC sample631;


-- ------------------------------------------------
-- 5. 복수 열 기본키 실습
-- ------------------------------------------------

DROP TABLE IF EXISTS sample_pk;

CREATE TABLE sample_pk (
    student_id INTEGER     NOT NULL,
    course_id  INTEGER     NOT NULL,
    grade      VARCHAR(5),
    PRIMARY KEY (student_id, course_id)  -- 두 열의 조합이 유일해야 함
);

INSERT INTO sample_pk VALUES (1, 101, 'A');   -- 학생1, 과목101
INSERT INTO sample_pk VALUES (1, 102, 'B');   -- 학생1, 과목102 (student_id 중복이지만 OK)
INSERT INTO sample_pk VALUES (2, 101, 'A');   -- 학생2, 과목101 (course_id 중복이지만 OK)

SELECT * FROM sample_pk;

-- 조합 중복 위반
-- INSERT INTO sample_pk VALUES (1, 101, 'C');  -- 에러! (1, 101) 조합 이미 존재