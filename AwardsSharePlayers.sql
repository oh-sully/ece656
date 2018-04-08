-- FOREIGN KEY `fk_AwardsSharePlayers_Master`;

ALTER TABLE `AwardsSharePlayers` ADD INDEX `idx_AwardsSharePlayers_Master` (`playerID` ) USING BTREE;

DELETE AwardsSharePlayers FROM AwardsSharePlayers
  INNER JOIN
  (SELECT AwardsSharePlayers.playerID
   FROM AwardsSharePlayers
     LEFT JOIN `Master`
       ON AwardsSharePlayers.playerID = `Master`.`playerID`
   WHERE `Master`.playerID IS NULL
  ) AS X
    ON AwardsSharePlayers.playerID = X.playerID;
    

ALTER TABLE `AwardsSharePlayers` ADD CONSTRAINT `fk_AwardsSharePlayers_Master` FOREIGN KEY (`playerID`) REFERENCES `Master` (`playerID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;


