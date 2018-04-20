#Number of reviews in table `review` should be equal to the sum of the number of all the business reviews
SELECT (
	(SELECT COUNT(*)
	 FROM review)
	-
	(SELECT SUM(review_count)
	 FROM business))
	AS numOfReviewDiff;
#733 in results
#takes <20sec without index

#Number of reviews in table `review` should be equal to the sum of the number of all users reviews
SELECT (
	(SELECT COUNT(*)
	 FROM review)
	-
	(SELECT SUM(review_count)
	 FROM user))
	AS numOfReviewDiff;
#(-)25,394,022 in results
#takes ~20 sec without index

#Selects the difference in the users average star rating with the average rating based on the actual reviews of users with a difference between those values (e.g. difference of 0)
SELECT COUNT(*) AS diffusrstar
FROM (SELECT R.user_id, AVG(R.stars) AS avg_stars
	  	FROM review AS R
	  	GROUP BY R.user_id) AS avgStarsRev
	INNER JOIN user AS U
	ON avgStarsRev.user_id = U.id
WHERE avg_stars != U.average_stars;
#864,017 in results
#takes <1 min 5 sec i

#Selects the difference in the business average star rating with the average rating based on the actual reviews of users with a difference between those values (e.g. difference of 0)
SELECT COUNT(*) AS diffbusistar
FROM (SELECT R.business_id, AVG(R.stars) AS avg_stars
	  FROM review AS R
	  GROUP BY R.business_id)
	  AS avgStarsRev INNER JOIN business AS B ON avgStarsRev.business_id = B.id
WHERE avg_stars != B.stars;
#126,998 in results
#takes <40 sec without index
