SELECT DATABASE();
USE information_schema;
SHOW DATABASES;
SHOW TABLES;
SHOW COLUMNS FROM information_schema;
SHOW INDEX FROM information_schema;
SHOW CREATE TABLE countrylanguage;

DESCRIBE information_schema;
DESC information_schema;

EXPLAIN SELECT DATABASE();



USE sda_test;

SELECT * FROM sda_test.user;
SELECT * FROM user;
SELECT first_name, last_name FROM user;
SELECT first_name AS fName, last_name AS lName FROM user WHERE user_id = 2;
SELECT first_name, last_name FROM user WHERE last_name LIKE '_oxx';
SELECT * FROM user WHERE bio LIKE '%dogs%';
SELECT * FROM user WHERE bio LIKE '%dogs%' OR age > 25;
SELECT * FROM user WHERE (bio LIKE '%dogs%' OR age > 25) AND gender = 'Female';

SELECT first_name, last_name,
	CASE 
		WHEN TIMESTAMPDIFF(year, date_of_birth, CURDATE()) BETWEEN 0 AND 12 THEN 'Kid'
		ELSE 'Adult'
	END AS age_group
FROM user;

SELECT first_name, last_name, date_of_birth FROM user ORDER BY last_name ASC;
SELECT first_name, last_name, date_of_birth FROM user ORDER BY last_name DESC;
SELECT * FROM user LIMIT 2;
SELECT * FROM user LIMIT 2 OFFSET 1;
SELECT * FROM user LIMIT 1, 2;

SELECT 5 * 3 FROM DUAL;
SELECT ((8 + (2 * 5)) - 4) / 3;
SELECT 6 % 2 AS six_mod_two;
SELECT MOD(6,4) AS six_mod_two; 

USE sda_test;
SELECT COUNT(*) FROM user;
SELECT SUM(TIMESTAMPDIFF(year, date_of_birth, CURDATE())) sum_of_user_ages FROM user;
SELECT last_name, SUM(TIMESTAMPDIFF(year, date_of_birth, CURDATE())) sum_of_ages FROM user GROUP BY last_name;

SELECT CONTACT(first_name, " ", last_name) Full_Name FROM user; 

