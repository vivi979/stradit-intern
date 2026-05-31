use company_db;

-- 1. employee table

create table employee(
emp_id Int primary key,
emp_name varchar(20) not null,
department varchar(20) not null,
salary decimal(10,2) check (salary >=0),
joining_date date);

-- 2. Insert 

insert into employee values
(1, 'Rahul', 'IT', 50000,'2026-04-08'),
(2, 'Priya', 'HR', 45000,'2025-11-22'),
(3, 'Amit', 'Finance', 70000,'2025-06-17');

-- 3. Fetch employee details

select * from employee;

-- 4. Display specific column

select emp_name, department from employee;

-- 5. employees with high salary

select * from employee where salary > 50000;

-- 6. employees from it department

select * from employee where department = 'IT';

-- 7. sort employee salaries

select * from employee order by salary asc; -- ascending order
select * from employee order by salary desc; -- descending order

-- 8. update employee salary

SET SQL_SAFE_UPDATES = 0;

update employee
set salary = 60000
where emp_name = 'Rahul';

-- 9. delete employee records

delete from employee where emp_id = 2;

-- 10. count employees

select count(*) as total_employees from employee;

-- 11. Avg salary by department

select department, avg(salary) as avg_salary from employee group by department;

-- 12. Highest paid employee

select * from employee where salary = (select max(salary) from employee);

-- 13.second highest salary 

select max(salary) as second_high_salary from employee where salary < (select max(salary) from employee);

-- 14. Employees join after 2023

select * from employee where joining_date > '2023-01-01';

-- 15. Duplicate department

select department, count(*) as total from employee group by department having count(*) > 1;

-- 16. group of employees by department

select department, count(*) as employee_count from employee group by department;

-- 17. department with more than 2 employees

select department, count(*) as employee_count from employee group by department having count(*) > 2;

-- 18. Employees with null salary

select * from employee where salary is NULL;

-- 19. Distinct

select distinct department from employee;

-- 20. top 3 highest salary

select * from employee order by salary desc limit 3;

-- JOINS
-- Employee table
CREATE TABLE employee1 (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    dept_id INT
);

-- Department table
CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

-- Insert Data
INSERT INTO employee1 VALUES
(1, 'Rahul', 101),
(2, 'Priya', 102);

INSERT INTO departments VALUES
(101, 'IT'),
(102, 'HR');

-- 21. inner join

select e.emp_name, d.dept_name 
from employee1 e 
inner join departments d
on e.dept_id = d.dept_id;

-- 22. left join

select e.emp_name, d.dept_name 
from employee1 e 
left join departments d
on e.dept_id = d.dept_id;

-- 23. right join

select e.emp_name, d.dept_name 
from employee1 e 
right join departments d
on e.dept_id = d.dept_id;

-- 24. Employees without department

select e.emp_name, d.dept_name 
from employee1 e 
left join departments d
on e.dept_id = d.dept_id
where d.dept_id is NULL;
