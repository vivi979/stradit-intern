use company_db;

show databases;

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

# Assign row numbers department-wise

select * , row_number() over (partition by department) as row_num from employees3;

# Sort employees by joining date

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

# Rank employees department-wise

select * , rank() over (partition by department) as dept_rank from employee_salary;

# Handle salary ties correctly

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

# Rank students by marks

select *, dense_rank() over (partition by class order by marks desc) as stud_dense_rank from students;

# Compare RANK() vs DENSE_RANK()

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


# Calculate running total of sales

select *,
sum(sales_amount) over (partition by sale_date) as total_sales from sales;

# Show cumulative business growth

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


# Calculate moving average and Compare actual price vs average

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

INSERT INTO daily_sales1 (sale_date, sales) VALUE
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


# Fetch previous day's sales

select *,
lag(sales) over (partition by sale_date) as previous_sal_amt from daily_sales1;

# Calculate daily sales difference

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

# Fetch next day quantity

select *,
lead(quantity) over (partition by stock_date) as next_day from inventory1;

# Identify stock drops

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

# Divide customers into quartiles

select *,
ntile(4) over (order by total_purchase) as quartile from customers;

# Identify premium customers

select * ,
ntile(4) over (order by total_purchase desc) as premium from customers;

-- Task 9 : FIRST_VALUE() — First Purchase Analysis

CREATE TABLE orders (
    customer_id INT,
    order_date DATE,
    product VARCHAR(50)
);