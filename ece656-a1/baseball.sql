#1a
SELECT COUNT(*) as playerCount
FROM Master
WHERE birthDay IS NULL;

#1b
SELECT ((SELECT COUNT(Distinct HF.playerID) 
		FROM Master AS M NATURAL JOIN HallOfFame AS HF
		WHERE M.deathYear IS NULL
		AND HF.inducted = 'Y')
		- 
		(SELECT COUNT(Distinct HF.playerID)
		FROM Master AS M NATURAL JOIN HallOfFame AS HF
		WHERE M.deathYear IS NOT NULL
		AND HF.inducted = 'Y'))
		AS alive_dead;

#1c
SELECT nameFirst, nameLast, totalPay
FROM (SELECT M.playerID, nameFirst, nameLast, SUM(salary) as totalPay
	  FROM Master as M NATURAL JOIN Salaries as S
	  GROUP BY M.playerID
	  ORDER BY totalPay desc) as ptotsal
LIMIT 1;

#1d
SELECT 
	((SELECT SUM(HR) FROM Batting) 
	/ 
	(SELECT COUNT(Distinct playerID) FROM Batting as B WHERE B.HR IS NOT NULL)) as averageHR;

#1e
SELECT 
	(SELECT SUM(HR) FROM Batting) 
	/ 
	(SELECT COUNT(Distinct playerID) FROM Batting as B WHERE B.HR > 0) AS averageHR;

#1f
CREATE VIEW avghr AS
SELECT 
	(SELECT SUM(HR) FROM Batting) 
	/ 
	(SELECT COUNT(Distinct playerID) FROM Batting as B WHERE B.HR IS NOT NULL) AS averageHR;

CREATE VIEW avgsho AS
SELECT 
	(SELECT SUM(sho) FROM Pitching)
	/
	(SELECT COUNT(Distinct playerID) FROM Pitching AS P) AS averagesho;

SELECT COUNT(Distinct B.playerID) as playerCount
FROM (SELECT playerID, SUM(HR) as totHR FROM Batting GROUP BY playerID) AS B 
	INNER JOIN 
	(SELECT playerID, SUM(sho) as totsho FROM Pitching GROUP BY playerID) AS P 
	ON B.playerID=P.playerID
WHERE (B.totHR > (SELECT * FROM avghr)) AND (P.totsho > (SELECT * FROM avgsho));

#2
LOAD DATA LOCAL INFILE 'Fielding.csv'
INTO TABLE Fielding
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n';