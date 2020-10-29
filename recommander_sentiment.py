import pandas as pd

#load the data after preprocessing with sentiment_preprocess.py
data = pd.read_csv("Input/userReviewsWithSentiment.csv", sep=";")

#create subset of reviews on your favourite movie
subset = data[data.movieName == 'the-amazing-spider-man']

#Create final dataframe for the recommendations that also includes the relative and absolute score
recommendations = pd.DataFrame(columns=data.columns.tolist()+['rel_inc','abs_inc'])

#Create final dataframe for the recommendations that also includes the relative and absolute score
recommendations_sent = pd.DataFrame(columns=data.columns.tolist()+['rel_sent','abs_sent'])

#loop over all hte users that watched the same movie we liked
for idx, Author in subset.iterrows():
    author = Author[['Author']].iloc[0]
    sent_polarity = Author[['sentiment_polarity']].iloc[0]
    sent_subjectivity = Author[['sentiment_subjectivity']].iloc[0]

    #Dataframe filter options:
    filter1 = (data.Author==author)
    filter2 = (data.sentiment_polarity>0.1) # filters all movies the author likes (0.1 is the best threshold according the pattern documentation)
    filter3 = (data.sentiment_polarity>sent_polarity) #must like the movies more then the current movie
    filter4 = (data.sentiment_subjectivity>sent_subjectivity) #subjectivity also needs to be higher than the one of the current movie

    #filter possible recommendations and calculate sentiment scores
    possible_recommendations = data[filter1 & filter2 & filter3 & filter4]
    possible_recommendations['rel_sent'] = possible_recommendations.sentiment_polarity/sent_polarity
    possible_recommendations['abs_sent'] = possible_recommendations.sentiment_polarity - sent_polarity
    
    #append this to the recommendations df
    recommendations_sent = recommendations_sent.append(possible_recommendations)

#sort the recommendations in a descending order first on the relative score then the absolute score
recommendations_sent = recommendations_sent.sort_values(['abs_sent','rel_sent'], ascending=False)    
#drop duplicates to decrease df size
recommendations_sent = recommendations_sent.drop_duplicates(subset='movieName', keep="first")
#write to csv and print first 25 recommendations
recommendations_sent.head(50).to_csv("Output/recommendationsBasedOnSentiments.csv", sep=";", index=False)

print(recommendations_sent.head(50))
print(recommendations_sent.shape)