DROP VIEW IF EXISTS reviews;
DROP ROLE IF EXISTS casual;
DROP ROLE IF EXISTS reviewer;
DROP ROLE IF EXISTS analyst;
DROP ROLE IF EXISTS developer;
DROP ROLE IF EXISTS 'admin';
DROP USER IF EXISTS casual_user;
DROP USER IF EXISTS reviewer_user;
DROP USER IF EXISTS analyst_user;
DROP USER IF EXISTS developer_user;
DROP USER IF EXISTS admin_user;

CREATE VIEW reviews AS
	SELECT B.name AS 'Business', U.name AS 'User', R.stars AS 'Stars', R.date AS 'Date', R.text AS 'Review', R.useful AS 'Useful', R.funny AS 'Funny', R.cool AS 'cool'
	FROM review as R
	INNER JOIN business as B
		ON R.business_id = B.id
	INNER JOIN user as U
		ON R.user_id = U.id;

CREATE ROLE IF NOT EXISTS casual;
GRANT SELECT ON yelp_db.reviews TO casual;

CREATE ROLE IF NOT EXISTS reviewer;
GRANT casual TO reviewer;
GRANT INSERT ON yelp_db.review TO reviewer;

CREATE ROLE IF NOT EXISTS analyst;
GRANT SELECT, CREATE VIEW ON yelp_db.* to analyst;

CREATE ROLE IF NOT EXISTS developer;
-- Should SELECT and ALTER be granted for data cleaning?
GRANT SELECT, ALTER, CREATE, INSERT, UPDATE, DELETE, INDEX ON yelp_db.* TO developer;

CREATE ROLE IF NOT EXISTS 'admin';
GRANT ALL PRIVILEGES ON yelp_db.* TO 'admin' WITH GRANT OPTION;

CREATE USER casual_user;
GRANT casual TO casual_user;

CREATE USER reviewer_user;
GRANT reviewer TO reviewer_user;

CREATE USER analyst_user;
GRANT analyst TO analyst_user;

CREATE USER developer_user;
GRANT developer TO developer_user;

CREATE USER admin_user;
GRANT 'admin' TO admin_user;
