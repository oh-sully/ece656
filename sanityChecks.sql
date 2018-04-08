#year user joined elite must be before 2018 (when data was collected)
SELECT * 
FROM elite_years as ey
WHERE ey.year > "2018";

#year user became elite must be after they started yelping
SELECT ey.id, ey.year, user.yelping_since
FROM elite_years AS ey
	INNER JOIN user
	ON ey.user_id = user.id
WHERE CAST(ey.year AS UNSIGNED INT) < YEAR(user.yelping_since);

#year user tipped must be before 2018 (when data was collected)
SELECT * 
FROM tip
WHERE YEAR(date) > 2017 ;

#year of tip must be the same year or the year after the user who gave the tip started yelping
SELECT tip.id, tip.date, user.yelping_since
FROM tip
	INNER JOIN user
	ON tip.user_id = user.id
WHERE tip.date <= user.yelping_since;

#stars given in review must be between 1 and 5
SELECT stars
FROM review
WHERE stars < 1 OR stars > 5;

#year of review must be before 2018 (when data was collected)
SELECT year
FROM review
WHERE YEAR(date) > 2017;

#date of review must be the same date or later than the user who gave the review started yelping
SELECT review.date, user.yelping_since
FROM review
	INNER JOIN user
	ON review.user_id = user.id
WHERE review.date < user.yelping_since;

#date of review must be the same date or later than the date the business joined yelp.
#no business start date.

#A user cannot be friends with themselves
SELECT user_id, friend_id
FROM friend
WHERE user_id = friend_id;

#A user cannot have been yelping_since a date before Yelp was founded (2004)
SELECT yelping_since
FROM user
WHERE YEAR(yelping_since) < 2004;