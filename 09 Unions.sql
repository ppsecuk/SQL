/* 
	UNIONS combine result sets from separate queries/tables which are not necessarily connected with foreign keys

	@author: Adombang Munang Mbomndih
*/


USE sda_join;


----------------------------------------------------------------------------------------------------------------
-- UNION - unions concatenate/append one result set before/after another
----------------------------------------------------------------------------------------------------------------
INSERT INTO male_name VALUES (NULL, 'Jessy');

SELECT name FROM female_name
UNION
SELECT name FROM male_name;

SELECT name FROM female_name
UNION
SELECT name FROM male_name ORDER BY name; -- ??


----------------------------------------------------------------------------------------------------------------
-- UNION ALL - used to allow duplicates in the result set
----------------------------------------------------------------------------------------------------------------
INSERT INTO female_name (name) VALUES ('Josh');
INSERT INTO male_name (name) VALUES ('Jessy');

SELECT name FROM female_name
UNION
SELECT name FROM male_name  ORDER BY name;

SELECT name FROM female_name
UNION ALL
SELECT name FROM male_name ORDER BY name;

-- NB: You can unite as many result sets as you want...you are not limited to two result sets





/* EXCERCISES */

-- 1) Can you unite result sets from the same table?
