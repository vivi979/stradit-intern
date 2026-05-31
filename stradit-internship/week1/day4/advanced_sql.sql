-- Task 26 
create database ecommerce;
use ecommerce;

--  Customers Table

create table customers (
    customer_id int primary key,
    customer_name varchar(100) not null,
    email varchar(100) unique,
    phone varchar(15),
    address varchar(255)
);

-- Products Table

create table products (
    product_id int primary key,
    product_name varchar(100) not null,
    category varchar(50),
    price decimal(10,2) not null,
    stock int
);

-- Orders Table

create table orders (
    order_id int primary key,
    customer_id int,
    order_date date,
    total_amount decimal(10,2),
    foreign key (customer_id)
        references customers(customer_id)
);

-- Payments Table

create table payments (
    payment_id int primary key,
    order_id int,
    payment_date date,
    payment_method varchar(50),
    amount decimal(10,2),
    foreign key (order_id)
        references orders(order_id)
);

insert into customers values
(1,'Amit Sharma','amit@gmail.com','9876543210','Mumbai'),
(2,'Priya Patel','priya@gmail.com','9876543211','Delhi'),
(3,'Rahul Verma','rahul@gmail.com','9876543212','Pune'),
(4,'Sneha Joshi','sneha@gmail.com','9876543213','Bangalore'),
(5,'Arjun Singh','arjun@gmail.com','9876543214','Hyderabad'),
(6,'Neha Gupta','neha@gmail.com','9876543215','Chennai'),
(7,'Rohan Mehta','rohan@gmail.com','9876543216','Kolkata'),
(8,'Kavita Rao','kavita@gmail.com','9876543217','Jaipur'),
(9,'Vikas Kumar','vikas@gmail.com','9876543218','Lucknow'),
(10,'Anjali Desai','anjali@gmail.com','9876543219','Ahmedabad');

insert into products values
(101,'Laptop','Electronics',55000.00,50),
(102,'Mobile','Electronics',25000.00,100),
(103,'Headphones','Accessories',2000.00,150),
(104,'Keyboard','Accessories',1500.00,80),
(105,'Mouse','Accessories',800.00,120),
(106,'Smart Watch','Wearables',5000.00,70),
(107,'Tablet','Electronics',18000.00,60),
(108,'Printer','Electronics',7000.00,40),
(109,'Speaker','Accessories',3000.00,90),
(110,'Monitor','Electronics',12000.00,30);

insert into orders values
(1001,1,'2025-01-05',55000.00),
(1002,2,'2025-01-10',25000.00),
(1003,3,'2025-01-15',2000.00),
(1004,4,'2025-02-01',1500.00),
(1005,5,'2025-02-05',800.00),
(1006,6,'2025-02-10',5000.00),
(1007,7,'2025-03-01',18000.00),
(1008,8,'2025-03-05',7000.00),
(1009,9,'2025-03-10',3000.00),
(1010,10,'2025-03-15',12000.00);

insert into payments values
(5001,1001,'2025-01-05','Credit Card',55000.00),
(5002,1002,'2025-01-10','UPI',25000.00),
(5003,1003,'2025-01-15','Debit Card',2000.00),
(5004,1004,'2025-02-01','Net Banking',1500.00),
(5005,1005,'2025-02-05','UPI',800.00),
(5006,1006,'2025-02-10','Credit Card',5000.00),
(5007,1007,'2025-03-01','Debit Card',18000.00),
(5008,1008,'2025-03-05','UPI',7000.00),
(5009,1009,'2025-03-10','Net Banking',3000.00),
(5010,1010,'2025-03-15','Credit Card',12000.00);

-- Task 27 — Monthly Sales Report

select
    monthname(order_date) as month,
    sum(total_amount) as total_sales
from orders
group by month(order_date), monthname(order_date)
order by month(order_date);

-- Task 28 : Top Selling Product
select product_id, product_name, stock
from products
order by stock desc
limit 1;

-- Task 29 : Customers with No Orders
select c.customer_id,
       c.customer_name
from customers c
left join orders o
on c.customer_id = o.customer_id
where o.order_id is null;

-- Task 30 : Total Revenue by Category

select p.category,
       sum(p.price) as total_revenue
from products p
group by p.category;

-- Task 31 : Running Total Using Window Function

create table sales (
    sale_id int primary key,
    sale_date date,
    amount decimal(10,2)
);

insert into sales values
(1,'2025-01-01',10000),
(2,'2025-01-05',15000),
(3,'2025-01-10',20000),
(4,'2025-01-15',12000),
(5,'2025-01-20',18000);

select
    sale_id,
    sale_date,
    amount,
    sum(amount) over(order by sale_date) as running_total
from sales;

-- Task 32 : Rank Employees by Salary

create table employees (
    emp_id int primary key,
    emp_name varchar(100),
    department varchar(50),
    salary decimal(10,2)
);

insert into employees values
(1,'Amit','IT',70000),
(2,'Priya','HR',60000),
(3,'Rahul','Finance',80000),
(4,'Sneha','IT',75000),
(5,'Arjun','Sales',65000);

select
    emp_id,
    emp_name,
    salary,
    rank() over(order by salary desc) as salary_rank
from employees;

-- Task 33 — Find Duplicate Records

create table employee (
    emp_id int primary key,
    emp_name varchar(100),
    email varchar(100),
    department varchar(50)
);

insert into employee values
(1,'Amit Sharma','amit@gmail.com','IT'),
(2,'Priya Patel','priya@gmail.com','HR'),
(3,'Rahul Verma','rahul@gmail.com','Finance'),
(4,'Sneha Joshi','sneha@gmail.com','IT'),
(5,'Arjun Singh','arjun@gmail.com','Sales'),
(6,'Neha Gupta','priya@gmail.com','HR'),
(7,'Rohan Mehta','rohan@gmail.com','IT'),
(8,'Kavita Rao','amit@gmail.com','Marketing'),
(9,'Vikas Kumar','vikas@gmail.com','Finance'),
(10,'Anjali Desai','anjali@gmail.com','Sales');

select
    email,
    count(*) as duplicate_count
from employee
group by email
having count(*) > 1;

-- Task 34 : Stored Procedure Problem

create table employees1 (
    emp_id int primary key,
    emp_name varchar(100),
    department varchar(50),
    salary decimal(10,2)
);

delimiter //

create procedure add_employee(
    in p_emp_id int,
    in p_emp_name varchar(100),
    in p_department varchar(50),
    in p_salary decimal(10,2)
)
begin

    if p_salary <= 0 then
        select 'Invalid Salary! Salary must be greater than 0' as message;
    else
        insert into employees1
        values (p_emp_id, p_emp_name, p_department, p_salary);

        select 'Employee inserted successfully' as message;
    end if;

end //

delimiter ;

call add_employee(1,'Amit Sharma','IT',50000);

call add_employee(2,'Priya Patel','HR',-10000);

select * from employees1;

-- Task 35 : Transaction Management

create table accounts (
    account_id int primary key,
    account_holder varchar(100),
    balance decimal(10,2)
);

insert into accounts values
(101,'Amit Sharma',50000),
(102,'Priya Patel',30000);

-- deduct balance from one account

start transaction;
update accounts
set balance = balance - 10000
where account_id = 101;

-- add balance to another account

update accounts
set balance = balance + 10000
where account_id = 102;
commit;



