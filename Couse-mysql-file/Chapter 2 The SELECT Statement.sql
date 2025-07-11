-- Get all infomation in the customers table
-- 查询customers表所有列
USE sql_store;
SELECT *
FROM customers;
-- Get all the customers and sort them by first_name
-- 查询数据库中customers表所有列，并按照列first_name排序
SELECT *
FROM customers
-- WHERE customer_id = 1
ORDER BY first_name;
-- Get firstname of all customers
-- 查询所有顾客的名
SELECT 
	first_name AS 'first name',
	last_name,
	points, 
    (points + 10) * 10 AS discount_factor
FROM customers;
-- DISTINCT to remove duplicates
-- DISTINCT删除重复项
SELECT customer_id 
FROM orders;
SELECT DISTINCT customer_id
FROM orders;
-- 选择字句练习1
-- Return all the products(name, unit price, new price(unit price * 1.1))
-- 查询所有的产品，包括姓名、价格以及每个产品提价10%后的新价格
USE sql_inventory;
SELECT name, unit_price, unit_price * 1.1 AS 'new price'
FROM products;
-- Get the customers who have more than 3,000 points
-- 查询积分大于3000的顾客信息
USE sql_store;
SELECT * 
FROM customers
WHERE points > 3000;
-- Get the orders that the customer_id is 2
-- 查询订单顾客id为2的信息
SELECT * 
FROM orders
WHERE customer_id = 2;
-- Get the orders that status not equal to 1
-- 查询订单状态不为1的信息
SELECT * 
FROM orders
WHERE status != 1;
SELECT * 
FROM orders
WHERE status <> 1;
-- Get the customers born after 1990-01-01
-- 查询出生日期在1990-01-01以后的顾客信息
SELECT * 
FROM customers
WHERE birth_date > '1990-01-01';
-- 选择字句练习2
-- Get the orders placed in 2017
-- 查询2017年下的订单
SELECT * 
FROM orders
WHERE order_date >= '2017-01-01' AND order_date <= '2017-12-31';
-- Get the customers born after 1990-01-01 or points greater than 1000 and state is 'CO'
-- AND has a higher priority
-- 查询出生日期在1990-01-01以后或者积分大于1000且生活在CO的顾客 AND优先级更高，可不加括号
SELECT * 
FROM customers
WHERE birth_date > '1990-01-01' OR 
      (points > 1000 AND state = 'CO');
-- Get the customers born before 1990-01-01 and points not greater than 1000
-- 查询出生日期在1990年以前且积分小于等于1000的顾客
SELECT * 
FROM customers
WHERE NOT (birth_date > '1990-01-01' OR points > 1000);
-- 选择字句练习3
-- From the order_items table, get the items 
-- for order#6 where the total price is greater than 30
-- 查询order_items表中所有订单编号为6且总价格超过30的订单
SELECT *
FROM order_items
WHERE order_id = 6 AND unit_price * quantity > 30;
-- Get the customers whose state in 'VA'or'FL'or'GA'
-- 查询生活在VA、FL、GA的顾客
SELECT *
FROM customers
WHERE state IN ('VA', 'FL', 'GA');
-- Get the customers whose state not in 'VA'or'FL'or'GA'
-- 查询生活在除VA、FL、GA之外其他州的顾客
SELECT *
FROM customers
WHERE state NOT IN ('VA', 'FL', 'GA');
-- 选择字句练习4
-- Return products with quantity in stock equal to 49, 38, 72
-- 查询现货库存为49，38，72的产品
USE sql_inventory;
SELECT * 
FROM products
WHERE quantity_in_stock IN (49, 38, 72);
-- Get the customers whose points is between 1000 and 3000
-- 查询积分在1000-3000的顾客
USE sql_store;
SELECT *
FROM customers
WHERE points BETWEEN 1000 AND 3000;
-- 选择字句练习5
-- Return the customers born between 1990-01-01 and 2000-01-01
-- 查询出生日期为1990-01-01到2000-01-01之间的顾客
SELECT *
FROM customers
WHERE birth_date BETWEEN '1990-01-01' AND '2000-01-01';
-- Get the customers whose last names 
-- start with the letter 'b', contain the letter 'b', and end with the letter 'y'.
-- 匹配查询姓中带有以b字母开始、存在b字母以及以y字母结尾的顾客 %不限长度 _表示单个字符
SELECT *
FROM customers
WHERE last_name LIKE 'b%';
SELECT *
FROM customers
WHERE last_name LIKE '%b%';
SELECT *
FROM customers
WHERE last_name LIKE '%y';
-- Get the customers whose last name ends with 'y' and whose character length is 6
-- 查询姓以y字母结尾且字符长度为6的顾客
SELECT *
FROM customers
WHERE last_name LIKE '_____y';
-- 选择字句练习6
-- Get the customers whose 
-- address contain TRAIL or AVENUE
-- phone numbers end with 9
-- 查询地址中包括TRAIL或者AVENUE的顾客，查询手机尾号为9的顾客
SELECT *
FROM customers
WHERE address LIKE '%trail%' OR address LIKE '%avenue%';
SELECT * 
FROM customers
WHERE phone LIKE '%9';
-- Get the customers with 'field' in their last name
-- 查询姓中存在field的顾客
SELECT *
FROM customers
WHERE last_name REGEXP 'field';
-- Get the customers whose last name starts with 'rose'
-- 查询姓以rose开头的顾客
SELECT *
FROM customers
WHERE last_name REGEXP '^rose';
-- Get the customers whose last name ends in 'burgh'
-- 查询姓以burgh结尾的顾客
SELECT *
FROM customers
WHERE last_name REGEXP 'burgh$';
-- Get the customers with 'field' or 'mac' in their last name
-- 查询姓中存在field或mac的顾客
SELECT *
FROM customers
WHERE last_name REGEXP 'field|mac';
-- Get the customers whose with 'ay' or 'by' or 'cy' in their last name
-- 查询姓中存在ay|by|cy的顾客
SELECT *
FROM customers
WHERE last_name REGEXP '[a-c]y';
-- 选择字句练习7
-- Get the costomers whose
-- first names are ELKA or AMBUR
-- 查询名为ELKA或AMBUR的顾客
SELECT *
FROM customers
WHERE first_name REGEXP 'elka|ambur';
-- last names end with EY or ON
-- 查询姓以EY或ON结尾的顾客
SELECT *
FROM customers
WHERE last_name REGEXP 'ey$|on$';
-- last names start with MY or contains SE
-- 查询姓以MY开始或者包含SE的顾客
SELECT *
FROM customers
WHERE last_name REGEXP '^my|SE';
-- last names contain B followed by R or U
-- 查询姓中包含BR或BU的顾客
SELECT *
FROM customers
WHERE last_name REGEXP 'b[ru]';	
-- 查询手机号为空的顾客
SELECT * 
FROM customers
WHERE phone IS NULL;
-- 选择字句练习8
-- Get the orders that are not shipped
-- 查询所有还未发货的所有订单
SELECT *
FROM orders
WHERE shipped_date IS NULL;
-- Get all customers, sorted by birth_date in descending order
-- 查询所有顾客，以出生日期降序排列
SELECT *
FROM customers
ORDER BY birth_date DESC;
-- 选择字句练习9
-- Get the orders#2, and order by the total price in descending order 
-- 查询所有#2的订单，并以订单总价降序排列
SELECT *, quantity * unit_price AS 'total price'
FROM order_items
WHERE order_id = 2
ORDER BY quantity * unit_price DESC;
-- Get the customers with customer_id is 7 - 10
-- 查询id为7 - 10的全部顾客信息
SELECT *
FROM customers
LIMIT 6, 4;
-- 选择字句练习10
-- Get the top three loyal customers (higherst points)
-- 查询积分最多的前三名顾客
SELECT *
FROM customers
ORDER BY points DESC
LIMIT 3;
