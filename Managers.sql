-- FOREIGN KEY `fk_Managers_Teams`;
-- FOREIGN KEY `fk_Managers_Master`;

ALTER TABLE `Managers` ADD INDEX `idx_Managers_Master` (`playerID` ) USING BTREE;
ALTER TABLE `Managers` ADD INDEX `idx_Managers_Teams` (`yearID`, `lgID`, `teamID`) USING BTREE;

DELETE Managers FROM Managers
  INNER JOIN
  (SELECT Managers.playerID
   FROM Managers
     LEFT JOIN `Master`
       ON Managers.playerID = `Master`.`playerID`
   WHERE `Master`.playerID IS NULL
  ) AS X
    ON Managers.playerID = X.playerID;


DELETE Managers FROM Managers
  INNER JOIN
  (SELECT
     Managers.yearID,
     Managers.lgID,
     Managers.teamID
   FROM
     Managers
     LEFT JOIN Teams
       ON Managers.yearID = Teams.yearID AND Managers.lgID = Teams.lgID AND Managers.teamID = Teams.teamID
   WHERE Teams.yearID IS NULL OR Teams.lgID IS NULL OR Teams.teamID IS NULL
  ) AS X
    ON Managers.yearID = X.yearID AND Managers.lgID = X.lgID AND Managers.teamID = X.teamID;


ALTER TABLE `Managers` ADD CONSTRAINT `fk_Managers_Teams` FOREIGN KEY (`yearID`, `lgID`, `teamID`) REFERENCES `Teams` (`yearID`, `lgID`, `teamID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

ALTER TABLE `Managers` ADD CONSTRAINT `fk_Managers_Master` FOREIGN KEY (`playerID`) REFERENCES `Master` (`playerID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;


