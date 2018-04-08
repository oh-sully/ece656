DELIMITER //

DROP PROCEDURE IF EXISTS payRaise //

CREATE PROCEDURE payRaise(IN inEmpID INT, IN inPercentageRaise DECIMAL(4,2), OUT errorCode INT)
BEGIN
	IF (inPercentageRaise < 0 OR inPercentageRaise > 10) THEN 
		SELECT (-1) INTO errorCode;
	ELSEIF EXISTS (SELECT empID FROM Employee WHERE empID = inEmpID) THEN 
		BEGIN
			UPDATE Employee
			SET salary = salary * (1 + inPercentageRaise/100)
			WHERE empID = inEmpID;
			SELECT (0) INTO errorCode;
			END ;
	ELSE 
		SELECT (-2) INTO errorCode;
	END IF;

END //

DELIMITER ;

SET @inEmpID = 23, @inPercentageRaise = 5;

CALL payRaise(@inEmpID, @inPercentageRaise, @errorCode);

SELECT @errorCode;