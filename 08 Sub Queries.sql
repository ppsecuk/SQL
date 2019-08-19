/* 
	SUB QUERIES are queries embedded within other queries

	@author: Adombang Munang Mbomndih
*/


----------------------------------------------------------------------------------------------------------------
-- SUB QUERIES
----------------------------------------------------------------------------------------------------------------
USE sda_test;

SELECT first_name, last_name, (SELECT SUM(age) FROM user) sum_of_user_ages FROM user;

-- self join to sub query
USE sda_normalization;

SELECT CONCAT(u.first_name, ' ', u.last_name) user_name, 
	(SELECT CONCAT(first_name, ' ', last_name) FROM user WHERE u.boss_id = user_id) boss_name 
	FROM user u;
