-- 聚合函数MAX, MIN, AVG, SUM, COUNT
SELECT
	MAX(invoice_total) AS highest, 
    MIN(invoice_total) AS lowest, 
    AVG(invoice_total) AS average, 
    SUM(invoice_total) AS sum, 
    COUNT(invoice_total) AS number_of_invoice
FROM invoices
WHERE invoice_date > '2019-07-01';
-- 练习1
SELECT 
	'First half of 2019' AS date_range, 
    SUM(invoice_total) AS total_sales, 
    SUM(payment_total) AS total_payment, 
    SUM(invoice_total - payment_total) AS what_we_expt
FROM invoices
WHERE invoice_date BETWEEN '2019-01-01' AND '2019-06-30' 
UNION
SELECT 
	'Second half of 2019' AS date_range, 
    SUM(invoice_total) AS total_sales, 
    SUM(payment_total) AS total_payment, 
    SUM(invoice_total - payment_total) AS what_we_expt
FROM invoices
WHERE invoice_date BETWEEN '2019-07-01' AND '2019-12-31' 
UNION
SELECT 
	'Total' AS date_range, 
    SUM(invoice_total) AS total_sales, 
    SUM(payment_total) AS total_payment, 
    SUM(invoice_total - payment_total) AS what_we_expt
FROM invoices
WHERE invoice_date BETWEEN '2019-01-01' AND '2019-12-31' ;
-- GROUP BY字句
-- 单列分组
SELECT 
	client_id,
	SUM(invoice_total) AS total_sales
FROM invoices
GROUP BY client_id;
-- 多列分组
SELECT 
	state,
    city,
    SUM(invoice_total) AS total_sales
FROM invoices
JOIN clients USING(client_id)
GROUP BY state, city;
-- 练习2
SELECT 
	date,
    name,
    SUM(amount) AS total_payments
FROM payments p
JOIN payment_methods pm
ON p.payment_method = pm.payment_method_id
GROUP BY date,name;
-- HAVING字句 对分组后的数据进行筛选
SELECT 
	client_id,
	SUM(invoice_total) AS total_sales,
    COUNT(*) AS number_of_invoices
FROM invoices
GROUP BY client_id
HAVING total_sales > 500 AND number_of_invoices > 5;
-- 练习3
USE sql_store;
SELECT
    c.customer_id, 
    c.first_name,
    c.last_name,
    SUM(quantity * unit_price) AS total_spent
FROM orders o
JOIN order_items oi USING(order_id)
JOIN customers c USING(customer_id)
WHERE c.state = 'VA'
GROUP BY customer_id
HAVING total_spent > 100;
-- ROLLUP字句
USE sql_invoicing;
SELECT 
	state,
    city,
    SUM(invoice_total) AS total_sales
FROM invoices
JOIN clients USING(client_id)
GROUP BY state, city WITH ROLLUP;
-- 练习4
SELECT 
	pm.name AS payment_method, 
	SUM(amount) AS total
FROM payments p
JOIN invoices i USING(invoice_id)
JOIN payment_methods pm ON p.payment_method = pm.payment_method_id
GROUP BY pm.name WITH ROLLUP;