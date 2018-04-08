CREATE VIEW revlen AS
SELECT user_id, LENGTH(R.text) AS rLen
FROM review as R;


CREATE VIEW user_by_nreview AS
SELECT user_id, COUNT(user_id) as num_reviews
FROM review
GROUP BY user_id
HAVING num_reviews > 10;

SELECT (
		(SELECT SUM(rlen) 
		 FROM revlen NATURAL JOIN user_by_nreview) 
		/
		(SELECT COUNT(user_id) 
		 FROM user_by_nreview)
	   ) AS avgreviewlen;