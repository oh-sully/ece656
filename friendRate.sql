

CREATE PROCEDURE favgRate (IN userID VARCHAR(22), busID VARCHAR(22) OUT favgRating)
BEGIN
  SELECT avg(stars) INTO favgRating
  FROM review AS r
  WHERE r.business_id = busID
    AND r.user_id IN (SELECT friend_id FROM friend WHERE user_id = userID);
END;

business_id = "--6MefnULPED_I942VcFNA"
user_id = "---1lKK3aKOuomHnwAkAow"
SELECT avg(stars) INTO favgRating
FROM review AS r
WHERE r.business_id = "FO9T9ob6TGWKrw6ZCGBZrQ"
  AND r.user_id IN (SELECT friend_id FROM friend WHERE user_id = "---1lKK3aKOuomHnwAkAow" LIMIT 20);


SELECT business_id, stars
FROM review
WHERE user_id = "Z3UUg88bC1-QGzjZzgRLdg";
