import pandas as pd

reviews = pd.read_csv("userReviewsWithSentiment.csv", sep=";")['movieName']
movies = pd.read_csv("movies.csv", sep=";")

possible_movies = movies.merge(reviews, left_on='url', right_on='movieName').drop_duplicates()

print(possible_movies[possible_movies.title =='The Amazing Spider-Man'][['title','Summary','Starring']])

