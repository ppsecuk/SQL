/* 
	TRANSACTIONS are atomic units of work that can be committed or rolled back at some point of execution. 
	
	NB: TCL stands for Transaction Control Language. It is used for handling transactions within a database.

	@author: Adombang Munang Mbomndih
*/



-- To check table engine use
SELECT ENGINE FROM information_schema.TABLES WHERE TABLE_SCHEMA = '<database_name>' AND TABLE_NAME = '<table_name>';
-- or
SHOW CREATE TABLE '<table_name>';

-- To change table engine use
ALTER TABLE '<table_name>' ENGINE = '<engine_name>';

----------------------------------------------------------------------------------------------------------------
-- TRANSACTIONS
----------------------------------------------------------------------------------------------------------------
USE sda_normalization;

DELIMITER $$
DROP PROCEDURE IF EXISTS add_user$$
CREATE PROCEDURE add_user(
	IN fName VARCHAR(15), IN lName VARCHAR(15), IN email VARCHAR(30), IN dob DATE,
	IN gender VARCHAR(10), IN bio TEXT, IN boss_id INT, IN phoneType VARCHAR(10), IN phoneNumber VARCHAR(20)
) 
BEGIN
	DECLARE newUserID INT;
	INSERT INTO user VALUES (NULL, fName, lName, email, dob, 1, gender, bio, NOW(), boss_id);
	SET newUserID = 50;
	INSERT INTO phone_book VALUES (phoneType, phoneNumber, newUserID);
END;$$
DELIMITER ;

CALL add_user('John', 'Doe', 'jdoe@example.com', '2005-07-03', 'Male', 'I am John Doe!', 1, 'Home', '+372 55544488');
----------------------------------
DELIMITER $$
DROP PROCEDURE IF EXISTS add_user$$
CREATE PROCEDURE add_user(
	IN fName VARCHAR(15), IN lName VARCHAR(15), IN email VARCHAR(30), IN dob DATE,
	IN gender VARCHAR(10), IN bio TEXT, IN phoneType VARCHAR(10), IN phoneNumber VARCHAR(20)
) 
BEGIN
	DECLARE newUserID INT;

	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		RESIGNAL;
	END;

	START TRANSACTION;

	INSERT INTO user VALUES (NULL, fName, lName, email, dob, 1, gender, bio, NOW());
	INSERT INTO phone_book VALUES (phoneType, phoneNumber, last_insert_id());
	
	COMMIT;
END;$$
DELIMITER ;

CALL add_user2('John', 'Wick', 'jwick@example.com', '1973-05-22', 'Male', 'I am John Wick!', 'Mobile', '001-305-387-3969');
----------------------------------

DELIMITER $$
CREATE PROCEDURE add_user(
	IN fName VARCHAR(15), IN lName VARCHAR(15), IN email VARCHAR(30), IN dob DATE,
	IN gender VARCHAR(10), IN bio TEXT, IN phoneType VARCHAR(10), IN phoneNumber VARCHAR(20)
) 
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		RESIGNAL;
	END;

	START TRANSACTION;

	INSERT INTO user VALUES (NULL, fName, lName, email, dob, 1, gender, bio, NOW());
	INSERT INTO phone_book VALUES (phoneType, phoneNumber, last_insert_id());

	COMMIT;
END;$$
DELIMITER ;

ALTER TABLE phone_book DROP FOREIGN KEY <name_of_fk>;
ALTER TABLE phone_book DROP INDEX <name_of_fk>;
ALTER TABLE phone_book ADD CONSTRAINT <name_of_fk> FOREIGN KEY (user_id) REFERENCES user(user_id) ON UPDATE CASCADE;


CALL add_user('John', 'Wick', 'jwick@example.com', '1973-05-22', 'Male', 'I am John Wick!','Mobile', '001-305-387-3969');
CALL add_user('Lara', 'Croft', 'lcroft@example.com', '1997-11-12', 'Male', NULL,'Work', '001-305-387-3969');
CALL add_user('Neo', 'The One', 'andersonk@example.com', '1982-01-01', 'Male', 'My name is NOT Mr. Anderson, my name is NEO!', 'Work', '001-405-132-8546');
