#!/bin/bash

count="5"
echo -e "CO\t N\t idle" > results.dat

for ((i=1; i <= 50; i++))
do
 ./loadtest $i &
 

 idle=$(mpstat $count 1 -o JSON  | jq '100 - .sysstat.hosts[0].statistics[0]."cpu-load"[0].idle') 



 CO=$(cat synthetic.dat | wc -l)
 echo -e "$CO\t $i\t $idle\t" >>   results.dat

pkill loadtest

done
