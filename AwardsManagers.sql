-- FOREIGN KEY `fk_AwardsManagers_Master`;

ALTER TABLE `AwardsManagers` ADD INDEX `idx_AwardsManagers_Master` (`playerID` ) USING BTREE;

DELETE AwardsManagers FROM AwardsManagers
  INNER JOIN
  (SELECT AwardsManagers.playerID
   FROM AwardsManagers
     LEFT JOIN `Master`
       ON AwardsManagers.playerID = `Master`.`playerID`
   WHERE `Master`.playerID IS NULL
  ) AS X
    ON AwardsManagers.playerID = X.playerID;
    

ALTER TABLE `AwardsManagers` ADD CONSTRAINT `fk_AwardsManagers_Master` FOREIGN KEY (`playerID`) REFERENCES `Master` (`playerID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;


