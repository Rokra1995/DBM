ALTER TABLE movies
ADD rank float4;

UPDATE movies
SET rank = ts_rank(to_tsvector(Summary),plainto_tsquery((
SELECT Summary FROM movies WHERE title='Captain Phillips')));

DROP TABLE recommendationsBasedOnSummaryField;

CREATE TABLE recommendationsBasedOnSummaryField AS
SELECT url,title, rank FROM movies WHERE rank > 0.05 ORDER BY rank DESC LIMIT 50;

\copy (SELECT * FROM recommendationsBasedOnSummaryField) to '/home/pi/RSL/rec_summary.csv' WITH csv;