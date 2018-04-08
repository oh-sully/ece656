SELECT AVG(user_by_num_review.num_reviews) as avgReviews
FROM (SELECT user_id, COUNT(user_id) as num_reviews
	  FROM review
	  GROUP BY user_id
	  ORDER BY num_reviews desc
	  ) as user_by_num_review;