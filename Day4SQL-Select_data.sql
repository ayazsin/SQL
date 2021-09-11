CREATE TABLE employees 
(  
  employee_id number(9), 
  employee_first_name varchar2(20),
  employee_last_name varchar2(20)
);
​
INSERT INTO employees VALUES(14, 'Chris', 'Tae');
INSERT INTO employees VALUES(11, 'John', 'Walker');
INSERT INTO employees VALUES(12, 'Amy', 'Star');
INSERT INTO employees VALUES(13, 'Brad', 'Pitt');
INSERT INTO employees VALUES(15, 'Chris', 'Way');
​
SELECT * FROM employees;
​
CREATE TABLE addresses 
(  
  employee_id number(9), 
  street varchar2(20),
  city varchar2(20),
  state char(2),
  zipcode char(5)
);
​
INSERT INTO addresses VALUES(11, '32nd Star 1234', 'Miami', 'FL', '33018');
INSERT INTO addresses VALUES(12, '23rd Rain 567', 'Jacksonville', 'FL', '32256');
INSERT INTO addresses VALUES(13, '5th Snow 765', 'Hialeah', 'VA', '20121');
INSERT INTO addresses VALUES(14, '3rd Man 12', 'Weston', 'MI', '12345');
INSERT INTO addresses VALUES(15, '11th Chris 12', 'St. Johns', 'FL', '32259');
​
SELECT * FROM addresses;
​
--ALIASES
​
--How to use aliase for table names
--1)Select employee first name and state, for employee first name use "firstname" as field name and for state use "employee state" as field name
SELECT e.employee_first_name AS "Firstname", a.state AS "Employee State"
FROM employees e, addresses a
WHERE e.employee_id = a.employee_id;
​
--How to put multiple fields into a single field and use aliase for the field
--2)Get employee id use "id" as field name, get firstname and lastname put them into the same field and use "full_name" as field name
SELECT employee_id, employee_first_name || ' ' || employee_last_name AS "Full Name"
FROM employees;
​
--GROUP BY
CREATE TABLE workers 
(  
  id number(9), 
  name varchar2(50), 
  state varchar2(50), 
  salary number(20),
  company varchar2(20)
);
​
INSERT INTO workers VALUES(123456789, 'John Walker', 'Florida', 2500, 'IBM');
INSERT INTO workers VALUES(234567890, 'Brad Pitt', 'Florida', 1500, 'APPLE');
INSERT INTO workers VALUES(345678901, 'Eddie Murphy', 'Texas', 3000, 'IBM');
INSERT INTO workers VALUES(456789012, 'Eddie Murphy', 'Virginia', 1000, 'GOOGLE');
INSERT INTO workers VALUES(567890123, 'Eddie Murphy', 'Texas', 7000, 'MICROSOFT');
INSERT INTO workers VALUES(456789012, 'Brad Pitt', 'Texas', 1500, 'GOOGLE');
INSERT INTO workers VALUES(123456710, 'Mark Stone', 'Pennsylvania', 2500, 'IBM');
​
SELECT * FROM workers;
​
--3)Find the total salary for every employee
--Note: If you use "ORDER BY" together with "GROUP BY", "GROUP BY" must be first
SELECT name, SUM(salary) AS "Total Salary"
FROM workers
GROUP BY name
ORDER BY "Total Salary" DESC;
​
--4)Find the number of employees per state in descending order by employee number
SELECT state, COUNT(state) AS "Number of Workers"
FROM workers
GROUP BY state
ORDER BY "Number of Workers" DESC;
​
--5)Find the number of the employees whose salary is more than $2000 per company
--Note: If you use "WHERE" together with "GROUP BY", "WHERE" must be first
--Note: If using any count does not matter, you can use "*" instead of field name
SELECT company, COUNT(*) AS "Number of Workers"
FROM workers
WHERE salary > 2000
GROUP BY company
ORDER BY "Number of Workers" DESC;
​
--6)Find the minimum and maximum salary for every company
SELECT company, MIN(salary) AS "Minimum Salary", MAX(salary) AS "Maximum Salary"
FROM workers
GROUP BY company;
​
--HAVING CLAUSE: It is used after GROUP BY, and with "Aggregate Functions" [SUM(), MAX(), MIN(), AVG(), COUNT()]
--7)Find the total salary if total salary is greater than 2500 for every employee
--Interview Question: What is the difference between "WHERE" and "HAVING"?
--Answer: Having is used just with "Aggregate Functions", but WHERE is used with field names.
--Note: After WHERE, Aggregate Functions cannot be used....
SELECT name, SUM(salary) AS "Total Salary"
FROM workers
GROUP BY name -- After GROUP BY, definitely do not use "WHERE"
HAVING SUM(salary) > 2500;
​
--8)Find the number of employees if number of employees is more than 1 per state
SELECT state, COUNT(name) AS "Number of Employees"
FROM workers
GROUP BY state
HAVING COUNT(name) > 1;
​
--9)Find the minimum salary if it is more than 2000 for every company
SELECT company, MIN(salary) AS "Minimum Salary Greater Than 2000"
FROM workers
GROUP BY company
HAVING MIN(salary) > 2000;
​
--10)Find the maximum salary if it is less than 3000 for every state
SELECT state, MAX(salary) AS "Maximum Salary Less Than 3000"
FROM workers
GROUP BY state
HAVING MAX(salary) < 3000;
​
--UNION Operator: 1)It is used to join the result of 2 or more queries
SELECT name
FROM workers
WHERE salary > 4000
​
UNION -- UNION Operator gives unique records, if there is repeated data, it prints them just once
​
SELECT name
FROM workers
WHERE salary <2000;
​
​
--UNION ALL Operator:1)It is used to join the result of 2 or more queries
SELECT name
FROM workers
WHERE salary > 4000
​
UNION ALL-- UNION ALL Operator gives repeated records
​
SELECT name
FROM workers
WHERE salary <2000;
​
--In UNION Operator, you can use different fields but corresponding fields must have same data types
--In UNION Operator, you can use same data types in different sizes but all data must have less or equal size to the smallest size
SELECT state
FROM workers
WHERE salary > 2000
​
UNION
​
SELECT company
FROM workers
WHERE salary < 3000;
​
--INTERSECT Operator:1)It gives the common results of 2 queries
SELECT name, salary
FROM workers
WHERE salary >2000
​
INTERSECT
​
SELECT name, salary
FROM workers
WHERE salary < 4000;
​
--MINUS Operator: 1)Remove the common records then get the remaining unique records from first query
SELECT name, salary
FROM workers
WHERE salary < 3500
​
MINUS
​
SELECT name, salary
FROM workers
WHERE salary > 1600;
​
--JOINS: JOINS are used between two tables
--       1)INNER JOIN: Returns common records
--       2)LEFT JOIN: Returns all records from left table
--       3)RIGHT JOIN: Returns all records from right table
--       4)FULL JOIN: Returns all records form both of the tables
--       5)SELF JOIN:You will have a single table but you 
--                   will use it as 2 tables
​
--INNER JOIN:
CREATE TABLE my_companies 
(  
  company_id number(9), 
  company_name varchar2(20)
);
​
INSERT INTO my_companies VALUES(100, 'IBM');
INSERT INTO my_companies VALUES(101, 'GOOGLE');
INSERT INTO my_companies VALUES(102, 'MICROSOFT');
INSERT INTO my_companies VALUES(103, 'APPLE');
​
SELECT * FROM my_companies;
​
CREATE TABLE orders 
(  
  order_id number(9),
  company_id number(9), 
  order_date date
);
​
INSERT INTO orders VALUES(11, 101, '17-Apr-2020');
INSERT INTO orders VALUES(22, 102, '18-Apr-2020');
INSERT INTO orders VALUES(33, 103, '19-Apr-2020');
INSERT INTO orders VALUES(44, 104, '20-Apr-2020');
INSERT INTO orders VALUES(55, 105, '21-Apr-2020');
​
SELECT * FROM orders;
​
--Select company name, order id, order date for common companies
SELECT mc.company_name, o.order_id, o.order_date
FROM my_companies mc INNER JOIN orders o
ON o.company_id = mc.company_id;