import pandas as pd
from pattern.en import sentiment

data = pd.read_csv("userReviews.csv", sep=";")
#Apply the sentiment function to each row of the summary column and store the resulting tuple in another column
#Note: to compute this on a RPI it takes around 15 minutes
data['sentiment_tuple'] = data['Summary'].apply(lambda x: sentiment(x))

#we loop over the column sentiment tuple and extract the polaritay and subjectivity in an own column. 
data['sentiment_polarity'] = data['sentiment_tuple'].apply(lambda x: eval(x)[0])
data['sentiment_subjectivity'] = data['sentiment_tuple'].apply(lambda x: eval(x)[1])

#save analyzed data set again
data.to_csv('userReviewsWithSentiment.csv', sep=";", index=False)