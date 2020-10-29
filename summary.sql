-- Create empty column "rank" that stores the rank based on summary
ALTER TABLE movies
ADD COLUMN IF NOT EXISTS rank float4;

--calculate rank based on choosen movie 'MOVIE' is a placeholder that is replaced by the shell script
UPDATE movies
SET rank = ts_rank(to_tsvector(Summary),plainto_tsquery((
SELECT Summary FROM movies WHERE title='MOVIE')));

--Drop the table that stored the recommendations in case this script runs several times.
DROP TABLE recommendationsBasedOnSummaryField;

--Create the table with the recommendations, rank is set on > 0.05 to ensure there are enough movies selected
CREATE TABLE recommendationsBasedOnSummaryField AS
SELECT title, rank FROM movies WHERE rank > 0.05 ORDER BY rank DESC LIMIT 50;

--save recommendations as .csv file
\copy (SELECT * FROM recommendationsBasedOnSummaryField) to '/home/pi/RSL/Output/recommendationBasedOnSummary.csv' WITH csv;

--print recommendations in the shell
SELECT * FROM recommendationsBasedOnSummaryField;