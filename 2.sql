UPDATE Employee as E NATURAL JOIN Department as D
SET E.Salary = E.Salary*1.05 
WHERE D.location = 'Waterloo';