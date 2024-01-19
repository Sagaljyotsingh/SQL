-- Q1
use ap;
DELIMITER //
CREATE PROCEDURE insert_glaccount
(
	account_number_param INT,
	account_description_param VARCHAR(50)
)
BEGIN
	DECLARE sql_error TINYINT DEFAULT FALSE;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET sql_error = TRUE;
	START TRANSACTION;
    
	INSERT into general_ledger_accounts
	values( account_number_param, account_description_param);
    
	IF sql_error = FALSE THEN 
		COMMIT;
	ELSE 
		ROLLBACK;
	END IF; 
    
END//

CALL insert_glaccount(633 , 'Sagal');
CALL insert_glaccount(634 , 'Sagal'); -- does not allow to add duplicate description.

-- Q2

use ap;
DELIMITER //
CREATE FUNCTION test_glaccounts_description
(
	account_description_param VARCHAR(50)
)
RETURNS int
DETERMINISTIC READS SQL DATA

BEGIN
	DECLARE description_count_var INT;
    
	SELECT count(account_description) INTO description_count_var 
    FROM general_ledger_accounts
    where account_description = account_description_param;
    
	RETURN(description_count_var); 
END//

-- drop function test_glaccounts_description;
select test_glaccounts_description('Sagaloi') as 'description_present?';



-- Q3

DELIMITER //
CREATE PROCEDURE insert_glaccount_with_test
(
	account_number_param INT,
	account_description_param VARCHAR(50)
)
BEGIN
	DECLARE sql_error TINYINT DEFAULT FALSE;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET sql_error = TRUE;
    if test_glaccounts_description(account_description_param) > 0 then
    SIGNAL SQLSTATE '23000'
    SET message_text = "Duplicate account description",
    MYSQL_ERRNO = 1062;
    END if;
    
	START TRANSACTION;
    
	INSERT into general_ledger_accounts
	values( account_number_param, account_description_param);
    
	IF sql_error = FALSE THEN 
		COMMIT;
	ELSE 
		ROLLBACK;
	END IF; 
    
END//

Call insert_glaccount_with_test(700, 'Yogi');
Call insert_glaccount_with_test(701, 'Yogi');
