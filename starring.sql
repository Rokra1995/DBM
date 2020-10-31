--Here we add a new column to the movie database that stores the rank for starring
ALTER TABLE movies
ADD COLUMN IF NOT EXISTS rank_s float4;

--Here we add the rank based on starring of our favourtie movie. Note: 'MOVIE' is a placeholder that will be replaced by a shell script.
UPDATE movies
SET rank_s = ts_rank(to_tsvector(Starring),plainto_tsquery((
SELECT Summary FROM movies WHERE title='MOVIE')));

--To ensure not running into an error when we run the script twice the rec table will be dropped. Also to ensure the rec for the right movies are selected when we run the script several times.
DROP TABLE recommendationsBasedOnStarringField;

--Here we create the table again print it out and save it as a csv.I set rank to 0.05 to ensure there will be more then 2 movies.
--The desicion if the movie is good or not can be made on the rank and title later
CREATE TABLE recommendationsBasedOnStarringField AS
SELECT title, rank_s FROM movies WHERE rank_s > 0.05 ORDER BY rank_s DESC LIMIT 50;

--Output the table in the shell
SELECT * FROM recommendationsBasedOnStarringField

--Save the table as a csv
\copy (SELECT * FROM recommendationsBasedOnStarringField) to '/home/pi/RSL/Output/recommendationBasedOnStarring.csv' WITH csv;
