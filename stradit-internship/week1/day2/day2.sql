create database vaishnavi;
use vaishnavi;

show databases;

-- 1. Create Employee Table Task Create a table named employees with columns:id,name,department,salary

create table Employee1
(
id Int primary key,
ename varchar(20) not null,
department varchar(20) not null,
salary Int not null
);

select * from Employee;

-- 2. Insert Data into Table Task: Insert at least 5 employee records into the employees table.

insert into Employee values(1,'neha','hr',60000);
insert into Employee values(2,'sakshi','marketing',70000);
insert into Employee values(3,'ankita','sales',80000);
insert into Employee values(4,'ekta','finance',55000);
insert into Employee values(5,'pramod','it',40000);

-- 3.3. Fetch All Records Task: Write a query to display all employee records.

select * from Employee;

-- 4. Fetch Specific Columns Task: Display only: employee name,department from the employees table.

select ename, department from Employee ;

-- 5. Filter Data using WHERE Task: Display employees who belong to the IT department.

select ename from Employee where department = 'it';