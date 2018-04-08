DELIMITER //

DROP PROCEDURE IF EXISTS payRaise //
DROP PROCEDURE IF EXISTS salaryCheck //

CREATE PROCEDURE payRaise(IN inEmpID INT, IN inPercentageRaise DECIMAL(4,2), OUT errorCode INT)
BEGIN
	IF (inPercentageRaise < 0 OR inPercentageRaise > 10) THEN 
		SELECT (-1) INTO errorCode;
	ELSEIF EXISTS (SELECT empID FROM Employee WHERE empID = inEmpID) THEN 
		BEGIN
			DECLARE empSal INT;
			SELECT salary INTO empSal
			FROM Employee
			WHERE empID = inEmpID;
			IF (empSal * (1 + inPercentageRaise/100) > 100000) THEN
				SELECT (-3) INTO errorCode;
			ELSE
				UPDATE Employee
				SET salary = salary * (1 + inPercentageRaise/100)
				WHERE empID = inEmpID;
				SELECT (0) INTO errorCode;
			END IF;
		END ;
	ELSE 
		SELECT (-2) INTO errorCode;
	END IF;

END; //




CREATE PROCEDURE salaryCheck()
BEGIN
	IF (EXISTS(SELECT empID 
	FROM Employee NATURAL JOIN Department 
	WHERE Department.location = 'Kitchener' AND Employee.salary > 100000) 
	) THEN
		ROLLBACK;
	ELSE
		COMMIT;
	END IF;

END; //

DELIMITER ;

SET @inEmpID = 92, @inPercentageRaise = 0;

-- INSERT INTO Employee VALUES (99, "Sully", "intern", 13, 99000);

SET autocommit = 0;
	UPDATE Employee
	SET Salary = Salary*1.03
	WHERE empID IN (SELECT empID FROM (SELECT empID FROM Employee NATURAL JOIN Department WHERE location = 'Kitchener') as eID);
	CALL salaryCheck();
SET autocommit = 1;

CALL payRaise(@inEmpID, @inPercentageRaise, @errorCode);

SELECT @errorCode;