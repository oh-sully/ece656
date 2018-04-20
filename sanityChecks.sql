#year user joined elite must be before 2018 (when data was collected)
SELECT user_id
FROM elite_years
WHERE year > "2017";
#emptyset
#takes <1sec

#year user became elite must be after they started yelping
SELECT ey.id AS eyID, ey.year AS eliteYear, user.yelping_since
FROM elite_years AS ey
	INNER JOIN user
	ON ey.user_id = user.id
WHERE CAST(ey.year AS UNSIGNED INT) < YEAR(user.yelping_since);
#emptyset
#takes too long without index

#year user tipped must be before 2018 (when data was collected)
SELECT id
FROM tip
WHERE YEAR(date) > 2017;
#emptyset
#takes <3sec

#year of tip must be the same year or the year after the user who gave the tip started yelping
SELECT tip.id, tip.date AS tipDate, user.yelping_since
FROM tip
	INNER JOIN user
	ON tip.user_id = user.id
WHERE tip.date < user.yelping_since
limit 20;
#takes too long with out index

#stars given in review must be between 1 and 5
SELECT stars
FROM review
WHERE stars < 1 OR stars > 5;
#emptyset
#takes <25sec

#year of review must be before 2018 (when data was collected)
SELECT YEAR(date) AS year
FROM review
WHERE YEAR(date) > 2017;
#emptyset
#takes ~30sec

#date of review must be the same date or later than the user who gave the review started yelping
SELECT review.date AS reviewDate, user.yelping_since
FROM review
	INNER JOIN user
	ON review.user_id = user.id
WHERE review.date < user.yelping_since
limit 20;
#takes too long without index

#A user cannot be friends with themselves
SELECT user_id, friend_id
FROM friend
WHERE user_id = friend_id;
#emptyset
#takes <2min

#A user cannot have been yelping_since a date before Yelp was founded (2004)
SELECT yelping_since
FROM user
WHERE YEAR(yelping_since) < 2004;
#emptyset
#takes <3sec
