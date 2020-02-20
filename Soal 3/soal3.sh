# lastNumber=$(ls | sed 's/pdkt_kusuma_//' | sort -n | tail -1)
# if [[ !($lastNumber =~ [0-9]) ]];then 
#     lastNumber=0
#     echo "1"
# elif [[ ($lastNumber =~ [0-9]) && ($lastNumber =~ [a-zA-Z]) ]];then
#     lastNumber=0
# fi
# echo $lastNumber
# for ((i=lastNumber+1; i<=lastNumber+28; i++))
# do
#     wget -O "pdkt_kusuma_${i}" "https://loremflickr.com/320/240/cat" 2>&1 | tee -a wget.log 
# done

# 5 6-23/8 * * 0-5 /home/samuel/Documents/

awk '/resized\/*\.jpg{print}' wget.log