-- 内连接
-- Inner joins
SELECT order_id, c.customer_id, first_name, last_name
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
ORDER BY order_id;
-- 练习1
-- order_items表与products表连接，每笔订单返回订单id、产品id和名字以及数量与单价
SELECT order_id, o.product_id, name, quantity, o.unit_price
FROM order_items o
JOIN products p
  ON o.product_id = p.product_id;
-- 跨数据库连接
-- Joining across Database
SELECT *
FROM order_items oi
JOIN sql_inventory.products p
ON oi.product_id = p.product_id;
-- 自连接
-- Self joins
USE sql_hr;
SELECT e.first_name, m.employee_id, m.first_name AS manager
FROM employees e
JOIN employees m
  ON e.reports_to = m.employee_id;
-- 多表连接
-- Joining Multiple Tables
USE sql_store;
SELECT order_id, first_name, last_name, name
FROM orders o
JOIN customers c 
  ON o.customer_id = c.customer_id
JOIN order_statuses os
  ON o.status = os.order_status_id;
-- 练习2
-- sql_invoicing数据库下payments, clients和payment_method多表连接，查询相关信息
USE sql_invoicing;
SELECT date, invoice_id, p.client_id, c.name, amount, pm.name
FROM payments p
JOIN clients c
  ON p.client_id = c.client_id
JOIN payment_methods pm
  ON p.payment_method = pm.payment_method_id;
-- 外连接
-- OUTER JOIN
SELECT 
	c.customer_id,
    c.first_name,
    o.order_id
FROM customers c
LEFT JOIN orders o
		ON c.customer_id = o.customer_id
ORDER BY c.customer_id;

SELECT 
	c.customer_id,
    c.first_name,
    o.order_id
FROM customers c
RIGHT JOIN orders o
		ON c.customer_id = o.customer_id
ORDER BY c.customer_id;
-- 练习3
-- 返回产品id、产品名、以及订单产品数量，允许订单产品数量有空值
SELECT p.product_id, name, quantity
FROM products p
LEFT JOIN order_items oi
		ON p.product_id = oi.product_id
ORDER BY p.product_id;
-- 多表外连接
SELECT 
	c.customer_id,
    c.first_name,
    o.order_id, 
    sh.name
FROM customers c
LEFT JOIN orders o
		ON c.customer_id = o.customer_id
LEFT JOIN shippers sh
		ON o.shipper_id = sh.shipper_id
ORDER BY c.customer_id;
-- 练习4
-- 返回订单下单日期、订单id、顾客名、发货人、订单状态，发货人不存在是为null
SELECT 
	order_date,
    o.order_id, 
    c.first_name,
    sh.name AS shipper,
    os.name AS status
FROM orders o
JOIN customers c
		ON o.customer_id = c.customer_id
LEFT JOIN shippers sh
		ON o.shipper_id = sh.shipper_id
LEFT JOIN order_statuses os
		ON o.status = os.order_status_id
ORDER BY status;
-- USING子句
SELECT order_id, c.customer_id, first_name, last_name
FROM orders o
JOIN customers c
USING(customer_id);
-- 练习5
USE sql_invoicing;
SELECT p.date, c.name AS client, p.amount, pm.name
FROM payments p
JOIN clients c
USING(client_id)
JOIN payment_methods pm
ON p.payment_method = pm.payment_method_id;
-- 练习5
USE sql_store;
SELECT p.name AS product, sh.name AS shipper
FROM products p, shippers sh;
USE sql_store;
SELECT p.name AS product, sh.name AS shipper
FROM products p
CROSS JOIN shippers sh;
-- 联合UNION
SELECT
	order_id, 
    order_date,
    'Active' AS status
FROM orders o
WHERE order_date >= '2019-01-01'
UNION
SELECT
	order_id, 
    order_date,
    'Achived' AS status
FROM orders o
WHERE order_date < '2019-01-01';
-- 练习6
SELECT 
	customer_id, 
    first_name, 
    points, 
    'Bronze' AS type
FROM customers
WHERE points < 2000
UNION
SELECT 
	customer_id, 
    first_name, 
    points, 
    'Sliver' AS type
FROM customers
WHERE points BETWEEN 2000 AND 3000
UNION
SELECT 
	customer_id, 
    first_name, 
    points, 
    'GOLD' AS type
FROM customers
WHERE points >= 3000
ORDER BY first_name;
