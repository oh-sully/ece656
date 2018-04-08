-- FOREIGN KEY `fk_TeamsHalf_Teams`;

ALTER TABLE `TeamsHalf` ADD INDEX `idx_TeamsHalf_Teams` (`yearID`, `lgID`, `teamID`) USING BTREE;


DELETE TeamsHalf FROM TeamsHalf
  INNER JOIN
  (SELECT
     TeamsHalf.yearID,
     TeamsHalf.lgID,
     TeamsHalf.teamID
   FROM
     TeamsHalf
     LEFT JOIN Teams
       ON TeamsHalf.yearID = Teams.yearID AND TeamsHalf.lgID = Teams.lgID AND TeamsHalf.teamID = Teams.teamID
   WHERE Teams.yearID IS NULL OR Teams.lgID IS NULL OR Teams.teamID IS NULL
  ) AS X
    ON TeamsHalf.yearID = X.yearID AND TeamsHalf.lgID = X.lgID AND TeamsHalf.teamID = X.teamID;


ALTER TABLE `TeamsHalf` ADD CONSTRAINT `fk_TeamsHalf_Teams` FOREIGN KEY (`yearID`, `lgID`, `teamID`) REFERENCES `Teams` (`yearID`, `lgID`, `teamID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;