ALTER TABLE movies
ADD rank_s float4;

UPDATE movies
SET rank_s = ts_rank(to_tsvector(Starring),plainto_tsquery((
SELECT Summary FROM movies WHERE title='Captain Phillips')));

DROP TABLE recommendationsBasedOnStarringField;

CREATE TABLE recommendationsBasedOnStarringField AS
SELECT url,title, rank_s FROM movies WHERE rank_s > 0.05 ORDER BY rank DESC LIMIT 50;

\copy (SELECT * FROM recommendationsBasedOnStarringField) to '/home/pi/RSL/rec_starring.csv' WITH csv;