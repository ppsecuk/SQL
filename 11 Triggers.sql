/* 
	TRIGGERS are stored programs executed automatically in response to specified evente (INSERTS, UPDATES, DELETES).

	@author: Adombang Munang Mbomndih
*/


USE sda_routine;

DROP TABLE IF EXISTS user_history;

CREATE TABLE user_history (
	history_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
	type_of_modification ENUM('U', 'D') NOT NULL,
	modified_by VARCHAR(255),
	date_modified DATETIME DEFAULT CURRENT_TIMESTAMP
) SELECT * FROM user;

TRUNCATE TABLE user_history;
ALTER TABLE user_history MODIFY modified_by VARCHAR(255) NOT NULL;


----------------------------------------------------------------------------------------------------------------
-- TRIGGERS
----------------------------------------------------------------------------------------------------------------
DELIMITER |
DROP TRIGGER IF EXISTS add_to_history_after_update|
CREATE TRIGGER add_to_history_after_update AFTER UPDATE ON user FOR EACH ROW
BEGIN
	INSERT INTO user_history
	(
		user_id, first_name, last_name, email, date_of_birth, active, gender, biography, 
		started_on, salary, type_of_modification, modified_by
	) 
	VALUES (
		OLD.user_id, OLD.first_name, OLD.last_name, OLD.email, OLD.date_of_birth, 
		OLD.active, OLD.gender, OLD.biography, OLD.started_on, OLD.salary, 'U', SESSION_USER()
	);
END;|
DELIMITER ;

DELIMITER |
DROP TRIGGER IF EXISTS add_to_history_after_delete|
CREATE TRIGGER add_to_history_after_delete AFTER DELETE ON user FOR EACH ROW
BEGIN
	INSERT INTO user_history
	(
		user_id, first_name, last_name, email, date_of_birth, active, gender, biography, 
		started_on, salary, type_of_modification, modified_by
	) 
	VALUES (
		OLD.user_id, OLD.first_name, OLD.last_name, OLD.email, OLD.date_of_birth, 
		OLD.active, OLD.gender, OLD.biography, OLD.started_on, OLD.salary, 'D', SESSION_USER()
	);
END;|
DELIMITER ;

DELIMITER $$
DROP TRIGGER IF EXISTS add_user_filter $$
CREATE TRIGGER add_user_filter BEFORE INSERT ON user FOR EACH ROW
BEGIN

	IF EXISTS (
	SELECT * FROM user WHERE first_name = NEW.first_name AND last_name = NEW.last_name AND email = NEW.email 
		AND date_of_birth = NEW.date_of_birth AND active = NEW.active AND gender = NEW.gender
		AND biography = NEW.biography AND salary = NEW.salary)
	THEN
	 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'You cannot insert duplicate users!';
	END IF;

END;$$
DELIMITER ;

-- NB:
-- You can optimize the two triggers above by splitting out the common logic into a Stored Procedure
-- and then call that procedure within each trigger.

DELIMITER |
DROP TRIGGER IF EXISTS valide_before_update|
CREATE TRIGGER valide_salary_before_update BEFORE UPDATE ON user FOR EACH ROW
BEGIN
	IF NEW.salary > (0.3 * OLD.salary) + OLD.salary THEN 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'You cannot raise salary by more than 30%';
	END IF;
END;|
DELIMITER ;

UPDATE user SET salary = 400000 WHERE user_id = 3; -- ??
UPDATE user SET salary = 130000 WHERE user_id = 3; -- ??
