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
--LEFT JOIN
--Get order id and order name for the companies in my_companies table
SELECT mc.company_name, o.order_id, o.order_date 
FROM my_companies mc LEFT JOIN orders o
ON o.company_id = mc.company_id;
​
--RIGHT JOIN
--Get order id and order name for the companies in orders table
--1.Way
SELECT mc.company_name, o.order_id, o.order_date 
FROM my_companies mc RIGHT JOIN orders o
ON o.company_id = mc.company_id;
--2.Way
SELECT mc.company_name, o.order_id, o.order_date 
FROM orders o LEFT JOIN my_companies mc
ON o.company_id = mc.company_id;
​
--FULL JOIN
--Get order id and order name for every company
SELECT mc.company_name, o.order_id, o.order_date 
FROM orders o FULL JOIN my_companies mc
ON o.company_id = mc.company_id;
​
--SELF JOIN
CREATE TABLE workers 
(  
  id number(2), 
  name varchar2(20),
  title varchar2(60),
  manager_id number(2) 
);
​
INSERT INTO workers VALUES(1, 'Ali Can', 'SDET', 2);
INSERT INTO workers VALUES(2, 'John Walker', 'QA', 3);
INSERT INTO workers VALUES(3, 'Angie Star', 'QA Lead', 4);
INSERT INTO workers VALUES(4, 'Amy Sky', 'CEO', 5);
​
SELECT * FROM workers;
​
​
--Create a table which displays the manager of employees
SELECT m1.name AS "Employee Name", m2.name AS "Manager Name"
FROM workers m1 INNER JOIN workers m2
ON m1.manager_id = m2.id;
​
--ALTER TABLE
--1) We can add a column to an existing table
ALTER TABLE my_companies
ADD company_address VARCHAR2(80);
​
UPDATE my_companies
SET company_address = 'Austin Texas'
WHERE company_id = 100;
​
--How to add a field with default value
ALTER TABLE my_companies
ADD company_profession VARCHAR2(20) DEFAULT 'IT';
​
--How to add multiple fields into a table
ALTER TABLE my_companies
ADD (company_ceo VARCHAR2(50),
     number_workers NUMBER(5) DEFAULT 0);
     
--2)How to drop fields from a table
ALTER TABLE my_companies
DROP COLUMN company_ceo;
​
--3)How to rename a field/column
ALTER TABLE my_companies
RENAME COLUMN company_profession TO company_industry;
​
--4)How to rename table
ALTER TABLE my_companies
RENAME TO our_companies;
​
--5)How to modify(Add constraints, change data type, change the size) a field
​
--How to add constraint
ALTER TABLE our_companies
MODIFY number_workers NUMBER(5) NOT NULL;
​
--How to change data type
​
--Make all data in company_address field null
--Note:To change data type of a field, all data in the field must be null. Otherwise SQL does not let you to change data type
UPDATE our_companies
SET company_address = null;
​
ALTER TABLE our_companies
MODIFY company_address CHAR(20);
​
--How to change size of data type
ALTER TABLE our_companies
MODIFY company_address CHAR(50);
​
--If you want to change the size, new size must be greater than the greatest size of existing data
ALTER TABLE our_companies
MODIFY company_industry VARCHAR2(10);
​
​
SELECT * FROM  our_companies;
​
--How to create a function in SQL
​
--We create functions in SQL to do some tasks faster. Like calculation GPA ...
--We create functions to do SELECT, INSERT, DELETE, UPDATE tasks faster
​
--In Java some methods may not return any value but in SQL all functions must return data.
--If sth like function does not return data, it is called "Procedure"
​
--Create a function to add 2 numbers
CREATE OR REPLACE FUNCTION addf(a NUMBER, b NUMBER) RETURN NUMBER IS
BEGIN
    RETURN a+b;
END;
​
--1.Way to call a function
SELECT addf(12, 13) FROM DUAL;
​
--2.Way to call a function
EXECUTE DBMS_OUTPUT.PUT_LINE('The sum is ' || addf(12, 13));
​
--3.Way to call a function
VARIABLE RESULT NUMBER
​
EXECUTE :RESULT := addf(12, 13);
​
PRINT RESULT;
​
--Get two numbers and operation sign from user then print the result 
DECLARE
    a NUMBER := '&First_number';
    b NUMBER := '&Second_number';
    c CHAR := '&Operation_sign';
    
FUNCTION calculatorf(a NUMBER, b NUMBER, c CHAR) RETURN NUMBER IS
BEGIN
    IF c = '+' THEN RETURN a+b;
    ELSIF c = '-' THEN RETURN a-b;
    ELSIF c = '*' THEN RETURN a*b;
    ELSIF c = '/' THEN RETURN a/b;
    ELSE DBMS_OUTPUT.PUT_LINE('I told you to select one of the +, -, *, /');
         RETURN 0;
    END IF;
END;
​
BEGIN 
    DBMS_OUTPUT.PUT_LINE(a || c || b || ' = ' || calculatorf(a, b, c));
END;
​
--Create a table insert name and age, and insertion date, and user name into table for every record.
CREATE TABLE students(
    std_name VARCHAR2(50),
    std_age NUMBER(3),
    insertion_date DATE,
    inserter VARCHAR2(50)
);
​
DECLARE 
​
    current_date DATE;
    inserter VARCHAR2(50);
    std_name VARCHAR2(50);
    std_age NUMBER(3);
    
BEGIN 
​
    SELECT sysdate, user
    INTO current_date, inserter
    FROM DUAL;
    
    std_name := '&student_name';
    std_age := '&student_age';
​
    INSERT INTO students VALUES(std_name, std_age, current_date, inserter);
    
END;
​
SELECT * FROM students;