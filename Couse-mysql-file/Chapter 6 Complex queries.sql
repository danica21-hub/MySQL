-- 子查询 查找所有价格比Lettuce更贵的产品
USE sql_store;
SELECT *
FROM products
WHERE unit_price > (
		SELECT unit_price
		FROM products
		WHERE product_id = 3);
-- 练习1 查询所有收入在平均线以上的雇员
USE sql_hr;
SELECT *
FROM employees
WHERE salary >(
	SELECT AVG(salary)
    FROM employees
);
-- IN运算符 查找没有被订购过的产品
USE sql_store;
SELECT *
FROM products
WHERE product_id NOT IN(
	SELECT DISTINCT product_id
    FROM order_items
);
-- 练习2 查找没有发票的客户
USE sql_invoicing;
SELECT * 
FROM clients
WHERE client_id NOT IN (
		SELECT DISTINCT client_id
        FROM invoices
);
-- 练习3 查询购买了生菜的客户（customer_id, first_name, last_name）
USE sql_store;
-- 子查询法
SELECT 
	customer_id,
    first_name, 
    last_name
FROM customers
WHERE customer_id IN(
	SELECT customer_id
	FROM orders
	WHERE order_id IN(
		SELECT order_id
		FROM order_items
		WHERE product_id = 3
));
-- join
SELECT 
	DISTINCT customer_id,
    first_name,
    last_name
FROM customers
JOIN orders USING(customer_id)
JOIN order_items USING (order_id)
WHERE product_id = 3;
-- ALL
USE sql_invoicing;
SELECT *
FROM invoices
WHERE invoice_total > ALL(
	SELECT invoice_total
    FROM invoices
    WHERE client_id = 3
);
-- ANY
SELECT *
FROM clients
WHERE client_id = ANY(
	SELECT client_id
    FROM invoices
    GROUP BY client_id
    HAVING COUNT(*) >=2
);
-- 相关子查询
USE sql_hr;
SELECT *
FROM employees e
WHERE salary > (
	SELECT AVG(salary)
    FROM employees
    WHERE office_id = e.office_id
);
-- 练习4 查询每个客户总额大于其发票均值的发票
USE sql_invoicing;
SELECT *
FROM invoices i
WHERE invoice_total > (
	SELECT AVG(invoice_total)
    FROM invoices
    WHERE client_id = i.client_id
);
-- EXISTS 	
SELECT *
FROM clients c
WHERE EXISTS (
	SELECT client_id
    FROM invoices
    WHERE client_id = c.client_id
);
-- 练习5 查询从未被购买的产品
USE sql_store;
SELECT *
FROM products p
WHERE NOT EXISTS (
	SELECT product_id
    FROM order_items
    WHERE product_id = p.product_id
);
-- SELECT中的子查询
SELECT 
	invoice_id,
    invoice_total,
    (SELECT AVG(invoice_total) FROM invoices) AS invoice_average,
    invoice_total - (SELECT invoice_average) AS difference
FROM invoices;
-- 练习6
SELECT 
	c.client_id,
    c.name,
    (SELECT SUM(invoice_total) 
		FROM invoices
        WHERE client_id = c.client_id) AS total_sales,
    (SELECT AVG(invoice_total) FROM invoices) AS invoice_average,
    (SELECT total_sales - invoice_average) AS difference
FROM clients c;
-- FROM子查询
SELECT *
FROM(
	SELECT 
		c.client_id,
		c.name,
		(SELECT SUM(invoice_total) 
			FROM invoices
			WHERE client_id = c.client_id) AS total_sales,
		(SELECT AVG(invoice_total) FROM invoices) AS invoice_average,
		(SELECT total_sales - invoice_average) AS difference
	FROM clients c
) AS sales_summary
WHERE total_sales IS NOT NULL;