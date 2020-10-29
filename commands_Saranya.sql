-- activity 1
create database Saranya_Activities;

use Saranya_Activities;

select * from customers;

SELECT * FROM customers WHERE salesman_id > (SELECT salesman_id FROM customers);

Create table salesman1(salesman_id int ,name varchar(20),city varchar(20),commission int);

describe salesman;

-- end of actiivty 1

-- Activity 2
insert into salesman(salesman_id,name,city,commission) values('5001','James Hoog','New York','15');

insert into salesman values('5002','Nail Knite','Paris','13');

insert into salesman values('5005','Pit Alex','London','11');

insert into salesman values('5006','McLyon','Paris','14');

insert into salesman values('5007','Paul Adam','Rome','13');

insert into salesman values('5003','Lauson Hen','San Jose','12');


Select * from salesman;
-- End of Activity 2

-- Activity 3
Select salesman_id,city from salesman;

Select * from salesman where city='Paris';

Select salesman_id,commission from salesman where name='Paul Adam';

update salesman set name='Paul Adam' where salesman_id='5007';
-- end of activity 3

-- Activity 4
Alter table salesman add grade int;

update salesman set grade='100' where salesman_id is not null;

-- Activity 5

update salesman set grade='200' where city='Rome';

update salesman set grade='300' where name='James Hoog';

update salesman set name='Pierre' where name='McLyon';

select * from salesman;

-- Acitivy 6
-- Create a table named orders
create table orders(
    order_no int primary key, purchase_amount float, order_date date,
    customer_id int, salesman_id int);

-- Add values to the table
insert into orders values
(70001, 150.5, '2012-10-05', 3005, 5002), (70009, 270.65, '2012-09-10', 3001, 5005),
(70002, 65.26, '2012-10-05', 3002, 5001), (70004, 110.5, '2012-08-17', 3009, 5003),
(70007, 948.5, '2012-09-10', 3005, 5002), (70005, 2400.6, '2012-07-27', 3007, 5001),
(70008, 5760, '2012-08-15', 3002, 5001), (70010, 1983.43, '2012-10-10', 3004, 5006),
(70003, 2480.4, '2012-10-10', 3009, 5003), (70012, 250.45, '2012-06-27', 3008, 5002),
(70011, 75.29, '2012-08-17', 3003, 5007), (70013, 3045.6, '2012-04-25', 3002, 5001);

Select distinct(salesman_id) from orders;

select order_no, order_date from orders order by order_date;

Select order_no from orders order by order_no asc;

Select order_no from orders order by purchase_amount desc;

select * from orders where purchase_amount<500;

select * from orders where purchase_amount between 1000 and 2000;

-- Activity 7
select SUM(purchase_amount) AS "Total" from orders;

select AVG(purchase_amount) AS "Average" from orders;

select MAX(purchase_amount) AS "Max value" from orders;

select MIN(purchase_amount) AS "Min value" from orders;

select COUNT(distinct salesman_id) AS "Count" from orders;

-- Acitivity 8

SELECT customer_id, MAX(purchase_amount) AS "Max Amount" FROM orders GROUP BY customer_id;

SELECT salesman_id, order_date, MAX(purchase_amount) AS "Max Amount" FROM orders 
WHERE order_date='2012-08-17' GROUP BY salesman_id, order_date;

SELECT customer_id, order_date, MAX(purchase_amount) AS "Max Amount" FROM orders
GROUP BY customer_id, order_date
HAVING MAX(purchase_amount) IN(2030, 3450, 5760, 6000);


-- Acitivy 9

SELECT a.customer_name AS "Customer Name", a.city, b.name AS "Salesman", b.commission FROM customers a 
INNER JOIN salesman b ON a.salesman_id=b.salesman_id;

SELECT a.customer_name, a.city, a.grade, b.name AS "Salesman", b.city FROM customers a 
LEFT OUTER JOIN salesman b ON a.salesman_id=b.salesman_id WHERE a.grade<300 
ORDER BY a.customer_id;


SELECT a.customer_name AS "Customer Name", a.city, b.name AS "Salesman", b.commission FROM customers a 
INNER JOIN salesman b ON a.salesman_id=b.salesman_id 
WHERE b.commission>12;


SELECT a.order_no, a.order_date, a.purchase_amount, b.customer_name AS "Customer Name", b.grade, c.name AS "Salesman", c.commission FROM orders a 
INNER JOIN customers b ON a.customer_id=b.customer_id 
INNER JOIN salesman c ON a.salesman_id=c.salesman_id;

-- Activity 10

SELECT * FROM orders
WHERE salesman_id=(SELECT DISTINCT salesman_id FROM orders WHERE customer_id=3007);


SELECT * FROM orders
WHERE salesman_id IN (SELECT salesman_id FROM salesman WHERE city='New York');


SELECT grade, COUNT(*) FROM customers
GROUP BY grade HAVING grade>(SELECT AVG(grade) FROM customers WHERE city='New York');


SELECT order_no, purchase_amount, order_date, salesman_id FROM orders
WHERE salesman_id IN( SELECT salesman_id FROM salesman
WHERE commission=( SELECT MAX(commission) FROM salesman));

-- Activiy 11
SELECT customer_id, customer_name FROM customers a
WHERE 1<(SELECT COUNT(*) FROM orders b WHERE a.customer_id = b.customer_id)
UNION
SELECT salesman_id, name FROM salesman a
WHERE 1<(SELECT COUNT(*) FROM orders b WHERE a.salesman_id = b.salesman_id)
ORDER BY customer_name;

SELECT a.salesman_id, name, order_no, 'highest on', order_date FROM salesman a, orders b
WHERE a.salesman_id=b.salesman_id
AND b.purchase_amount=(SELECT MAX(purchase_amount) FROM orders c WHERE c.order_date = b.order_date)
UNION
SELECT a.salesman_id, name, order_no, 'lowest on', order_date FROM salesman a, orders b
WHERE a.salesman_id=b.salesman_id
AND b.purchase_amount=(SELECT MIN(purchase_amount) FROM orders c WHERE c.order_date = b.order_date);

SELECT customer_id, customer_name FROM customers a
WHERE 1<(SELECT COUNT(*) FROM orders b WHERE a.customer_id = b.customer_id)
UNION
SELECT salesman_id, name FROM salesman a
WHERE 1<(SELECT COUNT(*) FROM orders b WHERE a.salesman_id = b.salesman_id)
ORDER BY customer_name;


-- SELECT s.salesman_id, s.name, o.order_no FROM salesman s FULL  JOIN orders o ON s.salesman_id = o.salesman_id;

SELECT * from salesman limit 1;

select * from orders limit 1;

SELECT  s.name,s.salesman_id FROM salesman s right outer join orders o ON o.salesman_id=s.salesman_id;

