-- FOREIGN KEY `fk_SeriesPost_Teams`;

ALTER TABLE `SeriesPost` ADD INDEX `idx_SeriesPost_TeamsWin` (`yearID`, `lgIDwinner`, `teamIDwinner`) USING BTREE;
ALTER TABLE `SeriesPost` ADD INDEX `idx_SeriesPost_TeamsLose` (`yearID`, `lgIDloser`, `teamIDloser`) USING BTREE;


DELETE SeriesPost FROM SeriesPost
  INNER JOIN
  (SELECT
     SeriesPost.yearID,
     SeriesPost.lgIDwinner,
     SeriesPost.teamIDwinner
   FROM
     SeriesPost
     LEFT JOIN Teams
       ON SeriesPost.yearID = Teams.yearID AND SeriesPost.lgIDwinner = Teams.lgID AND SeriesPost.teamIDwinner = Teams.teamID
   WHERE Teams.yearID IS NULL OR Teams.lgID IS NULL OR Teams.teamID IS NULL
  ) AS X
    ON SeriesPost.yearID = X.yearID AND SeriesPost.lgIDwinner = X.lgIDwinner AND SeriesPost.teamIDwinner = X.teamIDwinner;


DELETE SeriesPost FROM SeriesPost
  INNER JOIN
  (SELECT
     SeriesPost.yearID,
     SeriesPost.lgIDloser,
     SeriesPost.teamIDloser
   FROM
     SeriesPost
     LEFT JOIN Teams
       ON SeriesPost.yearID = Teams.yearID AND SeriesPost.lgIDloser = Teams.lgID AND SeriesPost.teamIDloser = Teams.teamID
   WHERE Teams.yearID IS NULL OR Teams.lgID IS NULL OR Teams.teamID IS NULL
  ) AS X
    ON SeriesPost.yearID = X.yearID AND SeriesPost.lgIDloser = X.lgIDloser AND SeriesPost.teamIDloser = X.teamIDloser;

ALTER TABLE `SeriesPost` ADD CONSTRAINT `fk_SeriesPost_Teams` FOREIGN KEY (`yearID`) REFERENCES `Teams` (`yearID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;