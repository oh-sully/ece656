ALTER TABLE attribute MODIFY id int(11) NOT NULL;
ALTER TABLE attribute DROP primary key;
ALTER TABLE attribute DROP foreign key business_id;
explain attribute;

ALTER TABLE business DROP primary key;
explain business;

ALTER TABLE category MODIFY id int(11) NOT NULL;
ALTER TABLE category DROP primary key;
ALTER TABLE category DROP foreign key business_id;
explain category;

ALTER TABLE checkin MODIFY id int(11) NOT NULL;
ALTER TABLE checkin DROP primary key;
ALTER TABLE checkin DROP foreign key business_id;
explain checkin;

ALTER TABLE elite_years MODIFY id int(11) NOT NULL;
ALTER TABLE elite_years DROP primary key;
ALTER TABLE elite_years DROP foreign key user_id;
explain elite_years;

ALTER TABLE friend MODIFY id int(11) NOT NULL;
ALTER TABLE friend DROP primary key;
ALTER TABLE friend DROP foreign key user_id;
ALTER TABLE friend DROP foreign key friend_id;
explain friend;

ALTER TABLE hours MODIFY id int(11) NOT NULL;
ALTER TABLE hours DROP primary key;
ALTER TABLE hours DROP foreign key business_id;
explain hours;

ALTER TABLE photo MODIFY id int(22) NOT NULL;
ALTER TABLE photo DROP primary key;
ALTER TABLE photo DROP foreign key business_id;
explain photo;

ALTER TABLE review MODIFY id int(22) NOT NULL;
ALTER TABLE review DROP primary key;
ALTER TABLE review DROP foreign key user_id;
ALTER TABLE review DROP foreign key business_id;
explain review;

ALTER TABLE tip MODIFY id int(11) NOT NULL;
ALTER TABLE tip DROP primary key;
ALTER TABLE tip DROP foreign key user_id;
ALTER TABLE tip DROP foreign key business_id;
explain tip;

ALTER TABLE user DROP primary key;
explain user;
