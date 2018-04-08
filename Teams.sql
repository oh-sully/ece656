-- FOREIGN KEY `fk_Teams_TeamsFranchises`;

ALTER TABLE `Teams` ADD INDEX `idx_Teams_TeamsFranchises` (`franchID`) USING BTREE;

DELETE Teams FROM Teams
  INNER JOIN
  (SELECT Teams.franchID
   FROM Teams
     LEFT JOIN `TeamsFranchises`
       ON Teams.franchID = `TeamsFranchises`.`franchID`
   WHERE `TeamsFranchises`.franchID IS NULL
  ) AS X
    ON Teams.franchID = X.franchID;

ALTER TABLE `Teams` ADD CONSTRAINT `fk_Teams_TeamsFranchises` FOREIGN KEY (`franchID`) REFERENCES `TeamsFranchises` (`franchID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;