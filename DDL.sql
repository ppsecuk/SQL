CREATE DATABASE IF NOT EXISTS sda_test;
USE sda_test;
SELECT DATABASE();


CREATE TABLE user(
	user_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	first_name VARCHAR(15) NOT NULL,
	last_name VARCHAR(15) NOT NULL,
	age INT,
	active TINYINT NOT NULL, /*TINYINT is like boolean 1/0 */
	gender enum('Male', 'Female') NOT NULL,
	bio TEXT,
	started_on datetime DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE user DROP COLUMN bio;
ALTER TABLE user ADD COLUMN bio TEXT NOT NULL;
ALTER TABLE user CHANGE first_name fName VARCHAR(50) NOT NULL;
/*ALTER TABLE user RENAME COLUMN bio TO biography;*/
ALTER TABLE user CHANGE bio biography TEXT;
ALTER TABLE user CHANGE age date_of_birth DATE;
SHOW COLUMNS FROM user;
ALTER TABLE user MODIFY gender enum('Male', 'Female', 'Other') NOT NULL;

RENAME TABLE user TO users;

SHOW COLUMNS FROM sda_test;

DROP TABLE users;
DROP TABLE IF EXISTS users;
DROP DATABASE IF EXISTS sda_test;