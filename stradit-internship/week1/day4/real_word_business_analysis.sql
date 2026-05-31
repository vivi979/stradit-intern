create database scenario;

use scenario;

create table employees (
    emp_id int primary key,
    emp_name varchar(100),
    department varchar(50),
    salary decimal(10,2)
);

insert into employees values
(1,'Amit Sharma','IT',70000),
(2,'Priya Patel','HR',60000),
(3,'Rahul Verma','Finance',80000),
(4,'Sneha Joshi','IT',75000),
(5,'Arjun Singh','Sales',65000),
(6,'Neha Gupta','IT',72000),
(7,'Rohan Mehta','Marketing',55000),
(8,'Kavita Rao','HR',58000),
(9,'Vikas Kumar','Finance',85000),
(10,'Anjali Desai','IT',68000);

-- Task 41 

set sql_safe_updates = 0;
update employees
set salary = salary * 1.10
where department = 'IT';

-- Task 42
select
    department,
    count(*) as employee_count,
    avg(salary) as average_salary,
    max(salary) as highest_salary
from employees
group by department;

-- Task 43
create table customers (
    customer_id int primary key,
    customer_name varchar(100),
    email varchar(100),
    phone varchar(15),
    address varchar(255)
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

create table orders (
    order_id int primary key,
    customer_id int,
    order_date date,
    total_amount decimal(10,2),
    foreign key (customer_id)
    references customers(customer_id)
);

insert into orders values
(1001,1,'2025-01-05',55000),
(1002,2,'2025-01-10',25000),
(1003,1,'2025-01-15',15000),
(1004,3,'2025-02-01',30000),
(1005,4,'2025-02-05',12000),
(1006,2,'2025-02-10',18000),
(1007,5,'2025-03-01',22000),
(1008,1,'2025-03-05',17000),
(1009,6,'2025-03-10',28000),
(1010,7,'2025-03-15',35000);

update orders
set customer_id = null
where customer_id = 5;

delete from customers
where customer_id = 5;

-- Task 44 : duplicate record

insert into customers values
(11,'Amit Sharma','amit@gmail.com','9876500001','Mumbai'),
(12,'Priya Patel','priya@gmail.com','9876500002','Delhi'),
(13,'Rahul Verma','rahul@gmail.com','9876500003','Pune');

select *
from customers
where email in (
    select email
    from customers
    group by email
    having count(*) > 1
);

-- Task 45
select
    c.customer_id,
    c.customer_name,
    sum(o.total_amount) as total_revenue
from customers c
join orders o
on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name
order by total_revenue desc;