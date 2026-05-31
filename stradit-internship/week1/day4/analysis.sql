create database analysis;

-- Task 36 — Netflix Recommendation Analytics
create table netflix (
    movie_id int primary key,
    title varchar(100),
    category varchar(50),
    rating decimal(3,1),
    watch_count int,
    user_id int
);

insert into netflix values
(1,'Stranger Things','Sci-Fi',9.0,5000,101),
(2,'Money Heist','Crime',8.8,4500,102),
(3,'Wednesday','Fantasy',8.5,6000,103),
(4,'Dark','Sci-Fi',9.2,4000,104),
(5,'Extraction','Action',8.0,3500,105),
(6,'Lupin','Crime',8.7,3000,106),
(7,'The Witcher','Fantasy',8.3,5500,107),
(8,'Narcos','Crime',8.9,4200,108),
(9,'The Gray Man','Action',7.8,2800,109),
(10,'Black Mirror','Sci-Fi',9.1,3800,110);

-- most watched category

select
    category,
    sum(watch_count) as total_views
from netflix
group by category
order by total_views desc
limit 1;

-- highest rated movies

select
    title,
    rating
from netflix
order by rating desc;

-- Active Users

select
    user_id,
    count(*) as movies_watched
from netflix
group by user_id
order by movies_watched desc;

-- Task 37 — Uber Ride Analytics

create table uber_rides (
    ride_id int primary key,
    city varchar(50),
    driver_name varchar(100),
    trip_distance decimal(5,2),
    fare_amount decimal(10,2)
);

insert into uber_rides values
(1,'Mumbai','Amit',12.5,350),
(2,'Delhi','Priya',8.2,220),
(3,'Mumbai','Rahul',15.0,450),
(4,'Pune','Sneha',6.5,180),
(5,'Delhi','Arjun',10.0,300),
(6,'Mumbai','Amit',20.0,600),
(7,'Pune','Neha',7.5,200),
(8,'Delhi','Priya',12.0,400),
(9,'Mumbai','Rahul',18.0,550),
(10,'Mumbai','Amit',14.0,420);

# Average Trip Distance
select avg(trip_distance) as average_trip_distance
from uber_rides;

# Busiest City
select city,
       count(*) as total_rides
from uber_rides
group by city
order by total_rides desc
limit 1;

# Highest Earning Driver
select driver_name,
       sum(fare_amount) as total_earnings
from uber_rides
group by driver_name
order by total_earnings desc
limit 1;

-- Task 38 — Amazon Order Analytics

create table amazon_orders (
    order_id int primary key,
    customer_name varchar(100),
    product_name varchar(100),
    quantity int,
    amount decimal(10,2)
);

insert into amazon_orders values
(1,'Amit','Laptop',1,55000),
(2,'Priya','Mobile',2,50000),
(3,'Rahul','Headphones',3,6000),
(4,'Amit','Mouse',2,1600),
(5,'Sneha','Laptop',1,55000),
(6,'Priya','Smart Watch',1,5000),
(7,'Amit','Keyboard',1,1500),
(8,'Rahul','Mobile',1,25000),
(9,'Arjun','Laptop',2,110000),
(10,'Priya','Headphones',2,4000);

# Top Customers

select
    customer_name,
    sum(amount) as total_spent
from amazon_orders
group by customer_name
order by total_spent desc
limit 5;

# Repeat Customers

select
    customer_name,
    count(order_id) as total_orders
from amazon_orders
group by customer_name
having count(order_id) > 1;

# Highest Revenue Products

select
    product_name,
    sum(amount) as total_revenue
from amazon_orders
group by product_name
order by total_revenue desc;

-- Task 39 — Banking Fraud Detection

create table transactions (
    transaction_id int primary key,
    account_id int,
    transaction_time datetime,
    amount decimal(12,2)
);

insert into transactions values
(1,101,'2025-01-10 10:00:00',50000),
(2,101,'2025-01-10 10:00:30',120000),
(3,101,'2025-01-10 10:01:00',150000),
(4,102,'2025-01-10 11:15:00',25000),
(5,102,'2025-01-10 11:15:45',30000),
(6,103,'2025-01-10 12:00:00',200000),
(7,104,'2025-01-10 12:30:00',45000),
(8,104,'2025-01-10 12:30:50',55000),
(9,105,'2025-01-10 13:00:00',175000),
(10,105,'2025-01-10 13:00:40',25000);

# Transactions Greater Than ₹1 Lakh
select *
from transactions
where amount > 100000;

# Multiple Transactions Within 1 Minute
select
    t1.account_id,
    t1.transaction_id,
    t2.transaction_id,
    t1.transaction_time,
    t2.transaction_time
from transactions t1
join transactions t2
on t1.account_id = t2.account_id
and t1.transaction_id < t2.transaction_id
and timestampdiff(second,
                  t1.transaction_time,
                  t2.transaction_time) <= 60;
                  
-- Task 40 — Hospital Management System

create table hospital (
    patient_id int primary key,
    patient_name varchar(100),
    doctor_name varchar(100),
    admission_date date,
    bed_no int
);

insert into hospital values
(1,'Amit','Dr. Sharma','2025-01-02',101),
(2,'Priya','Dr. Sharma','2025-01-05',102),
(3,'Rahul','Dr. Mehta','2025-01-10',103),
(4,'Sneha','Dr. Sharma','2025-02-01',104),
(5,'Arjun','Dr. Gupta','2025-02-05',105),
(6,'Neha','Dr. Mehta','2025-02-10',106),
(7,'Rohan','Dr. Sharma','2025-03-01',107),
(8,'Kavita','Dr. Gupta','2025-03-05',108),
(9,'Vikas','Dr. Sharma','2025-03-10',109),
(10,'Anjali','Dr. Mehta','2025-03-15',110);

# doctors with most patients
select
    doctor_name,
    count(patient_id) as total_patients
from hospital
group by doctor_name
order by total_patients desc;

# Available Beds
select
    120 - count(distinct bed_no) as available_beds -- assume hospital has 120 beds
from hospital;

# monthly patient count
select
    monthname(admission_date) as month,
    count(patient_id) as patient_count
from hospital
group by month(admission_date),
         monthname(admission_date)
order by month(admission_date);

