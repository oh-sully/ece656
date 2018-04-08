#Number of reviews in table `review` should be equal to the sum of the number of all the business' reviews
SELECT (
	(SELECT COUNT(*) 
	 FROM review) 
	- 
	(SELECT SUM(review_count) 
	 FROM business))
	AS numOfReviewDiff;

#Number of reviews in table `review` should be equal to the sum of the number of all user's reviews
SELECT (
	(SELECT COUNT(*) 
	 FROM review) 
	- 
	(SELECT SUM(review_count) 
	 FROM user))
	AS numOfReviewDiff;

#Selects the difference in the user's average star rating with the average rating based on the actual reviews of users with a difference between those values (e.g. difference of 0)
SELECT U.id, (avg_stars - U.average_stars) AS starDiff
FROM (SELECT R.user_id, AVG(R.stars) AS avg_stars
	  FROM review AS R
	  GROUP BY R.user_id) 
	  AS avgStarsRev INNER JOIN user AS U ON avgStarsRev.user_id = U.id
WHERE avg_stars != U.average_stars

#Selects the difference in the business' average star rating with the average rating based on the actual reviews of users with a difference between those values (e.g. difference of 0)
SELECT B.id, (avg_stars - B.stars) AS starDiff
FROM (SELECT R.business_id, AVG(R.stars) AS avg_stars
	  FROM review AS R
	  GROUP BY R.business_id) 
	  AS avgStarsRev INNER JOIN business AS B ON avgStarsRev.business_id = B.id
WHERE avg_stars != B.stars;