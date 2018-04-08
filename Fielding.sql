-- FOREIGN KEY `fk_Fielding_Master`;
-- FOREIGN KEY `fk_Fielding_Teams`;
-- FOREIGN KEY `fk_Fielding_Batting`;

ALTER TABLE `Fielding` ADD INDEX `idx_Fielding_Master` (`playerID`) USING BTREE;
ALTER TABLE `Fielding` ADD INDEX `idx_Fielding_Teams` (`yearID`, `lgID`, `teamID`) USING BTREE;
ALTER TABLE `Fielding` ADD INDEX `idx_Fielding_Batting` (`playerID`, `yearID`, `stint`) USING BTREE;


DELETE Fielding FROM Fielding
  INNER JOIN
  (SELECT Fielding.playerID
   FROM Fielding
     LEFT JOIN `Master`
       ON Fielding.playerID = `Master`.`playerID`
   WHERE `Master`.playerID IS NULL
  ) AS X
    ON Fielding.playerID = X.playerID;


DELETE Fielding FROM Fielding
  INNER JOIN
  (SELECT
     Fielding.yearID,
     Fielding.lgID,
     Fielding.teamID
   FROM
     Fielding
     LEFT JOIN Teams
       ON Fielding.yearID = Teams.yearID AND Fielding.lgID = Teams.lgID AND Fielding.teamID = Teams.teamID
   WHERE Teams.yearID IS NULL OR Teams.lgID IS NULL OR Teams.teamID IS NULL
  ) AS X
    ON Fielding.yearID = X.yearID AND Fielding.lgID = X.lgID AND Fielding.teamID = X.teamID;

DELETE Fielding FROM Fielding
  INNER JOIN
  (SELECT
     Fielding.playerID,
     Fielding.yearID,
     Fielding.stint
   FROM
     Fielding
     LEFT JOIN Batting
       ON Fielding.playerID = Batting.playerID AND Fielding.yearID = Batting.yearID AND Fielding.stint = Batting.stint
   WHERE Batting.playerID IS NULL OR Batting.yearID IS NULL OR Batting.stint IS NULL
  ) AS X
    ON Fielding.playerID = X.playerID AND Fielding.yearID = X.yearID AND Fielding.stint = X.stint;


ALTER TABLE `Fielding` ADD CONSTRAINT `fk_Fielding_Teams` FOREIGN KEY (`yearID`, `lgID`, `teamID`) REFERENCES `Teams` (`yearID`, `lgID`, `teamID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

ALTER TABLE `Fielding` ADD CONSTRAINT `fk_Fielding_Master` FOREIGN KEY (`playerID`) REFERENCES `Master` (`playerID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

ALTER TABLE `Fielding` ADD CONSTRAINT `fk_Fielding_Batting` FOREIGN KEY (`playerID`, `yearID`, `stint`) REFERENCES `Batting` (`playerID`, `yearID`, `stint`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;