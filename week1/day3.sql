create database company_db
use company_db;

show databases;

-- 2. Create Employee Table

create table employees(
employee_id Int primary key,
employee_name varchar(20) not null,
department varchar(20) not null,
salary Int check (salary > 0),
joining_date date
);

-- 3. Insert Employee Records

insert into employees values
(11,'vaishnavi','finance',700000,'2026-02-09'),
(2,'aarya','marketing',60000,'2026-12-17'),
(3,'ekta','it',700000,'2026-02-09'),
(4,'pavan','sales',700000,'2026-02-09'),
(5,'sakshi','hr',700000,'2026-02-09'),
(6,'anisha','insurance',700000,'2026-02-09'),
(7,'megha','marketing',700000,'2026-02-09'),
(8,'pramod','it',700000,'2026-02-09'),
(9,'abhilasha','finance',700000,'2026-02-09'),
(10,'ankita','hr',700000,'2026-02-09')
;

delete from employees where employee_id = 1;

-- 4. Display All Employees

select * from employees;

-- 5. Display Specific Columns

select employee_name, salary from employees ;

-- 6. Filter Employees by Department Problem : Display employees who belong to: IT department

select employee_name, department from employees where department = 'it';

-- 7. Filter Employees by Salary

select employee_name, salary from employees where salary>50000;

-- 8. Sort Employee Data 

select * from employees order by salary asc;
select * from employees order by salary desc;

-- 9. Find Total Number of Employees 

select count(employee_id) as total from employees;

-- 10. Find Highest Salary

select max(salary) as max_salary from employees;

-- 11. Find Lowest Salary 

select min(salary) as min_salary from employees;

-- 12. Calculate Average Salary 

select avg(salary) as average from employees;

-- 13. Group Employees by Department

select department, count(employee_id) as count from employees group by department;

-- 14. Find Department-wise Average Salary

select department, avg(salary) as avg_salary from employees group by department;

-- 15. Update Employee Salary

SET SQL_SAFE_UPDATES = 0;

update employees
set salary = salary * 1.10
where department = 'it';

-- 16. Delete Employee Record

delete from employees where employee_id = 5;

-- 17. Employyes start with 'A' and ends with 'n'

select * from employees where employee_name like 'a%';
select * from employees where employee_name like '%n';

-- 18 employees whose salary is between: 40000 and 70000

select * from employees where salary between 40000 and 70000;