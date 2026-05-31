-- Task 1 : ROW_NUMBER() — Employee Joining Sequence

create table employees3
(
emp_id INT PRIMARY KEY,
emp_name VARCHAR(50),
department VARCHAR(50),
joining_date DATE
);

INSERT INTO employees3 (emp_id, emp_name, department, joining_date) VALUES
(101, 'Rahul', 'IT', '2023-01-10'),
(102, 'Amit', 'IT', '2023-02-15'),
(103, 'Priya', 'HR', '2023-01-05'),
(104, 'Sneha', 'HR', '2023-03-12');

-- Assign row numbers department-wise

select * , row_number() over (partition by department) as row_num from employees3;

-- Sort employees by joining date

select * , row_number() over (partition by department order by joining_date) as join_date from employees3;

-- Task 2 : RANK() — Salary Ranking

CREATE TABLE employee_salary (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(50),
    salary INT
);

INSERT INTO employee_salary (emp_id, emp_name, department, salary) VALUES
(1, 'Rahul', 'IT', 80000),
(2, 'Amit', 'IT', 75000),
(3, 'Priya', 'IT', 75000),
(4, 'Neha', 'HR', 65000);

-- Rank employees department-wise

select * , rank() over (partition by department) as dept_rank from employee_salary;

-- Handle salary ties correctly

select * , rank() over (partition by department order by salary) as sal_rank from employee_salary;

-- Task 3 : DENSE_RANK() — Student Marks Ranking

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    class VARCHAR(10),
    marks INT
);

INSERT INTO students (student_id, student_name, class, marks) VALUES
(1, 'Asha', '10A', 95),
(2, 'Ravi', '10A', 90),
(3, 'Tina', '10A', 90),
(4, 'Raj', '10A', 85);

-- Rank students by marks

select *, dense_rank() over (partition by class order by marks desc) as stud_dense_rank from students;

-- Compare RANK() vs DENSE_RANK()

select *, 
rank() over (partition by class order by marks desc) as stud_rank,
dense_rank() over (partition by class order by marks desc) as stud_dense_rank 
from students;

-- Task 4 : SUM() OVER() — Running Total Sales

CREATE TABLE sales (
    sale_date DATE,
    sales_amount INT
);

INSERT INTO sales (sale_date, sales_amount) VALUES

('2025-01-01', 5500),
('2025-01-01', 4800),
('2025-01-02', 7200),
('2025-01-02', 7100),
('2025-01-03', 6300),
('2025-01-03', 6100),
('2025-01-04', 8200),
('2025-01-04', 7900);


-- Calculate running total of sales

select *,
sum(sales_amount) over (partition by sale_date) as total_sales from sales;

-- Show cumulative business growth

select sale_date,
sum(sales_amount) as daily_sales,
sum(sum(sales_amount)) over (order by sale_date) as cumulative_growth 
from sales
group by sale_date;

-- Taks 5 : AVG() OVER() — Moving Average

CREATE TABLE stock_prices (
    trade_date DATE,
    stock_price INT
);

INSERT INTO stock_prices (trade_date, stock_price) VALUES
('2025-01-10', 123),
('2025-01-05', 118),
('2025-01-03', 112),  
('2025-01-03', 108),   
('2025-01-08', 122),
('2025-01-02', 107),  
('2025-01-12', 130),
('2025-01-07', 117),
('2025-01-05', 119),
('2025-01-10', 125);


-- Calculate moving average and Compare actual price vs average

select * ,
round(avg(stock_price) over (partition by trade_date)) as stock_avg from stock_prices;

-- Task : LAG() — Previous Day Comparison

CREATE TABLE daily_sales1 (
    sale_date DATE,
    sales INT
);

INSERT INTO daily_sales1 (sale_date, sales) VALUES
('2025-01-05', 7200),
('2025-01-06', 8000),
('2025-01-07', 7800),
('2025-01-08', 8500),
('2025-01-09', 8700),
('2025-01-10', 9200),
('2025-01-11', 8800),
('2025-01-12', 9400),
('2025-01-13', 9100),
('2025-01-14', 9700);

INSERT INTO daily_sales1 (sale_date, sales) VALUES
('2025-01-05', 7500),
('2025-01-06', 8200),
('2025-01-07', 7600),
('2025-01-08', 8300),
('2025-01-09', 8900),
('2025-01-10', 9100),
('2025-01-11', 8700),
('2025-01-12', 9600),
('2025-01-13', 9300),
('2025-01-14', 9800);


-- Fetch previous day's sales

select *,
lag(sales) over (partition by sale_date) as previous_sal_amt from daily_sales1;

-- Calculate daily sales difference

SELECT
    *,
    LAG(sales) OVER (ORDER BY sale_date) AS previous_sal_amt,
    LAG(sales) OVER (ORDER BY sale_date) - sales AS diff
FROM daily_sales1;

-- Task 7 : LEAD() — Next Day Prediction Analysis

CREATE TABLE inventory1 (
    stock_date DATE,
    quantity INT
);

INSERT INTO inventory1 (stock_date, quantity) VALUES
('2025-01-05', 110),
('2025-01-05', 150),
('2025-01-06', 105),
('2025-01-06', 110),
('2025-01-07', 98),
('2025-01-07', 130),
('2025-01-08', 130),
('2025-01-08', 170),
('2025-01-09', 125),
('2025-01-09', 100),
('2025-01-10', 115),
('2025-01-10', 170),
('2025-01-11', 108),
('2025-01-12', 120),
('2025-01-12', 135),
('2025-01-13', 160),
('2025-01-13', 128),
('2025-01-14', 90),
('2025-01-14', 140);

-- Fetch next day quantity

select *,
lead(quantity) over (partition by stock_date) as next_day from inventory1;

-- Identify stock drops

select *,
lead(quantity) over (order by stock_date) as next_day,
lead(quantity) over (order by stock_date) - quantity as drop_stock
from inventory1;

-- Task 8 : NTILE() — Customer Segmentation

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    total_purchase INT
);

INSERT INTO customers (customer_id, customer_name, total_purchase) VALUES
(5, 'Kiran', 12000),
(6, 'Meena', 12000),
(7, 'Rohit', 22000),
(8, 'Pooja', 27000),
(9, 'Ajay', 30000),
(10, 'Suresh', 30000),
(11, 'Anita', 12000),
(12, 'Vikas', 22000),
(13, 'Nisha', 27000),
(14, 'Deepak', 22000);

-- Divide customers into quartiles

select *,
ntile(4) over (order by total_purchase) as quartile from customers;

-- Identify premium customers

select * ,
ntile(4) over (order by total_purchase desc) as premium from customers;

-- Task 9 : FIRST_VALUE() — First Purchase Analysis
use company_db;

CREATE TABLE orders (
    customer_id INT,
    order_date DATE,
    product VARCHAR(50)
);

INSERT INTO orders (customer_id, order_date, product) VALUES
(1, '2025-01-01', 'Laptop'),
(1, '2025-01-05', 'Mouse'),
(2, '2025-01-03', 'Keyboard'),
(3, '2025-01-02', 'Tablet'),
(3, '2025-01-07', 'Headphones'),
(4, '2025-01-04', 'Printer'),
(4, '2025-01-08', 'Scanner'),
(5, '2025-01-05', 'Keyboard'),
(5, '2025-01-09', 'Mouse'),
(6, '2025-01-03', 'Laptop'),
(6, '2025-01-10', 'Charger'),
(1, '2025-01-07', 'Keyboard');

# Find first purchased product for every customer

select *,
first_value(product) over (partition by customer_id order by order_date) as first_purchased from orders;

-- Task 10 : LAST_VALUE() — Latest Purchase Analysis

CREATE TABLE customer_orders (
    customer_id INT,
    order_date DATE,
    product VARCHAR(50)
);

INSERT INTO customer_orders (customer_id, order_date, product) VALUES
(1, '2025-01-01', 'Laptop'),
(1, '2025-01-05', 'Mouse'),
(1, '2025-01-10', 'Monitor');
INSERT INTO customer_orders (customer_id, order_date, product) VALUES
(2, '2025-01-02', 'Keyboard'),
(2, '2025-01-06', 'Mouse'),
(2, '2025-01-12', 'Laptop'),
(3, '2025-01-03', 'Tablet'),
(3, '2025-01-07', 'Headphones'),
(4, '2025-01-04', 'Printer'),
(4, '2025-01-08', 'Scanner'),
(5, '2025-01-05', 'Monitor'),
(5, '2025-01-09', 'Keyboard');

# Identify latest purchased product

select *,
last_value(product) 
over(partition by customer_id order by order_date ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as last_purchased 
from customer_orders;

-- Task 11 : Duplicate Record Detection Using ROW_NUMBER()

CREATE TABLE transactions (
    txn_id INT PRIMARY KEY,
    account_no VARCHAR(10),
    amount INT
);

INSERT INTO transactions (txn_id, account_no, amount) VALUES
(1, 'A101', 5000),
(2, 'A101', 5000),
(3, 'A102', 7000),
(4, 'A102', 8000),
(5, 'A103', 6000),
(6, 'A103', 6000),
(7, 'A104', 9000),
(8, 'A104', 8500),
(9, 'A105', 7500),
(10, 'A105', 7500),
(11, 'A106', 9200),
(12, 'A106', 8800),
(13, 'A107', 7000);

# Identify duplicate records

select *,
row_number()
over (partition by account_no) as duplicate_record
from transactions;

# Keep only latest entry
select * from (
select *,
row_number() over (partition by account_no order by txn_id desc) as latest_entry
from transactions ) t
where latest_entry = 1; 

-- Task 12 : Department-wise Highest Salary

use company_db;
create table employees2 (
    emp_name varchar(100),
    department varchar(50),
    salary int
);

insert into employees2 values
('Rahul','IT',90000),
('Amit','IT',85000),
('Priya','HR',70000),
('Sneha','HR',75000),
('Arjun','Finance',95000),
('Neha','Finance',90000),
('Rohan','Sales',80000),
('Kavita','Sales',85000);

# rank salaries

select *,
    rank() over(
        partition by department
        order by salary desc
    ) as salary_rank
from employees2;

# Extract highest salary employee

select emp_name,
       department,
       salary
from (
    select emp_name,
           department,
           salary,
           rank() over(
               partition by department
               order by salary desc
           ) as salary_rank
    from employees2
) t
where salary_rank = 1;

-- Task 13 : Consecutive Login Analysis

create table logins (
    user_id int,
    login_date date
);

insert into logins values
(1,'2025-01-01'),
(1,'2025-01-02'),
(1,'2025-01-03'),
(1,'2025-01-05'),
(2,'2025-01-01'),
(2,'2025-01-02'),
(2,'2025-01-04'),
(3,'2025-01-10'),
(3,'2025-01-11'),
(3,'2025-01-12');

# Compare current login with previous login
select
    user_id,
    login_date,
    lag(login_date) over(
        partition by user_id
        order by login_date
    ) as previous_login
from logins;

# Identify consecutive login streaks
select
    user_id,
    login_date,
    lag(login_date) over(
        partition by user_id
        order by login_date
    ) as previous_login,
    case
        when datediff(
            login_date,
            lag(login_date) over(
                partition by user_id
                order by login_date
            )
        ) = 1
        then 'Consecutive Login'
        else 'Not Consecutive'
    end as login_status
from logins;

-- Task 14. Product Sales Trend Analysis
create table monthly_sales (
    month_name varchar(10),
    sales int
);

insert into monthly_sales values
('Jan',10000),
('Feb',12000),
('Mar',9000),
('Apr',15000),
('May',18000),
('Jun',16000);

# Compare month-over-month sales
select
    month_name,
    sales,
    lag(sales) over(order by
        case month_name
            when 'Jan' then 1
            when 'Feb' then 2
            when 'Mar' then 3
            when 'Apr' then 4
            when 'May' then 5
            when 'Jun' then 6
        end
    ) as previous_month_sales
from monthly_sales;

# Identify growth and decline
select
    month_name,
    sales,
    lag(sales) over(order by
        case month_name
            when 'Jan' then 1
            when 'Feb' then 2
            when 'Mar' then 3
            when 'Apr' then 4
            when 'May' then 5
            when 'Jun' then 6
        end
    ) as previous_month_sales,

    case
        when sales >
             lag(sales) over(order by
                case month_name
                    when 'Jan' then 1
                    when 'Feb' then 2
                    when 'Mar' then 3
                    when 'Apr' then 4
                    when 'May' then 5
                    when 'Jun' then 6
                end)
        then 'Growth'

        when sales <
             lag(sales) over(order by
                case month_name
                    when 'Jan' then 1
                    when 'Feb' then 2
                    when 'Mar' then 3
                    when 'Apr' then 4
                    when 'May' then 5
                    when 'Jun' then 6
                end)
        then 'Decline'

        else 'No Change'
    end as trend
from monthly_sales;

# Task 15. Hospital Patient Visit Tracking
create table visits (
    patient_id int,
    visit_date date
);

insert into visits values
(101,'2025-01-01'),
(101,'2025-01-15'),
(101,'2025-02-10'),
(102,'2025-01-05'),
(102,'2025-01-20'),
(103,'2025-02-01'),
(103,'2025-02-15');

#Assign visit sequence numbers
select
    patient_id,
    visit_date,
    row_number() over(
        partition by patient_id
        order by visit_date
    ) as visit_sequence
from visits;

#Calculate days between visits
select
    patient_id,
    visit_date,
    lag(visit_date) over(
        partition by patient_id
        order by visit_date
    ) as previous_visit,
    datediff(
        visit_date,
        lag(visit_date) over(
            partition by patient_id
            order by visit_date
        )
    ) as days_between_visits
from visits;