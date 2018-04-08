-- FOREIGN KEY `fk_BattingPost_Teams`;
-- FOREIGN KEY `fk_BattingPost_Master`;

ALTER TABLE `BattingPost` ADD INDEX `idx_BattingPost_Master` (`playerID`) USING BTREE;
ALTER TABLE `BattingPost` ADD INDEX `idx_BattingPost_Teams` (`yearID`, `lgID`, `teamID`) USING BTREE;


DELETE BattingPost FROM BattingPost
  INNER JOIN
  (SELECT BattingPost.playerID
   FROM BattingPost
     LEFT JOIN `Master`
       ON BattingPost.playerID = `Master`.`playerID`
   WHERE `Master`.playerID IS NULL
  ) AS X
    ON BattingPost.playerID = X.playerID;


DELETE BattingPost FROM BattingPost
  INNER JOIN
  (SELECT
     BattingPost.yearID,
     BattingPost.lgID,
     BattingPost.teamID
   FROM
     BattingPost
     LEFT JOIN Teams
       ON BattingPost.yearID = Teams.yearID AND BattingPost.lgID = Teams.lgID AND BattingPost.teamID = Teams.teamID
   WHERE Teams.yearID IS NULL OR Teams.lgID IS NULL OR Teams.teamID IS NULL
  ) AS X
    ON BattingPost.yearID = X.yearID AND BattingPost.lgID = X.lgID AND BattingPost.teamID = X.teamID;


ALTER TABLE `BattingPost` ADD CONSTRAINT `fk_BattingPost_Teams` FOREIGN KEY (`yearID`, `lgID`, `teamID`) REFERENCES `Teams` (`yearID`, `lgID`, `teamID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

ALTER TABLE `BattingPost` ADD CONSTRAINT `fk_BattingPost_Master` FOREIGN KEY (`playerID`) REFERENCES `Master` (`playerID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;



