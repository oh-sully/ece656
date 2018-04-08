SELECT name, max_review
FROM (SELECT user_id, name, COUNT(name) as max_review
	  FROM review as R INNER JOIN user as U ON R.user_id = U.id
	  GROUP BY user_id
	  ORDER BY max_review desc) as der
LIMIT 1;