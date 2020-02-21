#!/bin/bash

lastNumber=$(ls | sed 's/pdkt_kusuma_//' | sort -n | tail -1)
if [[ !($lastNumber =~ [0-9]) ]];then
    lastNumber=0
elif [[ ($lastNumber =~ [0-9]) && ($lastNumber =~ [a-zA-Z]) ]];then
    lastNumber=0
fi
for ((i=lastNumber+1; i<=lastNumber+28; i++))
do
    wget -O "pdkt_kusuma_${i}" "https://loremflickr.com/320/240/cat" 2>&1 | tee -a wget.log
done