This repository contains the code for a simply movie recommender system.

How to use the SQL recommander System:

1. Run "bash recommendations.sh" 
2. Type in the favourite movie. In my case "Captain Phillipps". Spelling is important.
3. The recommendations based on summary will be displayed.
4. Check the recommendations and press "q" to see the recommendations based on title
5. Check the recommendations based on title and press q to see the recommendations based on starring
6. Check the recommendations based on starring
7. All recommendations are saved also as a .csv file in the same directory

How to use the Python recommander System:

1. Open the recommander_metascore.py and type in your favourite movie in line 17
2. Run it in the shell and check the output
3. Run the sentiment_preprocess.py one time. This may take a while.
4. Open the recommander_sentiment.py and type in your favourite movie in line 7
5. Run it in the shell and check the output.

NOTE:
1. All Outputs are stored as csv files in the Output folder
2. Inputs have to be stored in the Input Folder as: movies.csv and userReviews.csv

The possible_movies.py contains a small script to identify movies that are in movies.csv AND userReviews.csv

All code can be found on https://github.com/Rokra1995/DBM
Copyright@Robin Kratschnayr
