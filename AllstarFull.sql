-- FOREIGN KEY `fk_AllstarFull_Teams`;
-- FOREIGN KEY `fk_AllstarFull_Master`;

ALTER TABLE `AllstarFull` ADD INDEX `idx_AllstarFull_Master` (`playerID`) USING BTREE;
ALTER TABLE `AllstarFull` ADD INDEX `idx_AllstarFull_Teams` (`yearID`, `lgID`, `teamID`) USING BTREE;

-- This is a sample to delete the data which are in the child table but doesn't appear in the parent table
DELETE AllstarFull FROM AllstarFull
  INNER JOIN
  (SELECT AllstarFull.playerID
   FROM AllstarFull
     LEFT JOIN `Master`
       ON AllstarFull.playerID = `Master`.`playerID`
   WHERE `Master`.playerID IS NULL
  ) AS X
    ON AllstarFull.playerID = X.playerID;


DELETE AllstarFull FROM AllstarFull
  INNER JOIN
  (SELECT
     AllstarFull.yearID,
     AllstarFull.lgID,
     AllstarFull.teamID
   FROM
     AllstarFull
     LEFT JOIN Teams
       ON AllstarFull.yearID = Teams.yearID AND AllstarFull.lgID = Teams.lgID AND AllstarFull.teamID = Teams.teamID
   WHERE Teams.yearID IS NULL OR Teams.lgID IS NULL OR Teams.teamID IS NULL
  ) AS X
    ON AllstarFull.yearID = X.yearID AND AllstarFull.lgID = X.lgID AND AllstarFull.teamID = X.teamID;


ALTER TABLE `AllstarFull` ADD CONSTRAINT `fk_AllstarFull_Teams` FOREIGN KEY (`yearID`, `lgID`, `teamID`) REFERENCES `Teams` (`yearID`, `lgID`, `teamID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

ALTER TABLE `AllstarFull` ADD CONSTRAINT `fk_AllstarFull_Master` FOREIGN KEY (`playerID`) REFERENCES `Master` (`playerID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;



