CREATE VIEW user_by_nreview AS
SELECT user_id, COUNT(user_id) as num_reviews
FROM review AS R
GROUP BY user_id
HAVING num_reviews > 10;

SELECT (
		(SELECT COUNT(user_id) FROM user_by_nreview) 
		/ 
		(SELECT COUNT(Distinct user_id) FROM user)
	   ) AS frac_reviews;