ALTER TABLE Assigned
ADD FOREIGN KEY (empID) REFERENCES Employee(empID);

ALTER TABLE Employee
ADD FOREIGN KEY (deptID) REFERENCES Department(deptID);

EXPLAIN Assigned;

EXPLAIN Department;

EXPLAIN Employee;

EXPLAIN Project;

EXPLAIN UPDATE Employee as E NATURAL JOIN Department as D
		SET E.Salary = E.Salary*1.05 
		WHERE D.location = 'Waterloo';