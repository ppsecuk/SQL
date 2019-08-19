/* 
	SECURITY
	
	NB: DCL stands for Data Control Language. It is used mostly for handling rights, permissions and other controls of the database system.

	@author: Adombang Munang Mbomndih
*/


----------------------------------------------------------------------------------------------------------------
-- SET PASSWORD
----------------------------------------------------------------------------------------------------------------
SET PASSWORD FOR 'root'@'localhost' = PASSWORD('superStrongPasswor:)');

----------------------------------------------------------------------------------------------------------------
-- ADD NEW USER
----------------------------------------------------------------------------------------------------------------
CREATE USER 'leo'@'localhost' IDENTIFIED WITH mysql_native_password BY 'passwordForLeo';

CREATE USER 'lucy'@'localhost' IDENTIFIED WITH sha256_password BY 'passwordForLucy',
	'Mike'@'localhost' IDENTIFIED WITH mysql_native_password BY 'passwordForLucy';

----------------------------------------------------------------------------------------------------------------
-- GRANT USER RIGHTS
----------------------------------------------------------------------------------------------------------------
GRANT SELECT ON sda_normalization.user TO 'leo'@'localhost';
GRANT SELECT, INSERT ON sda_normalization.hobby TO 'leo'@'localhost', 'lucy'@'localhost';

GRANT ALL ON sda_normalization.phone_book TO 'leo'@'localhost';

----------------------------------------------------------------------------------------------------------------
-- REVOKE USER RIGHTS
----------------------------------------------------------------------------------------------------------------
REVOKE SELECT ON sda_normalization.user FROM 'leo'@'localhost';
REVOKE SELECT, INSERT ON sda_normalization.hobby FROM 'leo'@'localhost', 'lucy'@'localhost';

REVOKE GRANT OPTION ON DELETE ON sda_normalization.phone_book FROM 'leo'@'localhost' CASCADE;
REVOKE ALL ON sda_normalization.phone_book FROM 'leo'@'localhost' RESTRICT;
