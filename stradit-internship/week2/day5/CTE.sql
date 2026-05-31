-- Task 1: Basic Employee Filtering
create database company;
use company;

create table employees(
emp_id int,
emp_name varchar(50),
department varchar(20),
salary int
);

insert into employees values
(1,'Rahul','IT',60000),
(2,'Amit','HR',45000),
(3,'Sneha','Finance',70000);

--Create a CTE for employees earning above ₹50,000
with high_salary as (
    select *
    from employees
    where salary > 50000
)
-- Display filtered employee details
select * from high_salary;

-- Task 2 : Department-wise Average Salary

with dept_avg as (
    select department,
           avg(salary) as avg_salary
    from employees
    group by department
)
select *
from dept_avg
where avg_salary > 45000;

-- Task 3 : Top Performing Students

create table students(
student_id int,
student_name varchar(50),
marks int
);

insert into students values
(1,'Asha',90),
(2,'Ravi',75),
(3,'Tina',85);

with avg_marks as (
    select avg(marks) as class_avg
    from students
)
select *
from students
where marks >
(
    select class_avg
    from avg_marks
);

-- Task 4 : Monthly Sales Summary

create table sales(
month varchar(10),
sales_amount int
);

insert into sales values
('Jan',10000),
('Jan',15000),
('Feb',20000);

with monthly_total as (
    select month,
           sum(sales_amount) as total_sales
    from sales
    group by month
)
select *
from monthly_total
order by total_sales desc
limit 1;

-- Task 5 : Customer Purchase Analysis

create table orders(
customer_id int,
order_amount int
);

insert into orders values
(1,5000),
(2,8000),
(3,3000);

with avg_order as (
    select avg(order_amount) as avg_amt
    from orders
)
select *
from orders
where order_amount >
(
    select avg_amt
    from avg_order
);

-- Task 6 : Multi-CTE Query

create table sales1(
product varchar(50),
sales int
);

insert into sales1 values
('Laptop',50000),
('Mouse',5000),
('Keyboard',8000);

with total_sales as (
    select sum(sales) as total_sale
    from sales1
),
avg_sales as (
    select avg(sales) as avg_sale
    from sales1
),
highest_sales as (
    select max(sales) as max_sale
    from sales1
)

select *
from total_sales,
     avg_sales,
     highest_sales;
     
-- Task 7 : Employee Salary Ranking
with salary_rank as (
select *,
rank() over(
partition by department
order by salary desc
) as rnk
from employees
)

select *
from salary_rank
where rnk <= 2;

-- Task 8 : Product Sales Trend

create table monthly_sales(
month varchar(10),
sales int
);

insert into monthly_sales values
('Jan',10000),
('Feb',12000),
('Mar',9000);

with sales_cte as (
select month,
sales,
lag(sales) over(order by month) as prev_sales
from monthly_sales
)

select *,
round(
((sales-prev_sales)/prev_sales)*100,
2
) as growth_percent
from sales_cte;

-- Task 9 : Banking Transaction Analysis

create table transactions(
txn_id int,
account_no varchar(20),
amount int
);

insert into transactions values
(1,'A101',10000),
(2,'A102',50000),
(3,'A103',2000);

with avg_txn as (
select avg(amount) as avg_amount
from transactions
)

select *
from transactions
where amount >
(
select avg_amount
from avg_txn
);

-- Task 10 : Duplicate Record Detection

create table employee_records(
emp_id int,
emp_name varchar(50),
department varchar(20)
);

insert into employee_records values
(1,'Rahul','IT'),
(1,'Rahul','IT'),
(2,'Amit','HR');

with duplicate_cte as (
select *,
row_number() over(
partition by emp_id,emp_name,department
order by emp_id
) as rn
from employee_records
)

select *
from duplicate_cte
where rn > 1;