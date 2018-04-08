-- FOREIGN KEY `fk_AwardsPlayers_Master`;

ALTER TABLE `AwardsPlayers` ADD INDEX `idx_AwardsPlayers_Master` (`playerID` ) USING BTREE;

DELETE AwardsPlayers FROM AwardsPlayers
  INNER JOIN
  (SELECT AwardsPlayers.playerID
   FROM AwardsPlayers
     LEFT JOIN `Master`
       ON AwardsPlayers.playerID = `Master`.`playerID`
   WHERE `Master`.playerID IS NULL
  ) AS X
    ON AwardsPlayers.playerID = X.playerID;
    

ALTER TABLE `AwardsPlayers` ADD CONSTRAINT `fk_AwardsPlayers_Master` FOREIGN KEY (`playerID`) REFERENCES `Master` (`playerID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;