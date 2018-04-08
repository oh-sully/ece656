ALTER TABLE `Department` ADD INDEX `idx_` (`location`) USING BTREE;

EXPLAIN Assigned;

EXPLAIN Department;

EXPLAIN Employee;

EXPLAIN Project;

EXPLAIN UPDATE Employee as E NATURAL JOIN Department as D
		SET E.Salary = E.Salary*1.05 
		WHERE D.location = 'Waterloo';