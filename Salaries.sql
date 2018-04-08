-- FOREIGN KEY `fk_Salaries_Teams`;
-- FOREIGN KEY `fk_Salaries_Master`;

ALTER TABLE `Salaries` ADD INDEX `idx_Salaries_Master` (`playerID`) USING BTREE;
ALTER TABLE `Salaries` ADD INDEX `idx_Salaries_Teams` (`yearID`, `lgID`, `teamID`) USING BTREE;

DELETE Salaries FROM Salaries
  INNER JOIN
  (SELECT Salaries.playerID
   FROM Salaries
     LEFT JOIN `Master`
       ON Salaries.playerID = `Master`.`playerID`
   WHERE `Master`.playerID IS NULL
  ) AS X
    ON Salaries.playerID = X.playerID;


DELETE Salaries FROM Salaries
  INNER JOIN
  (SELECT
     Salaries.yearID,
     Salaries.lgID,
     Salaries.teamID
   FROM
     Salaries
     LEFT JOIN Teams
       ON Salaries.yearID = Teams.yearID AND Salaries.lgID = Teams.lgID AND Salaries.teamID = Teams.teamID
   WHERE Teams.yearID IS NULL OR Teams.lgID IS NULL OR Teams.teamID IS NULL
  ) AS X
    ON Salaries.yearID = X.yearID AND Salaries.lgID = X.lgID AND Salaries.teamID = X.teamID;


ALTER TABLE `Salaries` ADD CONSTRAINT `fk_Salaries_Teams` FOREIGN KEY (`yearID`, `lgID`, `teamID`) REFERENCES `Teams` (`yearID`, `lgID`, `teamID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

ALTER TABLE `Salaries` ADD CONSTRAINT `fk_Salaries_Master` FOREIGN KEY (`playerID`) REFERENCES `Master` (`playerID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;