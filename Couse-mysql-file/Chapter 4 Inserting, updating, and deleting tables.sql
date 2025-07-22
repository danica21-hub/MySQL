-- 插入单行数据
INSERT INTO customers
VALUES(DEFAULT, 'John', 'Smith', '1990-02-21', NULL, '200 stress', 'city', 'CA', DEFAULT);
-- 插入多行数据
INSERT INTO shippers(name)
VALUES('Danica'), ('Aurora'), ('Jack');
-- 练习1 向product表中插入三行记录
INSERT INTO products
VALUES
	(DEFAULT, 'POKER', '54', '0.99'),
    (DEFAULT, 'product1', '53', '1.49'),
    (DEFAULT, 'product2', '54', '4.12');
-- 向多张表中插入数据
INSERT INTO orders (customer_id, order_date, status)
VALUES (1, '2025-07-21', 1);
INSERT INTO order_items
VALUES (LAST_INSERT_ID(), 1, 20, 3.79), 
	   (LAST_INSERT_ID(), 2, 2, 2.79);
-- 创建表复制
CREATE TABLE order_archived AS 
SELECT * FROM orders;
-- 练习2
USE sql_invoicing;
CREATE TABLE invoice_archived AS
SELECT 
	invoice_id, number, c.name AS client, 
	invoice_total, payment_total, 
    invoice_date, due_date, payment_date
FROM invoices i
JOIN clients c USING(client_id)
WHERE i.payment_date IS NOT NULL;
-- 更新行数据
UPDATE invoices
SET payment_total = invoice_total * 0.5, payment_date = due_date
WHERE client_id = 3;
-- 练习3
USE sql_store;
UPDATE customers 
SET points = points + 50
WHERE birth_date < '1990-01-01';
-- 在UPDATE字句中使用子查询
USE sql_invoicing;
UPDATE invoices
SET 
	payment_total = invoice_total * 0.5,
    payment_date = due_date
WHERE client_id IN
		(SELECT client_id
        FROM clients
        WHERE state IN ('CA', 'NY'));
-- 练习4
USE sql_store;
UPDATE orders
SET comments = 'Gold customer'
WHERE customer_id IN
		(SELECT customer_id
        FROM customers
        WHERE points >= 3000);
-- 删除行数据
DELETE FROM invoices
WHERE invoice_id = 19;