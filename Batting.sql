-- FOREIGN KEY `fk_Batting_Teams`;
-- FOREIGN KEY `fk_Batting_Master`;

ALTER TABLE `Batting` ADD INDEX `idx_Batting_Master` (`playerID`) USING BTREE;
ALTER TABLE `Batting` ADD INDEX `idx_Batting_Teams` (`yearID`, `lgID`, `teamID`) USING BTREE;


DELETE Batting 
FROM Batting
  INNER JOIN
  (SELECT Batting.playerID
   FROM Batting
     LEFT JOIN `Master`
       ON Batting.playerID = `Master`.`playerID`
   WHERE `Master`.playerID IS NULL
  ) AS X
    ON Batting.playerID = X.playerID;


DELETE Batting
 FROM Batting
  INNER JOIN
  (SELECT
     Batting.yearID,
     Batting.lgID,
     Batting.teamID
   FROM
     Batting
     LEFT JOIN Teams
       ON Batting.yearID = Teams.yearID AND Batting.lgID = Teams.lgID AND Batting.teamID = Teams.teamID
   WHERE Teams.yearID IS NULL OR Teams.lgID IS NULL OR Teams.teamID IS NULL
  ) AS X
    ON Batting.yearID = X.yearID AND Batting.lgID = X.lgID AND Batting.teamID = X.teamID;


ALTER TABLE `Batting` ADD CONSTRAINT `fk_Batting_Teams` FOREIGN KEY (`yearID`, `lgID`, `teamID`) REFERENCES `Teams` (`yearID`, `lgID`, `teamID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

ALTER TABLE `Batting` ADD CONSTRAINT `fk_Batting_Master` FOREIGN KEY (`playerID`) REFERENCES `Master` (`playerID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

