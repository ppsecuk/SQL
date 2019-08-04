SELECT * FROM user;

USE sda_test;

INSERT INTO user (first_name, last_name, date_of_birth, active, gender, bio)
	VALUES ('Pavel', 'Psecuk', '2019-08-04', 1, 'Male', 'Hello'),
	('Pavel', 'Psecuk2', '2019-08-04', 1, 'Male', 'Hello');
	
INSERT INTO user VALUES(NULL, 'James', 'King', '2019-08-04', 1, 'Male', 'bla bla', NOW());

INSERT INTO user (first_name, last_name, date_of_birth, active, gender) VALUES('Laura', 'Coxx', '1990-01-01', 1, 'Female');
INSERT INTO user (first_name, last_name, date_of_birth, active, gender) VALUES('John', 'Coxx', '1990-01-01', 1, 'Male');

UPDATE user SET active = 0 WHERE last_name = 'Coxx'; /* doesn't work because multiple Coxx*/
UPDATE user SET active = 1, date_of_birth = '1999-01-01' WHERE user_id = 2;
UPDATE user SET active = 0 WHERE bio LIKE '%l%' AND user_id = 2;

DELETE FROM user WHERE user_id = 2;

TRUNCATE TABLE user;
	