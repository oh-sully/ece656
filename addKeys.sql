-- ALTER TABLE attribute ADD FOREIGN KEY (business_id) REFERENCES business(id);

explain attribute;

-- ALTER TABLE category ADD FOREIGN KEY (business_id) REFERENCES business(id);
explain category;

ALTER TABLE checkin ADD foreign key (business_id) REFERENCES business(id);
explain checkin;

ALTER TABLE elite_years ADD foreign key (user_id) REFERENCES user(id);
ALTER TABLE `elite_years` ADD INDEX `idx_elite_years_year` (`year`) USING BTREE;
explain elite_years;

ALTER TABLE friend ADD foreign key (user_id) REFERENCES user(id);
ALTER TABLE friend ADD foreign key (friend_id) REFERENCES user(id);
explain friend;

ALTER TABLE hours ADD foreign key (business_id) REFERENCES business(id);
explain hours;

ALTER TABLE photo ADD foreign key (business_id) REFERENCES business(id);
explain photo;

ALTER TABLE review ADD foreign key (user_id) REFERENCES user(id);
ALTER TABLE review ADD foreign key (business_id) REFERENCES business(id);
ALTER TABLE `review` ADD INDEX `idx_review_stars` (`stars`) USING BTREE;
ALTER TABLE `review` ADD INDEX `idx_review_date` (`date`) USING BTREE;
ALTER TABLE `review` ADD INDEX `idx_review_userid_stars` (`user_id`,`stars`) USING BTREE;
ALTER TABLE `review` ADD INDEX `idx_review_busid_stars` (`business_id`,`stars`) USING BTREE;
explain review;

ALTER TABLE tip ADD foreign key (user_id) REFERENCES user(id);
ALTER TABLE tip ADD foreign key (business_id) REFERENCES business(id);
ALTER TABLE tip ADD INDEX `idx_tip_date` (`date`) USING BTREE;
explain tip;

-- ALTER TABLE user DROP primary key;
ALTER TABLE user ADD INDEX `idx_user_yelping_since` (`yelping_since`) USING BTREE;

explain user;
