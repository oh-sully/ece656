ALTER TABLE Assigned
ADD PRIMARY KEY (empID, projID, role);

ALTER TABLE Department
ADD PRIMARY KEY (deptID);

ALTER TABLE Employee
ADD PRIMARY KEY (empID);

ALTER TABLE Project
ADD PRIMARY KEY (projID);

EXPLAIN Assigned;

EXPLAIN Department;

EXPLAIN Employee;

EXPLAIN Project;

EXPLAIN UPDATE Employee as E NATURAL JOIN Department as D
		SET E.Salary = E.Salary*1.05 
		WHERE D.location = 'Waterloo';