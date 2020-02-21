#!/bin/bash

curr=$(pwd)
loc=($(awk -F "/" '/^Location: /{ url[i++] = $4 }/Saving to: /{ filename[j++] = $NF }
    END{for(k=0;k<i;k++)print url[k]","filename[k]}' wget.log | awk -F "," 'a[$1]++{print $2}' | sed 's/Saving to: //g'))

for num in "${loc[@]}"; do
    fileNumber=`echo $num | sed "s/[^0-9]//g"`
    nameFile=$(ls *$fileNumber*)
    newName="duplicate_$fileNumber"
    
    mv $nameFile $newName
    if [[ ! -d "$curr/duplicate" ]]; then
	    mkdir duplicate
    fi
    mv $newName "duplicate/"
done

for file in pdkt_kusuma_*
do
    fileNumber=`echo $file | sed "s/[^0-9]//g"`
    newName="kenangan_$fileNumber"
    mv $file $newName
    if [[ ! -d "$curr/kenangan" ]]; then
	    mkdir kenangan
    fi
    mv $newName "kenangan/"
done
mv "wget.log" "wget.log.bak"
