#!/bin/bash

create=`date '+%H'`
create=10#$create
filename=${1%.txt}
rotation=$((${create} % 26))
padding=$(printf "%${rotation}s")
newFileName=$(echo "$filename" | tr "${padding}a-z" "a-za-z" | tr "${padding}A-Z" "A-ZA-Z")
newFileName=$newFileName.txt
for((i=1;i<=28;i++))
do
    if (( $i % 3 == 1 ))
    then
        char=`head /dev/urandom | tr -dc A-Z| head -c 1`
        password+=$char
    fi
    if (( $i % 3 == 2 ))
    then
        char=`head /dev/urandom | tr -dc a-z| head -c 1`
        password+=$char
    fi
    if (( $i % 3 == 0 ))
    then
        char=`head /dev/urandom | tr -dc 0-9| head -c 1`
        password+=$char
    fi
done
echo "$password" > $newFileName
