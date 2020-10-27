#!/bin/bash

#Select movie
echo "Type in base movie for your recommendation"
read movie
echo "recommendations will be created"

#change the placeholder in the sql files to the selected movie
sed -i "s/MOVIE/$movie/g" "starring.sql"
sed -i "s/MOVIE/$movie/g" "summary.sql"
sed -i "s/MOVIE/$movie/g" "title.sql"

#run the sql files and keep user updated
echo "******************* RECOMMENDATIONS BASED ON SUMMARY **************"
psql test -f summary.sql
echo "******************* RECOMMENDATIONS BASED ON TITLE **************"
psql test -f title.sql
echo "******************* RECOMMENDATIONS BASED ON STARRING **************"
psql test -f starring.sql

#replace selected movie in sql file with placeholder again for reusability
sed -i "s/$movie/MOVIE/g" "starring.sql"
sed -i "s/$movie/MOVIE/g" "summary.sql"
sed -i "s/$movie/MOVIE/g" "title.sql"