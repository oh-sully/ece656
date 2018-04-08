-- FOREIGN KEY `fk_HallOfFame_Master`;

ALTER TABLE `HallOfFame` ADD INDEX `idx_HallOfFame_Master` (`playerID` ) USING BTREE;


DELETE HallOfFame FROM HallOfFame
  INNER JOIN
  (SELECT HallOfFame.playerID
   FROM HallOfFame
     LEFT JOIN `Master`
       ON HallOfFame.playerID = `Master`.`playerID`
   WHERE `Master`.playerID IS NULL
  ) AS X
    ON HallOfFame.playerID = X.playerID;

ALTER TABLE `HallOfFame` ADD CONSTRAINT `fk_HallOfFame_Master` FOREIGN KEY (`playerID`) REFERENCES `Master` (`playerID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;