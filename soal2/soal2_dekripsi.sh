#!/bin/bash

dateModified=`date -r $1 "+%H"`
dateModified=10#$dateModified
filename=${1%.txt}
rotation=$((26-(${dateModified} % 26)))
padding=$(printf "%${rotation}s")
newFileName=$(echo "$filename" | tr "${padding}a-z" "a-za-z" | tr "${padding}A-Z" "A-ZA-Z")
newFileName=$newFileName.txt
mv $1 $newFileName
