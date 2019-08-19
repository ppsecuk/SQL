/* 
	JOINS are used to query/group data from several tables into a single result set

	@author: Adombang Munang Mbomndih
*/


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


----------------------------------------------------------------------------------------------------------------
-- CARTESIAN JOIN - also called cross join, cartesian product, cross product, no join
----------------------------------------------------------------------------------------------------------------
SELECT x.name female_name, m.name male_name FROM female_name x CROSS JOIN male_name m;
SELECT f.name female_name, m.name male_name FROM female_name f JOIN male_name m;


----------------------------------------------------------------------------------------------------------------
-- INNER JOIN - same as cross join but with less rules returned due to additional filtering
----------------------------------------------------------------------------------------------------------------

-- Equijoins test for equality
USE sda_normalization;

SELECT u.first_name, u.last_name, p.phone_type, p.phone_number FROM user u 
	INNER JOIN phone_book p ON u.user_id = p.user_id;

SELECT u.first_name, u.last_name, p.phone_type, p.phone_number FROM user u 
	JOIN phone_book p ON u.user_id = p.user_id; -- ??

SELECT u.first_name, u.last_name, p.phone_type, p.phone_number FROM user u 
	INNER JOIN phone_book p; -- ??

SELECT u.first_name, u.last_name, p.phone_type, p.phone_number FROM user u 
	CROSS JOIN phone_book p ON u.user_id = p.user_id; -- ??

-- Non-equijoins test for non-equality
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
	ON m.id <> c.user_id ORDER BY m.name; -- ??

SELECT m.name male_name, c.name car_name FROM male_name m INNER JOIN car c
	ON m.id <> c.user_id ORDER BY m.name; -- ??

SELECT m.name male_name, c.name car_name FROM male_name m INNER JOIN car c
	ON m.id <> c.user_id GROUP BY male_name, car_name ORDER BY m.name; -- ??

SELECT m.name male_name, c.name car_name FROM male_name m INNER JOIN car c
	ON m.id <> c.user_id GROUP BY male_name ORDER BY m.name; -- ??


SELECT DISTINCT m.name male_name, GROUP_CONCAT(c.name SEPARATOR ', ') car_name FROM male_name m INNER JOIN car c
	ON m.id <> c.user_id GROUP BY male_name ORDER BY m.name; -- ??

-- Natural joins work like equijoins but without the need to specify a condition.
USE sda_normalization;

SELECT first_name, last_name, phone_type, phone_number FROM user NATURAL JOIN phone_book;

SELECT first_name, last_name, phone_type, phone_number FROM user INNER JOIN phone_book
	ON user.user_id = phone_book.user_id;
-- Notice that we don't always have to use aliases, as long as the column names are unique to each table


----------------------------------------------------------------------------------------------------------------
-- OUTER JOIN - includes Left Outer Join, Right Outer Join and Self Join
----------------------------------------------------------------------------------------------------------------

-- Left Outer Join returns every record from the left table even if there is no corresponding/matching record on the right table
USE sda_join;

SELECT DISTINCT m.name male_name, c.name car_name FROM male_name m INNER JOIN car c
	ON m.id = c.user_id ORDER BY m.name;

SELECT DISTINCT m.name male_name, c.name car_name FROM male_name m LEFT OUTER JOIN car c
	ON m.id = c.user_id ORDER BY m.name;

SELECT DISTINCT m.name male_name, c.name car_name FROM male_name m LEFT JOIN car c
	ON m.id = c.user_id ORDER BY m.name; -- ??

-- Right Outer Join returns every record from the right table even if there is no corresponding/matching record on the left table
SELECT DISTINCT m.name male_name, c.name car_name FROM male_name m RIGHT OUTER JOIN car c
	ON m.id = c.user_id ORDER BY m.name;

SELECT DISTINCT m.name male_name, c.name car_name FROM car c RIGHT JOIN male_name m
	ON m.id = c.user_id ORDER BY m.name; -- ??

-- Self Join uses the same table on the left and the right, effectively joining a table with itself
USE sda_normalization;

ALTER TABLE user ADD COLUMN boss_id INT,
	ADD CONSTRAINT user_boss_fk FOREIGN KEY (boss_id) REFERENCES user(user_id) ON UPDATE CASCADE;
-- Notice the use of a self-referencing foreign key (a primary key of a table reused in that same table for some other purpose)

UPDATE user SET boss_id = 1 WHERE user_id IN (1, 2, 3);
UPDATE user SET boss_id = 3 WHERE user_id = 4;
UPDATE user SET boss_id = 2 WHERE user_id = 5;




/* EXCERCISES */

-- 1) How do we select every user's first and last names together with his boss's first and last names?
-- Hint: join the table to itself
