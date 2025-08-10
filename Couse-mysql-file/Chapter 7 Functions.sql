-- 数值函数 numeric function
-- 四舍五入 ROUND(数值, 精确度)
SELECT ROUND(5.34923,1); #5.3
SELECT ROUND(5.34923,2); #5.35
-- 截断函数 TRUNCATE(数值, 保留小数位数)
SELECT TRUNCATE(5.34923,2); #5.34
-- 上限函数 CEILING()
SELECT CEILING(5.2); #6
SELECT CEILING(5.7); #6
-- 下限函数 FLOOR()
SELECT FLOOR(5.7); #5
-- 绝对值 ABS()
SELECT ABS(-3.432);
SELECT ABS(3.432);
-- 随机函数 RAND() 随机返回0-1之间的浮点数
SELECT RAND();
SELECT RAND() + 2; # 随机返回2-3之间的浮点数

-- 字符串函数 string functions
-- 长度函数 LENGTH()
SELECT LENGTH('CodeWithMosh');
-- 转化函数UPPER() LOWER()
SELECT UPPER('CodeWithMosh');
SELECT LOWER('CodeWithMosh');
-- TRIM() 去掉字符串多余空格 
SELECT LTRIM('   CodeWithMosh');
SELECT RTRIM('CodeWithMosh   ');
SELECT TRIM('    CodeWithMosh    ');
-- 返回左/右侧指定长度字符 LEFT() RIGHT()
SELECT LEFT('CodeWithMosh',4);
SELECT RIGHT('CodeWithMosh',4);
-- 截取子串 SUBSTR()
SELECT SUBSTR('CodeWithMosh', 5, 4);
-- 定位函数 LOCATE()
SELECT LOCATE('T', 'CodeWithMosh');
-- 替换字符串 REPLACE()
SELECT REPLACE('CodeWithMosh', 'Mosh', 'AI');
SELECT CONCAT('CodeWithMosh', ' ', 'Great');
-- 日期函数
SELECT NOW();
SELECT CURDATE();
SELECT CURTIME();
SELECT YEAR(NOW());
SELECT MONTH(NOW());
SELECT HOUR(NOW());
SELECT MINUTE(NOW());
SELECT SECOND(NOW());
SELECT EXTRACT(DAY FROM NOW());
SELECT DAYNAME(NOW());
SELECT MONTHNAME(NOW());
-- 练习1 返回当年的订单
USE sql_store;
SELECT *
FROM orders
WHERE YEAR(order_date) = YEAR(NOW());
-- 格式化日期与时间
SELECT DATE_FORMAT(NOW(), '%M %d %Y');
SELECT TIME_FORMAT(NOW(), '%H:%i');
-- 计算日期与时间
SELECT DATE_ADD(NOW(),INTERVAL 1 YEAR);
SELECT DATE_ADD(NOW(),INTERVAL -1 DAY);
SELECT DATEDIFF('2025-10-21', '2025-07-03');
SELECT (TIME_TO_SEC('08:49') - TIME_TO_SEC('08:48'));
-- 其他函数
-- IFNULL()/COALESCE()
USE sql_store;
SELECT 
	customer_id,
    IFNULL(shipper_id,'Not Assigned'),
    COALESCE(shipper_id, comments, 'Not Assigned')
FROM orders;
-- 练习2
SELECT 
	CONCAT(first_name, ' ' ,last_name) AS customer,
    IFNULL(phone, 'Unknown') AS phone
FROM customers;
-- IF()
SELECT 
	order_id,
    order_date,
    IF(YEAR(NOW()) = YEAR(order_date), 'Active', 'Archived') AS status
FROM orders;
-- 练习3
SELECT
	product_id,
    name,
    COUNT(*) AS orders,
    IF(COUNT(*) > 1, 'Many times', 'Once') AS frequancy
FROM products p
JOIN order_items USING(product_id)
GROUP BY(product_id);
-- CASE()
SELECT 
	order_id,
    order_date,
    CASE
		WHEN YEAR(order_date) = YEAR(NOW()) THEN 'Active'
        WHEN YEAR(order_date) = YEAR(NOW()) - 1 THEN 'Last Year'
        WHEN YEAR(order_date) < YEAR(NOW()) - 1 THEN 'Archived'
    END AS category
FROM orders;
-- 练习4
SELECT
	CONCAT(first_name, ' ', last_name) AS customer,
    points,
    CASE
		WHEN points >= 3000 THEN 'Gold'
        WHEN points >= 2000 THEN 'Sliver'
        WHEN points < 2000 THEN 'Bronze'
    END AS category
FROM customers;