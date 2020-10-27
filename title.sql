-- Delete the column rank to ensure we start all over again and have an empy rank column
ALTER TABLE movies
DROP COLUMN rank_t;

-- Create empty column "rank" that stores the rank based on title
ALTER TABLE movies
ADD rank_t float4;

--calculate rank based on choosen movie 'MOVIE' is a placeholder that is replaced by the shell script
UPDATE movies
SET rank_t = ts_rank(to_tsvector(title),plainto_tsquery((
SELECT Summary FROM movies WHERE title='MOVIE')));

--Drop the table that stored the recommendations in case this script runs several times.
DROP TABLE recommendationsBasedOnTitleField;

--Create the table with the recommendations, rank is set on > 0.05 to ensure there are enough movies selected
CREATE TABLE recommendationsBasedOnTitleField AS
SELECT title, rank_t FROM movies WHERE rank_t > 0.05 ORDER BY rank_t DESC LIMIT 50;

--save recommendations in csv file
\copy (SELECT * FROM recommendationsBasedOnTitleField) to '/home/pi/RSL/rec_title.csv' WITH csv;

--print the recommendations based on title to the shell
SELECT * FROM recommendationsBasedOnTitleField;