/* 
	STORED ROUTINES capture a block of SQL statements in a reusable and callable logic.

	@author: Adombang Munang Mbomndih
*/


DROP DATABASE IF EXISTS sda_routine;
CREATE DATABASE sda_routine;
USE sda_routine;


----------------------------------------------------------------------------------------------------------------
-- STORED PROCEDURES
----------------------------------------------------------------------------------------------------------------
-- With no parameters
DELIMITER $$
CREATE PROCEDURE create_user_table() 
BEGIN
	CREATE TABLE user(
		user_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
		first_name VARCHAR(15) NOT NULL UNIQUE,
		last_name VARCHAR(15) NOT NULL,
		email VARCHAR(50) NOT NULL,
		date_of_birth DATE,
		active BOOLEAN DEFAULT TRUE,
		gender ENUM('Male', 'Female', 'Other') NOT NULL,
		biography TEXT,
		salary INT NOT NULL,
		started_on datetime DEFAULT CURRENT_TIMESTAMP
	);
END;$$
DELIMITER ;

CALL create_user_table();

----------------------------------------------
-- With IN parameters
DELIMITER $$
CREATE PROCEDURE add_user(
	IN fName VARCHAR(15), IN lName VARCHAR(15), IN email VARCHAR(30), IN dob DATE, 
	IN gender VARCHAR(10), IN bio TEXT, IN salary INT
) 
BEGIN
	INSERT INTO user VALUES (NULL, fName, lName, email, dob, 1, gender, bio, salary, NOW());
END;$$
DELIMITER ;

CALL add_user('John', 'Wick', 'jwick@example.com', '1973-05-22', 'Male', 'I am John Wick!', 250000);
CALL add_user('Lara', 'Croft', 'lcroft@example.com', '1997-11-12', 'Male', NULL, 100000);
CALL add_user('Scooby', 'Doo', 'sdoo@example.com', '2005-07-03', 'Male', 'I am Scooby Doo!', 300000);
CALL add_user('Neo', 'The One', 'andersonk@example.com', '1982-01-01', 'Male', 'My name is NOT Mr. Anderson, my name is NEO!', 500000);
----------------------------------------------
-- With OUT parameter
DELIMITER $$
CREATE PROCEDURE count_users(OUT number_of_users INT) 
BEGIN
	SELECT COUNT(*) INTO number_of_users FROM user;
END;$$
DELIMITER ;

CALL count_users(@number_of_users);
SELECT @number_of_users;
----------------------------------------------

DELIMITER $$
CREATE PROCEDURE set_sum_of_ages(OUT sum_of_ages INT) 
BEGIN
	SELECT SUM(TIMESTAMPDIFF(YEAR, date_of_birth, CURRENT_TIMESTAMP)) INTO sum_of_ages FROM user;
END;$$
DELIMITER ;

CALL set_sum_of_ages(@sum_of_ages);
SELECT first_name, last_name, @sum_of_ages FROM user;
----------------------------------------------
-- With INOUT parameter
DELIMITER $$
CREATE PROCEDURE square_number(INOUT number_to_square INT) 
BEGIN
	SELECT number_to_square * number_to_square INTO number_to_square;
END;$$
DELIMITER ;

SET @number_to_square = 8;
CALL square_number(@number_to_square);
SELECT @number_to_square;


----------------------------------------------------------------------------------------------------------------
-- STORED FUNCTIONS
----------------------------------------------------------------------------------------------------------------
DELIMITER |
CREATE FUNCTION get_age(date_of_birth DATE) RETURNS INT NO SQL
    BEGIN
		DECLARE user_age INT;

		SET user_age = TIMESTAMPDIFF(YEAR, date_of_birth, CURRENT_TIMESTAMP);
        
		RETURN user_age;
    END;|
DELIMITER ;

SELECT first_name, last_name, get_age(date_of_birth) age, @sum_of_ages FROM user;
SELECT get_age('1990-08-13');

--------------------------------
DELIMITER |
CREATE FUNCTION get_age2(date_of_birth DATE) RETURNS INT NO SQL
   	RETURN TIMESTAMPDIFF(YEAR, date_of_birth, CURRENT_TIMESTAMP);|
DELIMITER ;

SELECT first_name, last_name, get_age2(date_of_birth) age, @sum_of_ages FROM user;
SELECT get_age2('1990-08-13');

--------------------------------
DELIMITER |
CREATE FUNCTION compute_circle_area(radius INT) RETURNS FLOAT DETERMINISTIC CONTAINS SQL
   	RETURN PI() * POWER(radius, 2);|
DELIMITER ;

SELECT compute_circle_area(5);
SELECT ROUND(compute_circle_area(5), 2);





/* EXCERCISES */
-- 1) What does the following procedure do??
	DELIMITER |
	CREATE PROCEDURE copy_unique_hobby()
		BEGIN
			WHILE EXISTS (SELECT SUBSTRING_INDEX(hobbies, ',', 1) FROM user WHERE hobbies IS NOT NULL)
			DO
				INSERT IGNORE INTO hobby (hobby) (SELECT TRIM(SUBSTRING_INDEX(hobbies, ',', 1)) FROM user);
				UPDATE user SET hobbies = 
					CASE
						WHEN LOCATE(',', hobbies) <> 0 THEN TRIM(RIGHT(hobbies, LENGTH(hobbies) - LOCATE(',', hobbies)))
						ELSE NULL
					END;
			END WHILE;
		END;|
	DELIMITER ;
