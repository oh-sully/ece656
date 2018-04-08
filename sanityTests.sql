#A user cannot have been yelping_since a date before Yelp was founded (2004)
SELECT yelping_since
FROM user
WHERE YEAR(yelping_since) < 2004;