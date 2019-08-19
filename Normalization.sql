DROP DATABASE IF EXISTS sda_normalization;
CREATE DATABASE sda_normalization;
USE sda_normalization;

CREATE TABLE user(
	user_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	first_name VARCHAR(15) NOT NULL,
	last_name VARCHAR(15) NOT NULL,
	email VARCHAR(50) NOT NULL,
	date_of_birth DATE,
	active TINYINT DEFAULT 1,
	gender ENUM('Male', 'Female') NOT NULL,
	biography TEXT,
	hobbies VARCHAR(255) NOT NULL,
	country VARCHAR(50) NOT NULL,
	city VARCHAR (50) NOT NULL,
	address VARCHAR(50) NOT NULL,
	mobile_number VARCHAR(20),
	home_number VARCHAR(20),
	work_number VARCHAR(20),
	started_on DATETIME DEFAULT CURRENT_TIMESTAMP
);


INSERT INTO user VALUES
    (
        NULL, 'Rick', 'Martins', 'rmartins@example.com', '1994-01-08', 1, 'Male', 'I am awesome!',
        'Music, Hiking, Biking', 'USA', 'Miami', '22nd St and Lucerne Ave, Miami Beach, FL', '001-305-387-3969',
        NULL, NULL, '2018-05-22 18:30:00'
    ),
    (
        NULL, 'James', 'King', 'jking@example.com', '1985-06-02', 1, 'Male', 'I love animals and sci-fi movies',
        'Partying, Reading, Biking', 'USA', 'Miami', '29th St and Lucerne Ave, Miami Beach, FL', NULL,
        '001-305-366-4587', NULL, NULL
    ),
    (
        NULL, 'Laura', 'Coxx', 'lcoxx@example.com', '2002-03-19', 1, 'Female', NULL,
        'Music, Traveling', 'Canada', 'Toronto', 'Dj Nour 22 Grangemill Cr Toronto', NULL,
        NULL, '001-405-132-8546', '2017-08-02 11:03:51'
    ),
    (
        NULL, 'Alan', 'Coxx', 'acoxx@example.com', '2002-03-19', 1, 'Male', NULL,
        'Video games, Running', 'Canada', 'Toronto', 'Dj Nour 22 Grangemill Cr Toronto', NULL,
        NULL, '001-405-132-8546', '2017-08-02 11:15:33'
    ),
    (
        NULL, 'Mary', 'Jacobs', 'mary-j@example.com', '1973-07-23', 1, 'Female', NULL,
        'Singing, Music', 'Estonia', 'Tallinn', 'Endla 23', '+372 5645 8795',
        NULL, NULL, '2017-08-02 11:03:51'
    );

UPDATE user
SET hobbies = 'Music, Hiking, Biking, Dancing'
WHERE user_id = 1;

UPDATE user
SET hobbies = 'Music, Hiking, Dancing'
WHERE user_id = 1;
    
CREATE TABLE user_new(user_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT) AS
	SELECT user_id, first_name, last_name, email, date_of_birth, active, gender, biography, country, city, address, started_on
	FROM user;
	
RENAME TABLE user TO user_old;
RENAME TABLE user_new TO user;

CREATE TABLE phone_book (
	phone_type ENUM('Mobile', 'Home', 'Work') NOT NULL,
	phone_number VARCHAR(20) NOT NULL,
	user_id INT NOT NULL,
	CONSTRAINT user_phone_book_fk FOREIGN KEY(user_id) REFERENCES user(user_id) ON UPDATE CASCADE,
	PRIMARY KEY(user_id, phone_number)
);

CREATE TABLE hobby (
	user_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	hobby VARCHAR(15) NOT NULL UNIQUE
);

CREATE TABLE user_hobby (
	user_id INT NOT NULL,
	hobby_id INT NOT NULL,
	CONSTRAINT user_user_hobby_fk FOREIGN KEY(user_id) REFERENCES user(user_id) ON UPDATE CASCADE,
	CONSTRAINT hobby_user_hobby_fk FOREIGN KEY(hobby_id) REFERENCES hobby(hobby_id) ON UPDATE CASCADE,
	PRIMARY KEY(user_id, hobby_id)
);

INSERT INTO phone_book VALUES
    ('Mobile', '001-305-387-3969', 1),
    ('Home', '001-305-366-4587', 2),
    ('Work', '001-305-387-3969', 3),
    ('Work', '001-405-132-8546', 4),
    ('Mobile', '+372 5645 8795', 5);
-- Inserting records with foreign key (many-to-many mapping)
INSERT INTO hobby (hobby) VALUES ('Music'), ('Hiking'), ('Biking'),
    ('Partying'), ('Reading'), ('Traveling'), ('Video games'), ('Running'), ('Singing');
	
CREATE TABLE user_new(user_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT) AS
	SELECT user_id, first_name, last_name, email, date_of_birth, active, gender, biography, started_on
	FROM user;
	
RENAME TABLE user TO user_old2;
RENAME TABLE user_new TO user;

CREATE TABLE country SELECT DISTINCT country FROM user_old2;
CREATE TABLE city SELECT DISTINCT city FROM user_old2;

SELECT * FROM country JOIN city ON country.country_id = city.country_id;

SELECT * FROM user;
SELECT * FROM user_new;
SELECT * FROM user_old;
SELECT * FROM user_old2;