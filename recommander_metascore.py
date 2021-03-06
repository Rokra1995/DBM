import pandas as pd

#load the data
data = pd.read_csv("Input/userReviews.csv", sep=";")
#print(data.head())

#for speed and code optimization purpose the following comment was replaced with
#another method to generate the subset, shown after the comment
'''
#create empty dataframe with the same column names as data
subset = pd.DataFrame(columns=data.columns.tolist())

#i replaced the slow loopig with the faster filter method

for movie in range(1):
    if data.movieName.iloc[movie] == 'beach-rats':
        row = data[movie:movie+1]
        subset = subset.append(row)
'''

#create subset of reviews on your favourite movie
subset = data[data.movieName == 'the-amazing-spider-man']

#Create final dataframe for the recommendations that also includes the relative and absolute score
recommendations = pd.DataFrame(columns=data.columns.tolist()+['rel_inc','abs_inc'])

#loop over all hte users that watched the same movie we liked
for idx, Author in subset.iterrows():
    #print(Author)
    #save each author and the ranking he gave to the movie we like
    author = Author[['Author']].iloc[0]
    ranking = Author[['Metascore_w']].iloc[0]
    #create a unique dataframe that contains all the movies that where ranked by the selected author 
    #with a higher ranking then the ranking on the movie we like
    #and calculate relative ranking increase and absolute ranking increase
    #filteroptions:
    filter1 = (data.Author==author)
    filter2 = (data.Metascore_w>ranking)
    
    #extract possible recommandations and calculate relative and absolute score
    possible_recommendations = data[filter1 & filter2]
    possible_recommendations['rel_inc'] = possible_recommendations.Metascore_w/ranking
    possible_recommendations['abs_inc'] = possible_recommendations.Metascore_w - ranking
    
    #append this to the recommendations df
    recommendations = recommendations.append(possible_recommendations)

#sort the recommendations in a descending order first on the relative score then the absolute score
recommendations = recommendations.sort_values(['rel_inc','abs_inc'], ascending=False)    

#drop duplicates to decrease df size
recommendations = recommendations.drop_duplicates(subset='movieName', keep="first")
#write to csv and print first 25 recommendations
recommendations.head(50).to_csv("Output/recommendationsBasedOnMetascore.csv", sep=";", index=False)
print(recommendations.head(50))
print(recommendations.shape)

