-- 创建存储过程
DELIMITER $$
CREATE PROCEDURE get_client()
BEGIN
	SELECT * FROM clients;
END$$
DELIMITER ;
CALL get_client();
-- 练习1
DELIMITER $$
CREATE PROCEDURE get_invoices_with_balance() 
BEGIN
	SELECT *
	FROM invoices_with_balance
    WHERE balance > 0;
END$$
DELIMITER ;
CALL get_invoices_with_balance();
-- 删除
DROP PROCEDURE IF EXISTS get_client;
-- 参数的使用
DELIMITER $$
CREATE PROCEDURE get_client_by_state(state CHAR(2))
BEGIN
	SELECT * FROM clients c
    WHERE c.state = state;
END$$
DELIMITER ;
CALL get_client_by_state('NY');
-- 练习2
DELIMITER $$
CREATE PROCEDURE get_client_by_client(id int)
BEGIN
	SELECT * FROM invoices i
    WHERE i.client_id = id;
END$$
DELIMITER ;
CALL get_client_by_client(5);
-- 设置参数默认值
DROP PROCEDURE IF EXISTS get_client_by_state;
DELIMITER $$
CREATE PROCEDURE get_client_by_state(state CHAR(2))
BEGIN
	IF state IS NULL THEN
		SET state = 'NY';
	END IF;
	SELECT * FROM clients c
    WHERE c.state = state;
END$$
DELIMITER ;
CALL get_client_by_state(NULL);
-- 参数设置2
DROP PROCEDURE IF EXISTS get_client_by_state;
DELIMITER $$
CREATE PROCEDURE get_client_by_state(state CHAR(2))
BEGIN
	SELECT * FROM clients c
    WHERE c.state = IFNULL(state, c.state);
END$$
DELIMITER ;
CALL get_client_by_state(NULL);
-- 练习3
DELIMITER $$
CREATE PROCEDURE get_payment(client_id INT, payment_method_id TINYINT)
BEGIN
	SELECT * FROM payments p
    WHERE 
		p.client_id = IFNULL(client_id, p.client_id) AND
        p.payment_method = IFNULL(payment_method_id, p.payment_method);
END$$
DELIMITER ;

CALL get_payment(NULL, NULL);
-- 参数验证
DELIMITER $$
CREATE PROCEDURE make_payment(
	invoice_id INT,
    payment_amount DECIMAL(9,2),
    payment_date DATE
    )
BEGIN
	IF payment_amount < 0 THEN
		SIGNAL SQLSTATE '22003' SET MESSAGE_TEXT = 'Invalid payment amount';
	END IF;
	UPDATE invoices i
	SET 
		i.payment_total = payment_amount,
        i.payment_date = payment_date
	WHERE i.invoice_id = invoice_id;
END$$
DELIMITER ;
CALL make_payment(2, 100, '2019-01-01');
CALL make_payment(2, -100, '2019-01-01');
-- 输出参数
DELIMITER $$
CREATE PROCEDURE get_unpaid_invoices_by_client(
	client_id INT,
    OUT invoices_count INT,
    OUT invoices_total DECIMAL(9,2)
)
BEGIN
	SELECT COUNT(*), SUM(invoice_total)
    INTO invoices_count, invoices_total
    FROM invoices i
    WHERE i.client_id = client_id;
END$$
DELIMITER ;
-- 变量
DELIMITER $$
CREATE PROCEDURE get_risk_factor(
	
)
BEGIN
	DECLARE risk_factor DECIMAL(9,2) DEFAULT 0;
    DECLARE invoices_count DECIMAL(9,2);
    DECLARE invoices_total DECIMAL(9,2);
	SELECT COUNT(*), SUM(invoice_total)
    INTO invoices_count, invoices_total
    FROM invoices i
    WHERE i.client_id = client_id;
    SET risk_factor = invoices_total / invoices_count * 5;
    SELECT risk_factor;
END$$
DELIMITER ;
-- 函数 只能返回单一值 存储过程可以返回结果集
-- 一个函数至少包含一个函数属性 函数属性具体如下：
-- DETERMINITIC 确定性 同样的输入对象会返回同样的输出对象
-- READS SQL DATA 读取SQL数据 说明函数配置选择语句
-- MODIFIES SQL DATA 修改SQL数据
 DELIMITER $$
 CREATE FUNCTION get_riskFactor_by_client(client_id INT)
 RETURNS DECIMAL(9,2)
 READS SQL DATA
 BEGIN
	DECLARE risk_factor DECIMAL(9,2);
    DECLARE invoices_count INT;
    DECLARE invoices_total DECIMAL(9,2);
    
    SELECT SUM(invoice_total), COUNT(*) 
    INTO invoices_total, invoices_count
    FROM invoices i
    WHERE i.client_id = client_id;
    
    SET risk_factor = invoices_total / invoices_count * 5;
    RETURN IFNULL(risk_factor, 0);
 END$$
 DELIMITER ;
 -- 使用函数
 SELECT 
	client_id,
    name,
    get_riskFactor_by_client(client_id) AS risk_factor
FROM clients;