# 데이터베이스 생성 
CREATE DATABASE ubion10;
# 데이터베이스 선택
USE ubion10;
# 테이블 생성 
CREATE TABLE user (
id varchar(32), 
pass varchar(64)
);
# 데이터 삽입 (모든 필드)
INSERT INTO user 
VALUES ('test', '1234');

# 데이터 삽입 (특정 필드)
INSERT INTO user (id, pass)
VALUES ('test2', '1111');

# 데이터 수정 
UPDATE user
SET pass = '0000'
WHERE id = 'test';

# 데이터 삭제 
DELETE FROM user WHERE id = 'test2';

# 데이터 조회 
SELECT * FROM user;

# 테이블 구조 변경(컬럼 구조 변경 ) 
ALTER TABLE user 
MODIFY COLUMN id varchar(32) primary key;

# 테이블 삭제 
DROP TABLE user;

# 데이터베이스 삭제 
DROP DATABASE ubion10;


# emp 테이블에서 SAL이 2000이상인 사원 정보를 출력
use ubion10;

SELECT * FROM emp 
WHERE SAL >= 2000;

# 월급이 1500이상이고 3000 이하인 사원의 정보 출력
SELECT * FROM 
emp 
WHERE SAL >= 1500 
AND 
SAL <= 3000;

SELECT * FROM 
emp WHERE SAL BETWEEN 1500 AND 3000;

SELECT * FROM 
emp WHERE (SAL >= 1500) & (SAL <=3000);

# job 컬럼의 데이터가 'salesman', 'manager'인
# 사원 정보를 출력
SELECT * FROM emp 
WHERE JOB = 'salesman'
OR JOB = 'manager';

SELECT * FROM emp 
WHERE JOB IN ('SALESMAN', 'MANAGER');

## JOB이 'SALESMAN', 'MANAGER' 아닌 사원 정보
SELECT * FROM emp 
WHERE JOB != 'SALESMAN'
AND JOB != 'MANAGER';

SELECT * FROM emp 
WHERE JOB NOT IN ('SALESMAN', 'MANAGER');

# 사원의 이름에서 S로 시작하는 사원 정보 출력 
SELECT * FROM emp 
WHERE ENAME LIKE 'S%';

# 그룹화 
# JOB을 기준으로 그룹화, SAL 평균 
SELECT JOB, AVG(SAL) as MEAN FROM emp 
GROUP BY JOB;







