-- FOREIGN KEY `fk_Appearances_Teams`;
-- FOREIGN KEY `fk_Appearances_Master`;

ALTER TABLE `Appearances` ADD INDEX `idx_Appearances_Master` (`playerID` ) USING BTREE;
ALTER TABLE `Appearances` ADD INDEX `idx_Appearances_Teams` (`yearID`, `lgID`, `teamID`) USING BTREE;

DELETE Appearances FROM Appearances
  INNER JOIN
  (SELECT Appearances.playerID
   FROM Appearances
     LEFT JOIN `Master`
       ON Appearances.playerID = `Master`.`playerID`
   WHERE `Master`.playerID IS NULL
  ) AS X
    ON Appearances.playerID = X.playerID;


DELETE Appearances FROM Appearances
  INNER JOIN
  (SELECT
     Appearances.yearID,
     Appearances.lgID,
     Appearances.teamID
   FROM
     Appearances
     LEFT JOIN Teams
       ON Appearances.yearID = Teams.yearID AND Appearances.lgID = Teams.lgID AND Appearances.teamID = Teams.teamID
   WHERE Teams.yearID IS NULL OR Teams.lgID IS NULL OR Teams.teamID IS NULL
  ) AS X
    ON Appearances.yearID = X.yearID AND Appearances.lgID = X.lgID AND Appearances.teamID = X.teamID;


ALTER TABLE `Appearances` ADD CONSTRAINT `fk_Appearances_Teams` FOREIGN KEY (`yearID`, `lgID`, `teamID`) REFERENCES `Teams` (`yearID`, `lgID`, `teamID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

ALTER TABLE `Appearances` ADD CONSTRAINT `fk_Appearances_Master` FOREIGN KEY (`playerID`) REFERENCES `Master` (`playerID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;
