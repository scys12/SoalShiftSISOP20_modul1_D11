#!/bin/bash

create=`date '+%H'`
filename=${1%.txt}
rotation=$((${create} % 26))
padding=$(printf "%${rotation}s")
newFileName=$(echo "$filename" | tr "${padding}a-z" "a-za-z" | tr "${padding}A-Z" "A-ZA-Z")
newFileName=$newFileName.txt
head /dev/urandom | tr -dc A-Za-z0-9 | head -c28 > $newFileName
