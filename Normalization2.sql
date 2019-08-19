DROP DATABASE IF EXISTS sda_join;
CREATE DATABASE sda_join;
USE sda_join;
CREATE TABLE female_name(
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(15) NOT NULL
);
CREATE TABLE male_name(
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(15) NOT NULL
);
INSERT INTO female_name (name) VALUES ('Ann'), ('Lucy'), ('Jessy'), ('Monika'), ('Gwen');
INSERT INTO male_name (name) VALUES ('Ricky'), ('Mike'), ('Josh'), ('Paul'), ('Steve');

-- CROSS JOIN and JOIN is the same thing
-- correct way CROSS JOIN
SELECT x.name female_name, m.name male_name FROM female_name x CROSS JOIN male_name m;
-- incorrect way JOIN
SELECT f.name female_name, m.name male_name FROM female_name f JOIN male_name m;

USE sda_normalization;
SELECT * FROM sda_normalization.user;
SELECT * FROM user INNER JOIN phone_book ON user.user_id = phone_book.user_id;

USE sda_join;
CREATE TABLE car(
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(15) NOT NULL,
    user_id INT NOT NULL,
    CONSTRAINT male_name_car_fk FOREIGN KEY (user_id) REFERENCES male_name(id) ON UPDATE CASCADE
);
INSERT INTO car (name, user_id) VALUES ('Jaguar', 1), ('Range Rover', 1), ('Jaguar', 2), ('Ferrari', 2), ('lamborghini', 3),
    ('Aston Martin', 4), ('Rolls Royce', 4);
	
	SELECT DISTINCT m.name male_name, c.name car_name FROM male_name m INNER JOIN car c
	ON m.id <> c.user_id ORDER BY m.name;
	
	SELECT m.name male_name, c.name car_name FROM male_name m INNER JOIN car c
	ON m.id <> c.user_id ORDER BY m.name;
	
	SELECT m.name male_name, c.name car_name FROM male_name m INNER JOIN car c
	ON m.id <> c.user_id GROUP BY male_name, car_name ORDER BY m.name;
	
	SELECT DISTINCT m.name male_name, GROUP_CONCAT(c.name SEPARATOR ', ') car_name FROM male_name m INNER JOIN car c
	ON m.id <> c.user_id GROUP BY male_name ORDER BY m.name;
	
-- below 2 selects will give same results
USE sda_normalization;
SELECT first_name, last_name, phone_type, phone_number FROM user NATURAL JOIN phone_book;
SELECT first_name, last_name, phone_type, phone_number FROM user INNER JOIN phone_book
	ON user.user_id = phone_book.user_id;
	
USE sda_join;

SELECT DISTINCT m.name male_name, c.name car_name FROM male_name m INNER JOIN car c
	ON m.id = c.user_id ORDER BY m.name;

-- below 2 selects are same, correct way is LEFT OUTER JOIN
SELECT DISTINCT m.name male_name, c.name car_name FROM male_name m LEFT OUTER JOIN car c
	ON m.id = c.user_id ORDER BY m.name;

SELECT DISTINCT m.name male_name, c.name car_name FROM male_name m LEFT JOIN car c
	ON m.id = c.user_id ORDER BY m.name;

SELECT DISTINCT m.name male_name, c.name car_name FROM male_name m RIGHT OUTER JOIN car c
	ON m.id = c.user_id ORDER BY m.name;
	
SELECT DISTINCT m.name male_name, c.name car_name FROM car c RIGHT JOIN male_name m
	ON m.id = c.user_id ORDER BY m.name;


USE sda_normalization;
CREATE TABLE employees(
	user_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	is_boss TINYINT DEFAULT 0,
	boss_id INT NOT NULL
);

INSERT INTO employees VALUES
	(NULL, 'Pavel', 'Psecuk', 1, 1),
	(NULL, 'Pavel2', 'Psecuk2', 1, 1),
	(NULL, 'Pavel3', 'Psecuk3', 0, 2);