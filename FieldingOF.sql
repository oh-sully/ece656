-- FOREIGN KEY `fk_FieldingOF_Master`;
-- FOREIGN KEY `fk_FieldingOF_Batting`;

ALTER TABLE `FieldingOF` ADD INDEX `idx_FieldingOF_Master` (`playerID`) USING BTREE;
ALTER TABLE `FieldingOF` ADD INDEX `idx_FieldingOF_Batting` (`playerID`, `yearID`, `stint`) USING BTREE;

DELETE FieldingOF FROM FieldingOF
  INNER JOIN
  (SELECT FieldingOF.playerID
   FROM FieldingOF
     LEFT JOIN `Master`
       ON FieldingOF.playerID = `Master`.`playerID`
   WHERE `Master`.playerID IS NULL
  ) AS X
    ON FieldingOF.playerID = X.playerID;


DELETE FieldingOF FROM FieldingOF
  INNER JOIN
  (SELECT
     FieldingOF.playerID,
     FieldingOF.yearID,
     FieldingOF.stint
   FROM
     FieldingOF
     LEFT JOIN Batting
       ON FieldingOF.playerID = Batting.playerID AND FieldingOF.yearID = Batting.yearID AND FieldingOF.stint = Batting.stint
   WHERE Batting.playerID IS NULL OR Batting.yearID IS NULL OR Batting.stint IS NULL
  ) AS X
    ON FieldingOF.playerID = X.playerID AND FieldingOF.yearID = X.yearID AND FieldingOF.stint = X.stint;


ALTER TABLE `FieldingOF` ADD CONSTRAINT `fk_FieldingOF_Master` FOREIGN KEY (`playerID`) REFERENCES `Master` (`playerID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

ALTER TABLE `FieldingOF` ADD CONSTRAINT `fk_FieldingOF_Batting` FOREIGN KEY (`playerID`, `yearID`, `stint`) REFERENCES `Batting` (`playerID`, `yearID`, `stint`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;