-- FOREIGN KEY `fk_ManagersHalf_Teams`;
-- FOREIGN KEY `fk_ManagersHalf_Master`;

ALTER TABLE `ManagersHalf` ADD INDEX `idx_ManagersHalf_Master` (`playerID` ) USING BTREE;
ALTER TABLE `ManagersHalf` ADD INDEX `idx_ManagersHalf_Teams` (`yearID`, `lgID`, `teamID`) USING BTREE;

DELETE ManagersHalf FROM ManagersHalf
  INNER JOIN
  (SELECT ManagersHalf.playerID
   FROM ManagersHalf
     LEFT JOIN `Master`
       ON ManagersHalf.playerID = `Master`.`playerID`
   WHERE `Master`.playerID IS NULL
  ) AS X
    ON ManagersHalf.playerID = X.playerID;


DELETE ManagersHalf FROM ManagersHalf
  INNER JOIN
  (SELECT
     ManagersHalf.yearID,
     ManagersHalf.lgID,
     ManagersHalf.teamID
   FROM
     ManagersHalf
     LEFT JOIN Teams
       ON ManagersHalf.yearID = Teams.yearID AND ManagersHalf.lgID = Teams.lgID AND ManagersHalf.teamID = Teams.teamID
   WHERE Teams.yearID IS NULL OR Teams.lgID IS NULL OR Teams.teamID IS NULL
  ) AS X
    ON ManagersHalf.yearID = X.yearID AND ManagersHalf.lgID = X.lgID AND ManagersHalf.teamID = X.teamID;


ALTER TABLE `ManagersHalf` ADD CONSTRAINT `fk_ManagersHalf_Teams` FOREIGN KEY (`yearID`, `lgID`, `teamID`) REFERENCES `Teams` (`yearID`, `lgID`, `teamID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

ALTER TABLE `ManagersHalf` ADD CONSTRAINT `fk_ManagersHalf_Master` FOREIGN KEY (`playerID`) REFERENCES `Master` (`playerID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;