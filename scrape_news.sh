#!/bin/bash

#copy the main page to file named 3082
wget https://www.ynetnews.com/category/3082

#copy the links from file 3082 to links.txt without repetitions
grep -o "https://www.ynetnews.com/article/[a-zA-Z0-9]\{9\}" 3082 |\
 uniq > links.txt
wc -l links.txt | cut -c1,2 >> results.csv
#run on each link page and count bibi and gantz appearences
for link in `cat links.txt`;
do
   wget -q $link -O article.txt 
   
   count_bibi=`grep -c  "Netanyahu" article.txt`
   count_gantz=`grep -c  "Gantz" article.txt`
#checking if there were any appearnces of bibi and/or gantz in this article
   if (( count_bibi == 0 && count_gantz == 0 ))
   then
   	echo $link", -" >> results.csv
   else
   	echo $link", Netanyahu," $count_bibi", Gantz," $count_gantz >> results.csv
   fi
 done
