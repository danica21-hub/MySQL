-- 创建视图
USE sql_invoicing;
CREATE VIEW sales_by_client AS 
SELECT
	c.client_id,
    c.name,
    SUM(invoice_total) AS total_sales
FROM invoices 
JOIN clients c USING(client_id)
GROUP BY c.client_id;
SELECT * 
FROM sales_by_client
ORDER BY total_sales DESC;
-- 练习1
CREATE VIEW client_balance AS
SELECT 
	c.client_id,
    c.name,
    SUM(invoice_total - payment_total) AS balance
FROM invoices
JOIN clients c USING(client_id)
GROUP BY c.client_id;
-- 删除视图
DROP VIEW client_balance;
-- 可更新视图
SET FOREIGN_KEY_CHECKS = 0; #设置外键无效，否则报错
CREATE OR REPLACE VIEW invoices_with_balance AS
SELECT
	*,
    invoice_total - payment_total AS balance 
FROM invoices
WHERE (invoice_total - payment_total) > 0
WITH CHECK OPTION;
DELETE FROM invoices_with_balance
WHERE client_id = 1;
UPDATE invoices_with_balance
SET due_date = DATE_ADD(due_date, INTERVAL 2 DAY)
WHERE client_id = 2;
-- WITH CHECK OPTION 
UPDATE invoices_with_balance
SET payment_total = invoice_total
WHERE invoice_id = 3;