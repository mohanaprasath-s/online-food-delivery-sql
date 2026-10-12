create database online_food_delivery;
use online_food_delivery;

CREATE TABLE Restaurants (
    restaurant_id INT PRIMARY KEY,
    restaurant_name VARCHAR(100),
    address VARCHAR(200),
    phone VARCHAR(15),
    rating DECIMAL(2,1)
);

CREATE TABLE Menus(
    menu_id INT PRIMARY KEY,
    restaurant_id INT,
    food_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(8,2),
    availability VARCHAR(20),
    FOREIGN KEY (restaurant_id)
    REFERENCES Restaurants(restaurant_id)
);

CREATE TABLE Customers(
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    address VARCHAR(200)
);

CREATE TABLE Orders(
    order_id INT PRIMARY KEY,
    customer_id INT,
    restaurant_id INT,
    order_date DATETIME,
    total_amount DECIMAL(10,2),
    order_status VARCHAR(30),
    FOREIGN KEY(customer_id)
    REFERENCES Customers(customer_id),
    FOREIGN KEY(restaurant_id)
    REFERENCES Restaurants(restaurant_id)
);

CREATE TABLE Deliveries(
    delivery_id INT PRIMARY KEY,
    order_id INT,
    delivery_person VARCHAR(100),
    delivery_status VARCHAR(30),
    delivery_time DATETIME,
    FOREIGN KEY(order_id)
    REFERENCES Orders(order_id)
);

CREATE TABLE Feedback(
    feedback_id INT PRIMARY KEY,
    customer_id INT,
    restaurant_id INT,
    rating INT CHECK(rating BETWEEN 1 AND 5),
    comments VARCHAR(255),
    feedback_date DATE,
    FOREIGN KEY(customer_id)
    REFERENCES Customers(customer_id),
    FOREIGN KEY(restaurant_id)
    REFERENCES Restaurants(restaurant_id)
);

INSERT INTO Restaurants VALUES
(101,'Dominos','Chennai','9876543210',4.5),
(102,'KFC','Coimbatore','9876501234',4.2),
(103,'Pizza Hut','Madurai','9988776655',4.4),
(104,'Burger King','Salem','9871234567',4.3),
(105,'Subway','Trichy','9123456789',4.1);

INSERT INTO Menus VALUES
(1,101,'Veg Pizza','Pizza',250,'Available'),
(2,101,'Chicken Pizza','Pizza',350,'Available'),
(3,102,'Chicken Bucket','Fast Food',650,'Available'),
(4,103,'Cheese Pizza','Pizza',300,'Available'),
(5,104,'Whopper Burger','Burger',220,'Available'),
(6,105,'Veg Sandwich','Sandwich',180,'Available'),
(7,102,'French Fries','Snacks',120,'Available'),
(8,104,'Chicken Burger','Burger',260,'Available');

INSERT INTO Customers VALUES
(201,'Arun','arun@gmail.com','9876541111','Chennai'),
(202,'Priya','priya@gmail.com','9876542222','Coimbatore'),
(203,'Rahul','rahul@gmail.com','9876543333','Madurai'),
(204,'Meena','meena@gmail.com','9876544444','Salem'),
(205,'Karthik','karthik@gmail.com','9876545555','Trichy');

INSERT INTO Orders VALUES
(301,201,101,'2026-06-01 12:30:00',600,'Delivered'),
(302,202,102,'2026-06-02 01:15:00',650,'Delivered'),
(303,203,103,'2026-06-03 07:20:00',300,'Pending'),
(304,204,104,'2026-06-04 08:00:00',220,'Out for Delivery'),
(305,205,105,'2026-06-05 09:30:00',180,'Delivered');

INSERT INTO Deliveries VALUES
(401,301,'Ravi','Delivered','2026-06-01 01:10:00'),
(402,302,'Suresh','Delivered','2026-06-02 02:00:00'),
(403,303,'Ajith','Pending',NULL),
(404,304,'Manoj','Out for Delivery',NULL),
(405,305,'Vijay','Delivered','2026-06-05 10:15:00');

INSERT INTO Feedback VALUES
(501,201,101,5,'Excellent Pizza','2026-06-01'),
(502,202,102,4,'Good Taste','2026-06-02'),
(503,203,103,3,'Average Service','2026-06-03'),
(504,204,104,5,'Very Fast Delivery','2026-06-04'),
(505,205,105,4,'Healthy Food','2026-06-05');

-- DDL
alter table Restaurants
rename column phone to contact_number;

alter table Restaurants
add  city varchar(20);

alter table Menus
modify food_name varchar(20);

alter table Feedback
drop column comments;

-- DML

select * from restaurants;
select * from menu;
select * from customers;
select * from orders;

update customers
set phone=6368125365
where customer_id=201;

delete from customers
where customer_id=201;

insert into customers(customer_id,customer_name,phone) values
(206,'ram',6369163527),
(207,'rim',5758398383);

select * from Menus 
where price>(select avg(price) as avg_price from menus);

select c.customer_name,o.order_id,o.total_amount,o.order_status
from Restaurants r 
join Orders o on
c.customer_id=o.customer_id;

-- TCL-- 
START TRANSACTION;

SAVEPOINT sp1;

UPDATE customers
SET phone_no = '9876501111'
WHERE customer_id = 1;

SAVEPOINT sp2;

UPDATE customers
SET city = 'Coimbatore'
WHERE customer_id = 1;

SAVEPOINT sp3;

UPDATE customers
SET company = 'ABC Technologies'
WHERE customer_id = 1;

SAVEPOINT sp4;

UPDATE customers
SET country = 'USA'
WHERE customer_id = 1;
SAVEPOINT sp5;

ROLLBACK TO sp3;
COMMIT;


-- aggregates
select sum(total_amount) as total_revenue
from Orders;

select avg(rating) as average_rating from Restaurants;

select max(price) as highest_price from Menus;

select count(*) as total_customers from Customers;

select min(price) as  lowest_price from menus;

-- joins
-- inner join
select c.customer_id,c.customer_name,o.order_id,o.order_status,o.total_amount
from Customers c 
inner join Orders 
on c.customer_id=o.customer_id;

-- left join
select c.customer_id,c.customer_name,o.order_id,o.order_status,o.total_amount
from Customers c 
left join Orders o
on c.customer_id=o.customer_id;

-- right join
select c.customer_id,c.customer_name,o.order_id,o.order_status,o.total_amount
from Customers c 
right join Orders o
on c.customer_id=o.customer_id;

-- full join
select c.customer_id,c.customer_name,o.order_id,o.order_status,o.total_amount
from Customers c 
left join Orders 
on c.customer_id=o.customer_id

union
select c.customer_id,c.customer_name,o.order_id,o.order_status,o.total_amount
from Customers c 
right join Orders 
on c.customer_id=o.customer_id;

-- limit && offset

select * from Menus
order by price desc
limit 2 offset 1;

select restaurant_id, avg(price) as total_revenue from Orders
group by restaurant_id;

select restaurant_id,restaurant_name from Restaurants
where rating>=(select max(rating) as highest_rating from Restaurants)
group by restaurant_id;

select customer_id,restaurant_id from orders
where order_status="delivered"
group by customer_id
order by customer_id desc
limit 4 offset 1;
-- view
create view customer_orders as 
select c.customer_id,c.customer_name,o.order_id,o.order_status,o.total_amount
from Customers c 
inner join Orders 
on c.customer_id=o.customer_id;

select c.customer_name,o.order_id,d.delivery_person,d.delivery_status
from Customers c 
join Orders o on
c.customer_id=o.customer_id
join Deliveries d on
o.order_id=d.order_id;

-- having

select customer_id,sum(total_amount) as total_revenue
from Orders group by customer_id
having sum(total_amount)>500;

-- stored procedure

create procedure highest_price(in X int)
select * from Menus 
 where price>X;
 call highest_price(1000);
 
 create procedure highest_rating(in X int)
 select customer_id,restaurant_id from Feedback
 where rating>x;
 call highest_rating(4);
 
 -- triggers
 -- before insert
 DELIMITER $$

CREATE TRIGGER before_order_insert
BEFORE INSERT ON Orders
FOR EACH ROW
BEGIN
    SET NEW.order_status = 'Pending';
END $$

DELIMITER ;
-- after insert
DELIMITER $$

CREATE TRIGGER after_order_insert
AFTER INSERT ON Orders
FOR EACH ROW
BEGIN
    INSERT INTO Order_Log
    VALUES (NEW.order_id, 'Order Inserted');
END $$

DELIMITER ;

-- before update
DELIMITER $$

CREATE TRIGGER before_order_update
BEFORE UPDATE ON Orders
FOR EACH ROW
BEGIN
    SET NEW.order_status = 'Delivered';
END $$

DELIMITER ;

-- after update 
DELIMITER $$

CREATE TRIGGER after_order_update
AFTER UPDATE ON Orders
FOR EACH ROW
BEGIN
    INSERT INTO Update_Log
    VALUES (NEW.order_id, 'Order Updated');
END $$

DELIMITER ;

-- string upper

select upper(customer_name) as customer_name from Customers;

-- string lower

select lower(customer_name) as customer_name from Customer;

-- length
select customer_name,length(customer_name) as name_length from Customer;

-- concat
SELECT CONCAT(customer_name, ' - ', address) AS Customer_Details
FROM Customers;

-- substring
SELECT SUBSTRING(food_name, 1, 4) AS Short_Name
FROM Menus;

-- replace 
SELECT REPLACE(restaurant_name, 'Pizza', 'Food') AS New_Name
FROM Restaurants;

-- trim
SELECT TRIM('   Online Food Delivery   ') AS Result;

-- left
SELECT LEFT(customer_name, 3) AS First_Three
FROM Customers;

-- right
SELECT RIGHT(customer_name, 3) AS Last_Three
FROM Customers;

-- reverse
SELECT REVERSE(customer_name) AS Reverse_Name
FROM Customers;

 
















 


