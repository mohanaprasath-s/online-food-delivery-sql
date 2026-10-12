# Online Food Delivery Database (MySQL)

A relational database for an online food delivery system, written in MySQL. It stores restaurants, menus, customers, orders, deliveries, and customer feedback, and the script practises the main parts of SQL on that data.

## Tables

| Table | What it stores |
|---|---|
| **Restaurants** | Restaurant name, address, phone, and rating |
| **Menus** | Food items with category, price, and availability, linked to a restaurant |
| **Customers** | Customer name, unique email, phone, and address |
| **Orders** | Order date, total amount, and status, linked to a customer and a restaurant |
| **Deliveries** | Delivery person, status, and time, linked to an order |
| **Feedback** | Rating (1 to 5) and comments from a customer about a restaurant |

### How the tables are related

- A restaurant has many menu items (`Menus.restaurant_id`)
- A customer places many orders (`Orders.customer_id`), each from one restaurant (`Orders.restaurant_id`)
- Each order has a delivery record (`Deliveries.order_id`)
- A customer can leave feedback about a restaurant (`Feedback.customer_id`, `Feedback.restaurant_id`)

The tables use primary keys and foreign keys, a `UNIQUE` constraint on customer email, and a `CHECK` constraint that keeps feedback ratings between 1 and 5.

## What the script covers

- **DDL:** `CREATE TABLE`, `ALTER TABLE` (rename column, add column, modify column, drop column)
- **DML:** `INSERT`, `UPDATE`, `DELETE`, and `SELECT`
- **Aggregates:** `SUM`, `AVG`, `MAX`, `MIN`, `COUNT`, with `GROUP BY` and `HAVING`
- **Joins:** inner, left, right, and full join (using `UNION`), plus a three-table join
- **Subqueries**, `ORDER BY`, `LIMIT`, and `OFFSET`
- **View:** `customer_orders`
- **Stored procedures:** `highest_price` and `highest_rating`
- **Triggers:** before and after insert and update on `Orders`, with `Order_Log` and `Update_Log` tables
- **Transactions:** `START TRANSACTION`, `SAVEPOINT`, `ROLLBACK TO`, and `COMMIT`
- **String functions:** `UPPER`, `LOWER`, `LENGTH`, `CONCAT`, `SUBSTRING`, `REPLACE`, `TRIM`, `LEFT`, `RIGHT`, `REVERSE`

## Sample data

The script includes 5 restaurants, 8 menu items, 5 customers, 5 orders, 5 deliveries, and 5 feedback entries so every query returns results.
