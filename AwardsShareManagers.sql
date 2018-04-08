-- FOREIGN KEY `fk_AwardsShareManagers_Master`;

ALTER TABLE `AwardsShareManagers` ADD INDEX `idx_AwardsShareManagers_Master` (`playerID` ) USING BTREE;

DELETE AwardsShareManagers FROM AwardsShareManagers
  INNER JOIN
  (SELECT AwardsShareManagers.playerID
   FROM AwardsShareManagers
     LEFT JOIN `Master`
       ON AwardsShareManagers.playerID = `Master`.`playerID`
   WHERE `Master`.playerID IS NULL
  ) AS X
    ON AwardsShareManagers.playerID = X.playerID;
    

ALTER TABLE `AwardsShareManagers` ADD CONSTRAINT `fk_AwardsShareManagers_Master` FOREIGN KEY (`playerID`) REFERENCES `Master` (`playerID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

