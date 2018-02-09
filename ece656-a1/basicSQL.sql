#1a
SELECT deptName
FROM Department
WHERE location = 'Waterloo';

#1b
SELECT count(job) as employees, job
FROM Employee
GROUP BY job
ORDER BY job;

#1c
SELECT empName, salary
FROM Employee
WHERE job = 'engineer';

#1d
SELECT AVG(salary) as avg_salary, job
FROM Employee
GROUP BY job;

#1e
SELECT COUNT(deptID) as engineer_number, deptID
FROM Employee
WHERE job = 'engineer'
GROUP BY (deptID)
ORDER BY engineer_number desc
LIMIT 1;

#1f
SELECT deptID, (num_eng_by_dept.num_eng / num_emp_by_dept.num_emp) * 100 AS percentage
FROM
	(
	SELECT deptID, COUNT(*) as num_emp 
	FROM Employee
	GROUP BY deptID
	) as num_emp_by_dept
	NATURAL JOIN
	(
	SELECT deptID, COUNT(*) as num_eng
	FROM Employee
	WHERE job = 'engineer'
	GROUP BY deptID
	) as num_eng_by_dept
ORDER BY num_eng_by_dept.num_eng/num_emp_by_dept.num_emp desc
LIMIT 1;

#2a
SELECT E.empID, empName
FROM Employee as E
LEFT OUTER JOIN Assigned as A
ON E.empID = A.empID
WHERE A.empID IS NULL;

#2b
SELECT empName, job, role
FROM Employee as E NATURAL JOIN Assigned as A
WHERE E.job <> A.role;

#2c
SELECT job, COUNT(*) AS employeeNum
FROM Employee AS E NATURAL JOIN Assigned AS A
WHERE E.job = A.role
GROUP BY job;

#2d
SELECT P.projID, SUM(E.salary) AS totSalary
FROM (Employee AS E NATURAL JOIN Assigned AS A) NATURAL JOIN Project AS P
GROUP BY proj_title;

#2e
SELECT projID, I.totSalary
FROM(
	SELECT projID, SUM(salary) AS totSalary
	FROM Employee AS E NATURAL JOIN Assigned AS A
	GROUP BY projID
	UNION
	SELECT projID, SUM(salary)
	FROM Employee AS E LEFT OUTER JOIN Assigned AS A ON E.empID = A.empID
	WHERE A.empID IS NULL
	GROUP BY projID
	) AS I 
	LEFT OUTER JOIN 
	Project AS P
	ON I.projID = P.projID;

#2f
SELECT empID, num_proj
FROM (SELECT empID, COUNT(E.empID) as num_proj
	  FROM Employee as E NATURAL JOIN Assigned as A
	  GROUP BY E.empID
	  ) AS num_proj_T
WHERE num_proj > 1;

#3a
UPDATE Employee as E
SET E.salary = E.salary * 1.10
WHERE empID in (SELECT empID FROM Assigned as A WHERE A.projID = 345);

#3b
UPDATE Employee as E NATURAL JOIN Department as D
SET E.salary = 
CASE
	WHEN D.location = 'Waterloo' THEN E.salary * 1.08
	WHEN E.job = 'janitor' THEN E.salary * 1.05
	ELSE E.salary
END;

#3c
DELETE FROM Employee
WHERE empID IN (SELECT * 
			   FROM (SELECT E.empID 
					FROM Employee AS E NATURAL JOIN Department AS D 
					WHERE D.location = 'Kitchener') AS X);

UPDATE Department AS D
SET D.location = 'Waterloo'
WHERE D.location = 'Kitchener';