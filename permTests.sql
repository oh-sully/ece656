DROP VIEW IF EXISTS reviews;
DROP ROLE IF EXISTS reviewer;
DROP ROLE IF EXISTS analyst;

CREATE VIEW reviews AS
	SELECT B.name AS 'Business', U.name AS 'User', R.stars AS 'Stars', R.date AS 'Date', R.text AS 'Review', R.useful AS 'Useful', R.funny AS 'Funny', R.cool AS 'cool'
	FROM review as R
	INNER JOIN business as B
		ON R.business_id = B.id
	INNER JOIN user as U
		ON R.user_id = U.id;


GRANT SELECT ON yelp_db.reviews TO PUBLIC;


CREATE ROLE reviewer;
GRANT INSERT ON yelp_db.review TO reviewer;

CREATE ROLE analyst;

DROP VIEW IF EXISTS reviews;
DROP ROLE IF EXISTS reviewer;
DROP ROLE IF EXISTS analyst;