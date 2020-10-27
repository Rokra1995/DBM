This repository contains the code for a simply movie recommender system.

How to use it:

1. Run "bash recommendations.sh" 
2. Type in the favourite movie. In my case "Captain Phillipps". Spelling is important.
3. The recommendations based on summary will be displayed.
4. Check the recommendations and press "q" to see the recommendations based on title
5. Check the recommendations based on title and press q to see the recommendations based on starring
6. Check the recommendations based on starring
7. All recommendations are saved also as a .csv file in the same directory


Interpretation of results for the movie "Captain Phillips"

1. Recommendations based on Summary
	50 recommendations with rank 1. Somehow the selected movie is not included. 
	The other recommendations don't have a lot in common with captain phillips but the 
	recommendations are ok. Interesting is that the list is different everytime i rerun the script.
2. Recommendations based on title
	50 recommendations with the highest rank of 0.66 down to 0.33.
	Recommendations are actually not too bad. So i like the recommendet movies.
3. Recommendations based on starring
	34 recommendations with mostly the same rank of 0.0991032.
	Recommendations are diffferent then the ones before but actually not too bad.
	
