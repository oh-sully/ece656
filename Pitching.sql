-- FOREIGN KEY `fk_Pitching_Teams`;
-- FOREIGN KEY `fk_Pitching_Master`;

ALTER TABLE `Pitching` ADD INDEX `idx_Pitching_Master` (`playerID`) USING BTREE;
ALTER TABLE `Pitching` ADD INDEX `idx_Pitching_Teams` (`yearID`, `lgID`, `teamID`) USING BTREE;


DELETE Pitching FROM Pitching
  INNER JOIN
  (SELECT Pitching.playerID
   FROM Pitching
     LEFT JOIN `Master`
       ON Pitching.playerID = `Master`.`playerID`
   WHERE `Master`.playerID IS NULL
  ) AS X
    ON Pitching.playerID = X.playerID;


DELETE Pitching FROM Pitching
  INNER JOIN
  (SELECT
     Pitching.yearID,
     Pitching.lgID,
     Pitching.teamID
   FROM
     Pitching
     LEFT JOIN Teams
       ON Pitching.yearID = Teams.yearID AND Pitching.lgID = Teams.lgID AND Pitching.teamID = Teams.teamID
   WHERE Teams.yearID IS NULL OR Teams.lgID IS NULL OR Teams.teamID IS NULL
  ) AS X
    ON Pitching.yearID = X.yearID AND Pitching.lgID = X.lgID AND Pitching.teamID = X.teamID;


ALTER TABLE `Pitching` ADD CONSTRAINT `fk_Pitching_Teams` FOREIGN KEY (`yearID`, `lgID`, `teamID`) REFERENCES `Teams` (`yearID`, `lgID`, `teamID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

ALTER TABLE `Pitching` ADD CONSTRAINT `fk_Pitching_Master` FOREIGN KEY (`playerID`) REFERENCES `Master` (`playerID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

