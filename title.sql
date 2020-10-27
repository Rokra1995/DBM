ALTER TABLE movies
ADD rank_t float4;

UPDATE movies
SET rank_t = ts_rank(to_tsvector(title),plainto_tsquery((
SELECT Summary FROM movies WHERE title='Captain Phillips')));

DROP TABLE recommendationsBasedOnTitleField;

CREATE TABLE recommendationsBasedOnTitleField AS
SELECT url,title, rank_t FROM movies WHERE rank_t > 0.05 ORDER BY rank DESC LIMIT 50;

\copy (SELECT * FROM recommendationsBasedOnTitleField) to '/home/pi/RSL/rec_title.csv' WITH csv;