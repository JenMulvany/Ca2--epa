#!/bin/bash


#The length of time the loadtest runs

count="8"
#creating the columns in the results doc
echo -e "CO\t N\t busy" > results.dat

#forloop to run the load test in the rang 1 <= 50 starting at 1 and increasing each time
for ((i=1; i <= 50; i++))
do
 ./loadtest $i &
 
#collecting cpu utilization
 busy=$(mpstat $count 1 -o JSON  | jq '100 - .sysstat.hosts[0].statistics[0]."cpu-load"[0].idle') 



 CO=$(cat synthetic.dat | wc -l)

#outputing the results the the results.dat file
 echo -e "$CO\t $i\t $busy\t" >>   results.dat

#kills the process ./loadtest

pkill loadtest

done
