-- FOREIGN KEY `fk_PitchingPost_Teams`;
-- FOREIGN KEY `fk_PitchingPost_Master`;

ALTER TABLE `PitchingPost` ADD INDEX `idx_PitchingPost_Master` (`playerID`) USING BTREE;
ALTER TABLE `PitchingPost` ADD INDEX `idx_PitchingPost_Teams` (`yearID`, `lgID`, `teamID`) USING BTREE;

DELETE PitchingPost FROM PitchingPost
  INNER JOIN
  (SELECT PitchingPost.playerID
   FROM PitchingPost
     LEFT JOIN `Master`
       ON PitchingPost.playerID = `Master`.`playerID`
   WHERE `Master`.playerID IS NULL
  ) AS X
    ON PitchingPost.playerID = X.playerID;


DELETE PitchingPost FROM PitchingPost
  INNER JOIN
  (SELECT
     PitchingPost.yearID,
     PitchingPost.lgID,
     PitchingPost.teamID
   FROM
     PitchingPost
     LEFT JOIN Teams
       ON PitchingPost.yearID = Teams.yearID AND PitchingPost.lgID = Teams.lgID AND PitchingPost.teamID = Teams.teamID
   WHERE Teams.yearID IS NULL OR Teams.lgID IS NULL OR Teams.teamID IS NULL
  ) AS X
    ON PitchingPost.yearID = X.yearID AND PitchingPost.lgID = X.lgID AND PitchingPost.teamID = X.teamID;


ALTER TABLE `PitchingPost` ADD CONSTRAINT `fk_PitchingPost_Teams` FOREIGN KEY (`yearID`, `lgID`, `teamID`) REFERENCES `Teams` (`yearID`, `lgID`, `teamID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

ALTER TABLE `PitchingPost` ADD CONSTRAINT `fk_PitchingPost_Master` FOREIGN KEY (`playerID`) REFERENCES `Master` (`playerID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;