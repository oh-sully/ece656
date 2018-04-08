SELECT name, max_review
FROM (SELECT business_id, name, COUNT(name) as max_review
	  FROM review as R INNER JOIN business as B ON R.business_id = B.id
	  GROUP BY business_id
	  ORDER BY max_review desc) as der
LIMIT 1;