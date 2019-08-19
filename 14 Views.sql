/* 
	A VIEW is the result of a query stored as a separate table

	@author: Adombang Munang Mbomndih
*/

CREATE VIEW employee_view_without_salary AS
SELECT employee_id, first_name, last_named, email, date_of_birth, active, gender FROM employee;

SELECT * from employee_view_without_salary;

DROP DATABASE IF EXISTS sda_views_db;
CREATE DATABASE sda_views_db;
USE sda_views_db;

CREATE TABLE employee(
	employee_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	first_name VARCHAR(15) NOT NULL,
	last_name VARCHAR(15) NOT NULL,
	email VARCHAR(50) NOT NULL,
	date_of_birth DATE NOT NULL,
	active TINYINT DEFAULT 1,
	gender ENUM('Male', 'Female', 'Other') NOT NULL,
	gross_salary INT NOT NULL,
	employed_on DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO employee VALUES 
	(NULL, 'Rick', 'Martins', 'rmartins@example.com', '1994-01-08', 1, 'Male', 5000, '2018-05-22 18:30:00'),
	(NULL, 'James', 'King', 'jking@example.com', '1985-06-02', 1, 'Male', 3000, NULL),
	(NULL, 'Laura', 'Coxx', 'lcoxx@example.com', '2002-03-19', 1, 'Female',1800 ,'2017-08-02 11:03:51'),
	(NULL, 'Alan', 'Coxx', 'acoxx@example.com', '2002-03-19', 1, 'Male', 1200, '2017-08-02 11:15:33'),
	(NULL, 'Mary', 'Jacobs', 'mary-j@example.com', '1973-07-23', 1, 'Female', 800, '2017-08-02 11:03:51');


----------------------------------------------------------------------------------------------------------------
-- VIEWS
----------------------------------------------------------------------------------------------------------------

-- Create a view from our employee table

CREATE VIEW employee_view_without_salary AS 
	SELECT employee_id, first_name, last_name, email, date_of_birth, active, gender FROM user;

-- Verify content of employee_view_without_salary view
SELECT * FROM employee_view_without_salary;

-- Create a new user and grant read rights on the employee_view_without_salary view

CREATE USER 'Monika'@'localhost' IDENTIFIED WITH mysql_native_password BY 'passwordForMonika';
GRANT SELECT ON sda_views_db.employee_view_without_salary TO 'Monika'@'localhost';
