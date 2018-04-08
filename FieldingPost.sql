-- FOREIGN KEY `fk_FieldingPost_Master`;
-- FOREIGN KEY `fk_FieldingPost_Teams`;
-- FOREIGN KEY `fk_FieldingPost_BattingPost`;

ALTER TABLE `FieldingPost` ADD INDEX `idx_FieldingPost_Master` (`playerID`) USING BTREE;
ALTER TABLE `FieldingPost` ADD INDEX `idx_FieldingPost_Teams` (`yearID`, `lgID`, `teamID`) USING BTREE;
ALTER TABLE `FieldingPost` ADD INDEX `idx_FieldingPost_BattingPost` (`yearID`, `round`, `playerID`) USING BTREE;

DELETE FieldingPost FROM FieldingPost
  INNER JOIN
  (SELECT FieldingPost.playerID
   FROM FieldingPost
     LEFT JOIN `Master`
       ON FieldingPost.playerID = `Master`.`playerID`
   WHERE `Master`.playerID IS NULL
  ) AS X
    ON FieldingPost.playerID = X.playerID;


DELETE FieldingPost FROM FieldingPost
  INNER JOIN
  (SELECT
     FieldingPost.yearID,
     FieldingPost.lgID,
     FieldingPost.teamID
   FROM
     FieldingPost
     LEFT JOIN Teams
       ON FieldingPost.yearID = Teams.yearID AND FieldingPost.lgID = Teams.lgID AND FieldingPost.teamID = Teams.teamID
   WHERE Teams.yearID IS NULL OR Teams.lgID IS NULL OR Teams.teamID IS NULL
  ) AS X
    ON FieldingPost.yearID = X.yearID AND FieldingPost.lgID = X.lgID AND FieldingPost.teamID = X.teamID;

DELETE FieldingPost FROM FieldingPost
  INNER JOIN
  (SELECT
     FieldingPost.yearID,
     FieldingPost.round,
     FieldingPost.playerID
   FROM
     FieldingPost
     LEFT JOIN Batting
       ON FieldingPost.yearID = BattingPost.yearID AND FieldingPost.round = BattingPost.round AND FieldingPost.playerID = BattingPost.playerID
   WHERE BattingPost.yearID IS NULL OR BattingPost.round IS NULL OR BattingPost.playerID IS NULL
  ) AS X
    ON FieldingPost.yearID = X.yearID AND FieldingPost.round = X.round AND FieldingPost.playerID = X.playerID;


ALTER TABLE `FieldingPost` ADD CONSTRAINT `fk_FieldingPost_Teams` FOREIGN KEY (`yearID`, `lgID`, `teamID`) REFERENCES `Teams` (`yearID`, `lgID`, `teamID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

ALTER TABLE `FieldingPost` ADD CONSTRAINT `fk_FieldingPost_Master` FOREIGN KEY (`playerID`) REFERENCES `Master` (`playerID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

ALTER TABLE `FieldingPost` ADD CONSTRAINT `fk_FieldingPost_BattingPost` FOREIGN KEY (`yearID`, `round`, `playerID`) REFERENCES `BattingPost` (`yearID`, `round`, `playerID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;