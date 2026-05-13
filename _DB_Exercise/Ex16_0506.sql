/* 테이블 구조
Theater : 극장
    th_num      : 극장번호(PK)
    th_name     : 극장이름
    th_loc      : 위치

Screen : 상영관
    th_num      : 극장번호(FK)
    scr_num     : 상영관번호(PK)
    mov_name        : 영화제목
    price       : 가격
    seat_cnt    : 좌석수

S_Customer : 고객
    cust_num    : 고객번호(PK)
    cust_name   : 고객이름
    cust_loc    : 고객주소

Reservation : 예약
    th_num      : 극장번호(FK)
    scr_num     : 상영관번호(FK)
    cust_num    : 고객번호(FK)
    seat_num    : 좌석번호
    res_date    : 예약날짜
*/

-- =========================================================================
-- 테이블 삭제
Drop table Reservation; -- 예약
Drop table Screen;      -- 상영관
Drop table S_Customer;  -- 고객
Drop table Theater;     -- 극장

-- 테이블 생성
-- 극장 테이블
Create Table Theater(
    th_num Number Primary Key,
    th_name Varchar2(100) Not Null,
    th_loc Varchar2(100)
);

-- 상영관 테이블
Create Table Screen(
    th_num Number,
    scr_num Number,
    mov_name Varchar2(200) Not Null,
    price Number,
    seat_cnt number,
    CONSTRAINT pk_Screen PRIMARY KEY (th_num, scr_num),
    CONSTRAINT fk_Screen_Theater FOREIGN Key (th_num) References Theater(th_num)
);

--고객 테이블
Create Table S_Customer(
    cust_num Number Primary key,
    cust_name Varchar2(100) Not Null,
    cust_loc Varchar2(200)
);

-- 예약테이블
Create table Reservation(
    th_num Number,
    scr_num Number,
    cust_num Number,
    seat_num Number,
    res_date Date,
    CONSTRAINT pk_Reservation PRIMARY KEY (th_num, scr_num, cust_num),
    CONSTRAINT fk_Reservation_Screen FOREIGN key (th_num, scr_num) References Screen(th_num, scr_num),
    CONSTRAINT fk_Reservation_Customer FOREIGN key (cust_num) References S_Customer(cust_num)
);

-- =========================================================================
-- 샘플데이터 삽입
-- 극장 데이터 (5개 극장)
INSERT INTO Theater VALUES (1, '강남극장', '강남');
INSERT INTO Theater VALUES (2, '강동극장', '강동');
INSERT INTO Theater VALUES (3, '홍대극장', '마포');
INSERT INTO Theater VALUES (4, '신촌극장', '서대문');
INSERT INTO Theater VALUES (5, '잠실극장', '송파');

-- 상영관 데이터 (극장별 2~3개 상영관)
INSERT INTO Screen VALUES (1, 1, '아바타', 12000, 150);
INSERT INTO Screen VALUES (1, 2, '범죄도시4', 11000, 120);
INSERT INTO Screen VALUES (1, 3, '파묘', 9000, 80);
INSERT INTO Screen VALUES (2, 1, '듄2', 13000, 200);
INSERT INTO Screen VALUES (2, 2, '건국전쟁', 8000, 60);
INSERT INTO Screen VALUES (3, 1, '오펜하이머', 12000, 180);
INSERT INTO Screen VALUES (3, 2, '서울의봄', 10000, 100);
INSERT INTO Screen VALUES (3, 3, '밀수', 9000, 90);
INSERT INTO Screen VALUES (4, 1, '콘크리트유토피아', 11000, 130);
INSERT INTO Screen VALUES (4, 2, '외계+인', 7000, 70);
INSERT INTO Screen VALUES (5, 1, '탑건매버릭', 13000, 250);
INSERT INTO Screen VALUES (5, 2, '앤트맨', 10000, 110);

-- 고객 데이터 (8명)
INSERT INTO S_Customer VALUES (1, '김철수', '서울시 강남구 역삼동');
INSERT INTO S_Customer VALUES (2, '이영희', '서울시 강동구 천호동');
INSERT INTO S_Customer VALUES (3, '박민준', '서울시 마포구 홍대동');
INSERT INTO S_Customer VALUES (4, '최수연', '서울시 서대문구 신촌동');
INSERT INTO S_Customer VALUES (5, '정하늘', '서울시 송파구 잠실동');
INSERT INTO S_Customer VALUES (6, '한지민', '서울시 강북구 수유동');
INSERT INTO S_Customer VALUES (7, '강감찬', '서울시 용산구 이태원동');
INSERT INTO S_Customer VALUES (8, '장내윤', '서울시 성동구 왕십리동');

-- 예약 데이터 (다양한 날짜와 좌석)
INSERT INTO Reservation VALUES (1, 1, 1, 15, TO_DATE('2024-10-01', 'YYYY-MM-DD'));
INSERT INTO Reservation VALUES (1, 1, 2, 23, TO_DATE('2024-10-01', 'YYYY-MM-DD'));
INSERT INTO Reservation VALUES (1, 2, 3, 7, TO_DATE('2024-10-05', 'YYYY-MM-DD'));
INSERT INTO Reservation VALUES (1, 3, 4, 11, TO_DATE('2024-10-05', 'YYYY-MM-DD'));
INSERT INTO Reservation VALUES (2, 1, 1, 50, TO_DATE('2024-10-10', 'YYYY-MM-DD'));
INSERT INTO Reservation VALUES (2, 1, 5, 88, TO_DATE('2024-10-10', 'YYYY-MM-DD'));
INSERT INTO Reservation VALUES (2, 2, 6, 3, TO_DATE('2024-10-12', 'YYYY-MM-DD'));
INSERT INTO Reservation VALUES (3, 1, 2, 77, TO_DATE('2024-10-15', 'YYYY-MM-DD'));
INSERT INTO Reservation VALUES (3, 2, 7, 45, TO_DATE('2024-10-15', 'YYYY-MM-DD'));
INSERT INTO Reservation VALUES (3, 3, 8, 62, TO_DATE('2024-10-18', 'YYYY-MM-DD'));
INSERT INTO Reservation VALUES (4, 1, 3, 19, TO_DATE('2024-10-20', 'YYYY-MM-DD'));
INSERT INTO Reservation VALUES (4, 2, 4, 33, TO_DATE('2024-10-20', 'YYYY-MM-DD'));
INSERT INTO Reservation VALUES (5, 1, 5, 100, TO_DATE('2024-10-22', 'YYYY-MM-DD'));
INSERT INTO Reservation VALUES (5, 1, 6, 120, TO_DATE('2024-10-22', 'YYYY-MM-DD'));
INSERT INTO Reservation VALUES (5, 2, 7, 55, TO_DATE('2024-10-25', 'YYYY-MM-DD'));
INSERT INTO Reservation VALUES (5, 2, 8, 67, TO_DATE('2024-10-25', 'YYYY-MM-DD'));

commit;

-- =========================================================================
-- 전체데이터 확인
select * from Theater;
SELECT * from Screen;
select * from CUSTOMER;
select * from Reservation;

-- 4개 테이블 전체 조인 확인
SELECT t.th_name, s.scr_num, s.mov_name, s.price, c.cust_name as 고객이름, r.seat_num, r.res_date
from THEATER t
JOIN SCREEN s on t.th_num = s.TH_NUM
JOIN RESERVATION r on s.SCR_NUM = r.SCR_NUM and s.SCR_NUM = r.SCR_NUM
JOIN S_CUSTOMER c on r.CUST_NUM = c.CUST_num
order by r.RES_DATE, t.th_num;

-- =========================================================================
-- 문제 3
-- 1) 영화 가격이 9,000원 이상인 상영관의 극장번호를 추출하시오
select DISTINCT TH_NUM from SCREEN WHERE PRICE >= 9000;

-- 2) 극장별 상영관(두 테이블 조인)
select * from THEATER, SCREEN
where THEATER.TH_NUM = SCREEN.SCR_NUM;

-- 3) 영화 가격이 10,000원 이상인 영화를 상영하는 극장이름
select DISTINCT t.th_name from THEATER t
JOIN SCREEN s on t.th_num = s.th_num
WHERE s.PRICE >= 10000;

-- 4) 예약 날짜가 2024년 1월 1일 이후인 고객 정보와 예약 내용
-- (예약이 없는 고객도 포함 → LEFT OUTER JOIN)
SELECT c.cust_num, c.cust_name, c.cust_loc, r.th_num, r.scr_num, r.seat_num, r.res_date
from S_CUSTOMER c
LEFT OUTER JOIN RESERVATION r
ON c.cust_num = r.cust_num
and r.res_date > to_date('2024-01-01', 'YYYY-MM-DD');

-- 5) 강남에 있는 모든 극장을 예약한 고객의 이름과 극장번호를 출력
SELECT DISTINCT c.cust_name, r.th_num
FROM S_CUSTOMER c
JOIN RESERVATION r
ON c.cust_num = r.cust_num
WHERE NOT EXISTS (
    SELECT t.th_num
    FROM THEATER t
    WHERE t.th_loc = '강남'
    MINUS
    SELECT r2.th_num
    FROM RESERVATION r2
    WHERE r2.cust_num = c.cust_num
);

-- =========================================================================
--문제 4
-- 1) 극장테이블에서 극장이름, 위치를 추출하시오
SELECT th_name, th_loc from THEATER;

-- 2) 영화 가격이 10000이하인 영화제목을 추출하시오
SELECT mov_name from SCREEN
where PRICE <= 10000;

-- 3) 고객테이블에서 이름,주소를 추출하시오
SELECT cust_name, cust_loc from S_CUSTOMER;

-- 4) 극장 위치가 강남인 곳에서 상영 중인 영화제목을 추출하시오
SELECT s.mov_name from THEATER t
JOIN SCREEN s on t.TH_NUM = s.TH_NUM
where t.th_loc = '강남';

-- 5) 강남에 위치한 극장을 모두 예약한 고객 이름
SELECT c.cust_name from s_CUSTOMER c
where not EXISTS(
    SELECT t.th_num from THEATER t
    where t.th_loc = '강남'
    MINUS
    select r.TH_NUM from RESERVATION r
    where r.CUST_NUM = c.cust_num
);

-- =========================================================================
-- [단순질의]
-- 1. 극장테이블에서 극장이름, 위치를 추출하시오
SELECT th_name, th_loc from THEATER;

-- 2. 극장 테이블에서 위치가 '서울'인 극장의 극장이름을 조회하시오.
SELECT th_name from THEATER
where th_loc = '서울';
-- 결과값 없음

-- 3. 상영관 테이블에서 가격이 10000원 이상인 상영관의 극장번호, 상영관번호, 영화제목을 조회하시오.
select th_num as 극장번호, scr_num as 상영관번호, mov_name as 영화제목 from SCREEN
where PRICE >= 10000;

-- 4. 상영관 테이블에서 영화제목별 상영관 수를 조회하시오.
select mov_name, count(SCR_NUM) from SCREEN
GROUP by mov_name;

-- 5. 예약 테이블에서 날짜가 '2024-01-01'인 모든 예약 정보를 조회하시오.
select * from Reservation
where res_date = to_date('2024-01-01', 'YYYY-MM-DD');
-- 결과없음

-- 6. 고객 테이블에서 주소별 고객 수를 조회하시오.
select cust_loc, count(cust_num) from S_CUSTOMER
GROUP BY CUST_LOC;

-- 7. 상영관 테이블에서 좌석수가 가장 많은 상영관의 극장번호와 상영관번호를 조회하시오.
select th_num, scr_num from SCREEN
where SEAT_CNT = (
    select max(seat_cnt) from SCREEN
);

-- 8. 예약 테이블에서 고객번호별 예약 횟수를 조회하시오.
select cust_num, count(cust_num) from RESERVATION
GROUP by CUST_NUM;

-- 9. 상영관 테이블에서 극장번호별 평균 가격을 조회하시오.
select th_num, avg(price) from SCREEN
GROUP BY th_num;

-- 10. 고객 테이블에서 이름이 '김'으로 시작하는 고객의 이름과 주소를 조회하시오.
select cust_name as 고객명, cust_loc as 주소 from S_CUSTOMER
where cust_name like '김%';


-- =========================================================================
-- [조인질의]
-- 11. 극장과 상영관 테이블을 조인하여 극장이름과 해당 극장의 영화제목을 조회하시오.
select t.th_name, s.mov_name from THEATER t JOIN SCREEN s
ON t.TH_NUM = s.TH_NUM;

-- 12. 극장, 상영관, 예약 테이블을 조인하여 극장이름, 영화제목, 예약 날짜를 조회하시오.
select t.th_name as 극장이름, s.mov_name as 영화제목, r.res_date as 예약날짜
from THEATER t join SCREEN s on t.TH_NUM = s.TH_NUM
join RESERVATION r on s.TH_NUM = r.TH_NUM and s.SCR_NUM = r.SCR_NUM;

-- 13. 고객과 예약 테이블을 조인하여 고객 이름과 해당 고객의 예약 날짜를 조회하시오.
select c.cust_name as 고객명, r.res_date as 예약날짜
from S_CUSTOMER c join RESERVATION r on c.CUST_NUM = r.CUST_NUM;

-- 14. 극장, 상영관, 예약, 고객 테이블을 모두 조인하여 극장이름, 영화제목, 고객이름, 좌석번호를 조회하시오.
select t.th_name as 극장이름, s.mov_name as 영화제목, c.cust_name as 고객이름, r.seat_num as 좌석번호
from THEATER t join SCREEN s on t.TH_NUM = s.TH_NUM
join RESERVATION r on s.TH_NUM = r.TH_NUM and s.SCR_NUM = r.SCR_NUM
join S_CUSTOMER c on r.CUST_NUM = c.CUST_NUM;

-- 15. 상영관과 예약 테이블을 조인하여 영화제목별 총 예약 수를 조회하시오.
select s.mov_name as 영화제목, count(s.mov_name) as 예약수
from SCREEN s join RESERVATION r on s.SCR_NUM = r.SCR_NUM and s.TH_NUM = r.TH_NUM
GROUP BY s.MOV_NAME;

-- 16. 극장과 상영관 테이블을 조인하여 위치가 '서울'인 극장에서 상영 중인 영화제목과 가격을 조회하시오.
select s.mov_name as 영화제목, s.price as 가격
from THEATER t JOIN SCREEN s on t.TH_NUM = s.TH_NUM
where t.TH_LOC = '서울';
-- 결과값 없음

-- 17. 고객과 예약 테이블을 LEFT JOIN하여 예약이 한 건도 없는 고객의 이름을 조회하시오.
select c.cust_name as 고객명
from S_CUSTOMER c left JOIN RESERVATION r on c.CUST_NUM = r.CUST_NUM
where r.CUST_NUM is NULL;
-- 결과값 없음

-- 18. 극장, 상영관, 예약 테이블을 조인하여 극장별 총 예약 수를 조회하시오.
select t.TH_NAME as 극장명, count(r.res_date) as 예약수
from Theater t join Screen s on t.th_num = s.th_num
join Reservation r on s.scr_num = r.scr_num and s.TH_NUM = r.TH_NUM
GROUP by t.TH_NAME;

-- 19. 상영관과 예약 테이블을 조인하여 가격이 15000원 이상인 상영관을 예약한 고객번호와 영화제목을 조회하시오.
select r.cust_num as 고객번호, s.mov_name as 영화제목
from SCREEN s join RESERVATION r on s.TH_NUM = r.TH_NUM and s.SCR_NUM = r.SCR_NUM
where s.price >= 15000;
-- 결과값 없음

-- 20. 극장, 상영관, 예약, 고객 테이블을 조인하여 고객별 총 예약 횟수와 이름을 조회하시오.
select c.cust_name as 고객명, count(r.res_date) as 예약횟수
from THEATER t join SCREEN s on t.TH_NUM = s.th_num
join RESERVATION r on s.th_num = r.TH_NUM and s.scr_num = r.SCR_NUM
join s_CUSTOMER c on r.CUST_NUM = c.CUST_NUM
GROUP BY c.CUST_NAME;


-- =========================================================================
-- [부속질의]
-- 21. 예약 테이블에서 가장 많은 예약이 발생한 극장번호를 조회하시오.
SELECT th_num AS 극장번호
FROM RESERVATION
GROUP BY th_num
HAVING COUNT(*) = (
    SELECT MAX(COUNT(*))
    FROM RESERVATION
    GROUP BY th_num
);

-- 22. 고객 테이블에서 예약 테이블에 예약 기록이 있는 고객의 이름과 주소를 조회하시오. (IN 사용)
select cust_name as 고객명, cust_loc as 고객주소
from S_Customer
where cust_num IN (
    select cust_num from Reservation
);

-- 23. 극장 테이블에서 상영관이 3개 이상 등록된 극장의 극장이름을 조회하시오.
select t.th_name as 극장이름
from THEATER t
where th_num in (
    select th_num from SCREEN
    GROUP BY TH_NUM
    HAVING count(*) >= 3
);

-- 24. 상영관 테이블에서 전체 상영관 평균 가격보다 비싼 상영관의 영화제목과 가격을 조회하시오.
select MOV_NAME as 영화제목, price as 가격
from SCREEN
WHERE price > (
    select avg(price)
    from SCREEN
);

-- 25. 고객 테이블에서 예약 테이블에 예약 기록이 전혀 없는 고객의 이름을 조회하시오. (NOT IN 사용)
SELECT cust_name as 고객명
FROM S_Customer
WHERE cust_num NOT IN(
    select  CUST_NUM from RESERVATION
);
-- 결과값 없음

-- 26. 극장 테이블에서 예약 테이블에 예약된 적이 없는 극장의 극장이름을 조회하시오.
select th_name as 극장이름
from THEATER
where th_num not in (
    select th_num from RESERVATION
);
-- 결과값 없음

-- 27. 예약 테이블에서 예약 횟수가 전체 고객 평균 예약 횟수보다 많은 고객번호를 조회하시오.
select cust_num as 고객번호
from RESERVATION
group by CUST_NUM
HAVING count(*) > (
    select avg(count(*))
    from RESERVATION
    GROUP by cust_num
);
-- 결과값 없음

-- 28. 상영관 테이블에서 좌석수가 가장 적은 상영관이 속한 극장의 극장이름을 조회하시오.
select th_name as 극장이름
from THEATER
where th_num in (
    select th_num
    from SCREEN
    where SCREEN.SEAT_CNT = (
        select min(SCREEN.SEAT_CNT)
        from SCREEN
    )
);

-- 29. 예약 테이블에서 '2024-01-01'에 예약이 발생한 상영관의 영화제목을 조회하시오.
select mov_name as 영화제목
from SCREEN
where (th_num, scr_num) in(
    select th_num, scr_num
    from RESERVATION
    where res_date in (
    select res_date from RESERVATION
    where RESERVATION.RES_DATE = to_date('2024-01-01','YYYY-MM-DD')
    )
);
-- 결과값 없음

-- 30. 고객 테이블에서 두 번 이상 예약한 고객의 이름을 조회하시오.
select cust_name as 고객명
from S_CUSTOMER
where cust_num in (
    select cust_num from RESERVATION
    group by cust_num
    HAVING count(*) >= 2
);

-- =========================================================================
-- [상관부속질의]
-- 31. 고객 테이블에서 예약 테이블에 본인 고객번호로 예약 기록이 존재하는 고객의 이름을 조회하시오. (EXISTS 사용)
select cust_name as 고객명
from S_CUSTOMER
where cust_num in (
    select c.cust_num from RESERVATION r, S_CUSTOMER c
    where r.CUST_NUM = c.CUST_NUM
);

select cust_name as 고객명
from S_CUSTOMER c
where EXISTS (
    select * from RESERVATION r
    where r.CUST_NUM = c.CUST_NUM
);

-- 32. 상영관 테이블에서 같은 극장 내 상영관들의 평균 가격보다 비싼 상영관의 영화제목과 가격을 조회하시오.
select s1.mov_name as 영화제목, price as 가격
from SCREEN s1
where price > (
    select avg(price)
    from SCREEN s2
    where s2.th_num = s1.th_num
);

-- 33. 극장 테이블에서 해당 극장에 예약된 건수가 5건 이상인 극장의 극장이름을 조회하시오.
select th_name as 극장이름
from THEATER
where th_num in (
    select r.th_num
    from RESERVATION r
    GROUP by r.th_num
    HAVING count(r.th_num) >= 5
);
-- 결과값 없음

-- 34. 고객 테이블에서 예약 테이블에 본인 고객번호로 예약한 좌석번호가 'A1'인 기록이 존재하는 고객의 이름을 조회하시오.
select c1.cust_name as 고객명
from S_CUSTOMER c1
where EXISTS (
    select 1
    from RESERVATION r
    where r.CUST_NUM = c1.CUST_NUM and r.SEAT_NUM = 'A1'
);
-- 좌석번호 'A1'은 없음
-- 결과값 없음

-- 35. 상영관 테이블에서 해당 상영관에 예약된 기록이 하나도 없는 상영관의 영화제목을 조회하시오. (NOT EXISTS 사용)
select s.mov_name as 영화제목
from SCREEN s
where not EXISTS (
    select 1
    from RESERVATION r
    where s.SCR_NUM = r.SCR_NUM and s.TH_NUM = r.TH_NUM
);
-- 결과값 없음

-- 36. 예약 테이블에서 같은 고객이 동일 날짜에 두 건 이상 예약한 고객번호와 날짜를 조회하시오.
select cust_num as 고객번호, res_date as 날짜
from Reservation
GROUP by cust_num, res_date
HAVING count(*) >= 2;
-- 결과값 없음

-- 37. 극장 테이블에서 소속된 모든 상영관의 가격이 10000원 이상인 극장의 극장이름을 조회하시오. (NOT EXISTS 활용)
select t.th_name as 극장이름
from THEATER t
where not EXISTS(
    select 1 from SCREEN s
    where s.th_num = t.TH_NUM and s.price < 10000
);

-- 38. 고객 테이블에서 예약 테이블에 서로 다른 극장에 2곳 이상 예약한 고객의 이름을 조회하시오.
select cust_name as 고객명
from S_CUSTOMER
where cust_num in (
    select cust_num
    from RESERVATION
    GROUP by cust_num
    HAVING count(DISTINCT th_num) >= 2
);

-- 39. 상영관 테이블에서 같은 극장 내에서 좌석수가 가장 많은 상영관의 영화제목을 조회하시오.
select s1.mov_name as 영화제목
from Screen s1
where s1.SEAT_CNT = (
    select max(s2.seat_cnt)
    from SCREEN s2
    where s2.TH_NUM = s1.th_num
);

-- 40. 고객 테이블에서 가장 최근 날짜에 예약한 고객의 이름을 조회하시오.
select cust_num as 고객명
from S_CUSTOMER
where cust_num in (
    select CUST_NUM
    from RESERVATION
    where res_date = (
        select max(res_date)
        from RESERVATION
    )
);