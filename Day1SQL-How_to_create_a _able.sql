--How to create table

--1.Way:Create table from scratch
CREATE TABLE students
(
	student_id CHAR(3),
	student_name VARCHAR2(50),
	student_age NUMBER(2),
	student_dob DATE
);

--2.Way:Create table by using another table
CREATE TABLE student_name_age
AS SELECT student_name, student_age
FROM students;

SELECT * FROM students;

SELECT * FROM student_name_age;

--While we create a table, we can put some "Constraints" for fields 
--Constraints: 
--a)Unique 
--b)Not Null
--c)Primary Key 
--d)Foreign Key
--e)Check Constraint
--There are 2 ways to create Primary Key
--1.Way to create Primary Key
CREATE TABLE students
(
	student_id CHAR(3) PRIMARY KEY,--student_id cannot have repeated data, cannot have null value, because it is Primary Key
	student_name VARCHAR2(50) NOT NULL,--student_name will not have null as data
	student_age NUMBER(2),
	student_dob DATE UNIQUE--student_id is unique key ==> Data different from null must be unique, you can have multiple null
);
--2.Way to create Primary Key
CREATE TABLE students
(
	student_id CHAR(3),
	student_name VARCHAR2(50),
	student_age NUMBER(2),
	student_dob DATE,
	CONSTRAINT student_id_pk PRIMARY KEY(student_id)
);

--How to add Foreign Key Constraint
CREATE TABLE parents
(
	student_id CHAR(3),
	parent_name VARCHAR2(50),
	phone_number CHAR(10),
	CONSTRAINT student_id_pk PRIMARY KEY(student_id)
);

CREATE TABLE students
(
	student_id CHAR(3),
	student_name VARCHAR2(50),
	student_age NUMBER(2),
	student_dob DATE,
	CONSTRAINT student_id_fk1 FOREIGN KEY(student_id) REFERENCES parents(student_id)
);

--How to add "Check" constraint
CREATE TABLE students
(
	student_id CHAR(3),
	student_name VARCHAR2(50),
	student_age NUMBER(2),
	student_dob DATE,
	CONSTRAINT student_age_check CHECK(student_age BETWEEN 0 AND 30),
	CONSTRAINT student_name_upper_case CHECK(student_name = upper(student_name))
);

--How to Insert Data into a Table
CREATE TABLE students
(
	student_id CHAR(3) PRIMARY KEY,
	student_name VARCHAR2(50) UNIQUE,
	student_age NUMBER(2) NOT NULL,
	student_dob DATE,
	CONSTRAINT student_age_check CHECK(student_age BETWEEN 0 AND 30),-- 0 and 30 are included
	CONSTRAINT student_name_upper_case CHECK(student_name = upper(student_name))
);

--1.Way:Insert data for all fields
INSERT INTO students VALUES('101', 'ALI CAN', 13, '10-Aug-2021');
INSERT INTO students VALUES('102', 'VELI HAN', 14, '10-Aug-2007');
--For CHAR we use single quotes but if you do not use it works as well
INSERT INTO students VALUES(103, 'AYSE TAN', 14, '08-Aug-2007');
INSERT INTO students VALUES(104, 'KEMAL KUZU', 15, null);
--For VARCHAR2 you have to use single quote
INSERT INTO students VALUES('105', 'TOM HANKS', 25, '12-Sep-1996');

INSERT INTO students VALUES('106', 'ANGELINA JULIE', 30, '12-Sep-1986');
INSERT INTO students VALUES('107', 'BRAD PITT', 0, '10-Aug-2021');

--2.Way:How to insert data for specific fields
INSERT INTO students(student_id, student_age) VALUES('108', 17);
INSERT INTO students(student_name, student_id, student_age) VALUES('JOHN WALKER', '109', 24);

--How to update existing data
UPDATE students
SET student_name = 'LEO OCEAN'
WHERE student_id = '108';

--Update the dob of John Walker to 11-Dec-1997
UPDATE students
SET student_dob = '11-Dec-1997'
WHERE student_id = '109';

--How to update multiple cell
--Update the dob of 105 to 11-Apr-1996 and name to TOM HANKS
UPDATE students
SET student_dob = '11-Apr-1996',
	student_name = 'TOM HANKS'
WHERE student_id = '105';

--How to update multiple records
--Make the dob of all students 01-Aug-2021 if their ids are less than 106
UPDATE students
SET student_dob = '01-Aug-2021'
WHERE student_id < 106;

--Update all students' age to the maximum age
UPDATE students
SET student_age = (SELECT MAX(student_age) FROM students);

--Update all students' dob to the minimum dob
UPDATE students
SET student_dob = (SELECT MIN(student_dob) FROM students);


SELECT * FROM students;