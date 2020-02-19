#1a
a=`awk -F "\t" 'FNR == 1 {next} {totalRegion[$13]+=$21} END{for(region in totalRegion){print totalRegion[region],region}}' Sample-Superstore.tsv | sort -g | awk 'NR<2{print $2}'`
echo 'Region dengan profit terendah adalah' $a

#1b
b=`awk -F "\t" -v resultA="$a" 'FNR == 1 {next} {if($13 ==resultA) totalState[$11]+=$21} END{for(state in totalState){print totalState[state],state}}' Sample-Superstore.tsv | sort -g | awk 'NR<3{print $2}'`
firstState=`echo "$b" | sed -n "1p"`
secondState=`echo "$b" | sed -n "2p"`

echo -e '\n2 State dengan profit terendah adalah'  $firstState "dan" $secondState


#1c
c=`awk -F "\t" -v firstState="$firstState" -v secondState="$secondState" 'FNR == 1 {next} {if($11 == firstState || $11 == secondState) totalProduct[$17]+=$21} END{for(product in totalProduct){print totalProduct[product]"->"product}}' Sample-Superstore.tsv | sort -g | awk -F "->" 'NR<11{print $2}'`
echo -e '\n10 Produk dengan profit terendah adalah :\n'"$c"