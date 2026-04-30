-- 2026.04.29 SQL실습

/*
Book
    bookid (PK) : 도서 아이디
    bookname    : 도서명
    publisher   : 출판사
    price       : 도서 금액
    
Customer
    custid (PK) : 고객 아이디
    name        : 고객명
    address     : 고객 주소
    phone       : 고객 전화번호
    
Orders
    orderid (PK): 주문 아이디
    custid (FK) : 고객 아이디 (참조)
    bookid (FK) : 도서 아이디 (참조)
    saleprice   : 판매가격
    orderdate   : 주문일자
*/

-- SELECT/FROM
-- 질의3-1 : 모든 도서의 이름과 가격을 검색하시오.
SELECT bookname, price FROM book;

-- 질의3-2 : 모든 도서의 도서번호, 도서이름, 출판사, 가격을 검색하시오.
Select bookid, bookname, publisher, price from book;

-- 질의3-3 : 도서 테이블(Book)에 있는 모든 출판사를 검색하시오
Select publisher from book;
Select distinct publisher from book;    -- 출판사 중복제거

-- 질의3-4 : 가격이 20,000원 미만인 도서를 검색하시오.
Select * from book where price < 20000;

-- 질의3-5 : 가격이 10,000원 이상 20,000원 이하인 도서를 검색하시오
select * from book where 10000 <= price and price <= 20000;
select * from book where price between 10000 and 20000;

-- 질의3-6 : 출판사가 '굿스포츠' 또는 '대한미디어'인 도서를 검색하시오
select * from book where publisher in('굿스포츠', '대한미디어');

-- 질의3-7 : '축구의 역사'를 출간한 출판사를 검색하시오
-- select publisher from book where bookname in ('축구의 역사');
select bookname, publisher from book where bookname like '축구의 역사';

-- 질의3-8 : 도서이름에 '축구'가 포함된 출판사를 검색하시오
select bookname, publisher from book where bookname like '%축구%';

-- 질의3-9 : 도서 이름의 왼쪽 두 번째 위치에 '구'라는 문자가 포함된 도서를 검색하시오
select bookid, bookname, publisher, price from book where bookname like '_구%';

-- 질의3-10 : 축구에 관한 도서 중 가격이 20,000원 이상인 도서를 검색하시오.
select bookid, bookname, publisher, price from book where bookname like '%축구%' and price >= 20000;

-- 질의3-11 : 출판사가 '굿스포츠'혹은 '대한미디어'인 도서를 검색하시오
select bookid, bookname, publisher, price from book where publisher in ('굿스포츠', '대한미디어');
select bookid, bookname, publisher, price from book where publisher = '굿스포츠';

-- 질의3-12 : 도서를 이름순으로 검색하시오(오름차순)
select * from book order by bookname;

-- 질의3-13 : 도서를 가격순으로 검색하고, 가격이 같으면 이름순으로 검색하시오
select * from book order by price, bookname;

-- 질의3-14 : 도서를 가격의 내림차순으로 검색하시오. 가격이 같다면 출판사의 오름차순으로 출력하시오
select * from book order by price desc, publisher asc;

-- 질의3-15 : 고객이 주문한 도서의 총판매액을 구하시오
select sum(saleprice) from orders;
select sum(saleprice) as 총매출 from orders;

-- 질의3-16 : 2번 김연아 고객이 주문한 도서의 총판매액을 구하시오
select sum(saleprice) as 총판매액 from orders where custid = 2;

-- 질의3-17 : 고객이 주문한 도서의 총판매액, 평균값, 최저가, 최고가를 구하시오
select sum(saleprice) as 총판매액, avg(saleprice) as 평균값, min(saleprice) as 최저가, max(saleprice) as 최저가
from orders;

-- 질의3-18 : 마당서점의 도서 판매 건수를 구하시오
select count(*) from orders;

-- 질의3-19 : 고객별로 주문한 도서의 총수량과 총판매액을 구하시오
select count(*) as 총수량, sum(saleprice) as 총판매액 from orders group by custid;

-- 질의3-20 : 가격이 8,000원 이상인 도서를 구매한 고객 중에서, 주문 도서의 총 수량이 2권 이상인 고객을 구하시오 
select custid, count(orderid) as 주문수량 from orders where saleprice >= 8000
group by custid having count(*) >= 2
order by custid;


-- 연습문제 213p 1, 2번 문제풀이
-- 01. 다음은 마당서점 고객이 알고 싶어 하는 내용이다. 각 문항에 맞는 SQL 문을 작성하시오
-- (1) 도서번호가 1인 도서의 이름
select bookname as 도서명 from book where bookid = 1;

-- (2) 가격이 20.000원 이상인 도서의 이름
select bookname as 도서명, price as 금액 from book where price <= 20000;

-- (3) '박지성'의 총구매액
select custid, name from customer where name = '박지성';   -- 박지성 custid = 1
select sum(saleprice) as 총구매액 from orders where custid = 1;

-- (4) '박지성'이 구매한 도서의 수
select count(orderid) as 구매횟수 from orders where custid = 1;

-- (5) '박지성'이 구매한 도서의 출판사 수
select count(distinct book.publisher)
from book, orders
where orders.custid = 1 and orders.bookid = book.bookid;

-- (6) '박지성'이 구매한 도서의 이름, 가격, 정가와 판매가격의 차이
select bookname as 도서명, price as 정가, book.price - orders.saleprice as 차이금액
from book, orders
where orders.custid = 1 and orders.bookid = book.bookid;

-- (7) '박지성'이 구매하지 않은 도서의 이름
select bookname as 도서명 from book
where bookid not in (
    select bookid
    from orders
    where custid = 1
);

-- 02. 다음은 마당서점 운영자와 경영자가 알고 싶어 하는 내용이다. 각 문항에 맞는 SQL문을 작성하시오
-- (1) 마당서점 도서의 총수
select count(bookid) from book;

-- (2) 마당서점에 도서를 출고하는 출판사의 총수
select count(distinct publisher) from book;

-- (3) 모든 고객의 이름, 주소
select name as 이름, address as 주소 from customer;

-- (4) 2025년 7월 4일부터 7월 7일 사이에 주문받은 도서의 주문번호
select orderid as 주문번호 from orders
where orderdate between to_date('2025-07-04', 'yyyy-mm-dd') and to_date('2025-07-07', 'yyyy-mm-dd');

-- (5) 2025년 7월 4일부터 7월 7일 사이에 주문받은 도서를 제외한 도서의 주문번호
select orderid as 주문번호 from orders
where orderdate not in (
    select orderdate from orders
    where orderdate between to_date('2025-07-04', 'yyyy-mm-dd') and to_date('2025-07-07', 'yyyy-mm-dd')
);

-- (6) 성이 '김'씨인 고객의 이름과 주소
select name, address from customer
where name like '김%';

-- (7) 성이 '김'씨이고 이름이 '아'로 끝나는 고객의 이름과 주소
select name, address from customer
where name like '김%' and name like '%아';

-- (8) 주문하지 않은 고객의 이름(부속질의 사용)
select name from customer
where custid not in (
    select custid from orders
);

-- (9) 주문 금액의 총액과 주문의 평균 금액
select sum(saleprice) as 주문총액, avg(saleprice) as 주문평균 from orders;

-- (10) 고객의 이름과 고객별 구매액
select name as 고객명, sum(saleprice) as 구매액 from orders, customer
where orders.custid = customer.custid
group by customer.name;

-- (11) 고객의 이름과 고객이 구매한 도서 목록
select name as 이름, bookname as 도서명 from orders, customer, book
where customer.custid = orders.custid and book.bookid = orders.bookid;

-- (12) 도서의 가격(Book 테이블)과 판매가격(Orders 테이블)의 차이가 가장 많은 주문
select max((book.price) - (orders.saleprice)) from book, orders;

-- (13) 도서의 판매액 평균보다 자신의 구매액 평균이 더 높은 고객의 이름
select name
from customer c
join orders o
on o.custid = c.custid
group by c.name
having avg(o.saleprice) > (select avg(saleprice) from orders);
