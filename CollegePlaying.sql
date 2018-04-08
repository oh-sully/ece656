-- PRIMARY KEY `pk_CollegePlaying`;
-- FOREIGN KEY `fk_CollegePlaying_Master`;
-- FOREIGN KEY `fk_CollegePlaying_Schools`;

ALTER TABLE `CollegePlaying` ADD CONSTRAINT `pk_CollegePlaying` PRIMARY KEY (`playerID`, `schoolID`, `yearID`);
ALTER TABLE `CollegePlaying` ADD INDEX `idx_CollegePlaying_Master` (`playerID`) USING BTREE;
ALTER TABLE `CollegePlaying` ADD INDEX `idx_CollegePlaying_Schools` (`schoolID`) USING BTREE;


DELETE CollegePlaying FROM CollegePlaying
  INNER JOIN
  (SELECT CollegePlaying.playerID
   FROM CollegePlaying
     LEFT JOIN `Master`
       ON CollegePlaying.playerID = `Master`.`playerID`
   WHERE `Master`.playerID IS NULL
  ) AS X
    ON CollegePlaying.playerID = X.playerID;


DELETE CollegePlaying FROM CollegePlaying
  INNER JOIN
  (SELECT CollegePlaying.schoolID
   FROM CollegePlaying
     LEFT JOIN `Master`
       ON CollegePlaying.schoolID = `Master`.`schoolID`
   WHERE `Master`.schoolID IS NULL
  ) AS X
    ON CollegePlaying.schoolID = X.schoolID;


ALTER TABLE `CollegePlaying` ADD CONSTRAINT `fk_CollegePlaying_Schools` FOREIGN KEY (`schoolID`) REFERENCES `Master` (`schoolID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

ALTER TABLE `CollegePlaying` ADD CONSTRAINT `fk_CollegePlaying_Master` FOREIGN KEY (`playerID`) REFERENCES `Master` (`playerID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;
