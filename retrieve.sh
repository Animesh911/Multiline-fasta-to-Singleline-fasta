#!/bin/bash

#export COORD=/backup/uba1/animesh/millet/microRNA/cutting/coordinate.txt

while read x y z
do
var1=`echo $z-$y | bc`
if [ "$var1" -gt '0' ]
then
	echo $x $y $z >> buff_Coord_1D.txt
else
	echo $x $z $y >> buff_Coord_1D.txt
fi

done < coordinate.txt

while read a b c
do
bb=`echo $b - 100 | bc`
cc=`echo $c + 100 |bc`
echo $a $bb $cc $b-$c >> buff_Coord_1Dn100UpDn.txt

done < buff_Coord_1D.txt


while read d e f
do
var2=`grep -w "$d" lncRNA_lngth.txt | awk '{print $2}'`
#echo ${var2[*]}
#echo $var2
if [[ "$e" -gt "0"  &&  "$f" -le  "$var2" ]];
then
blastdbcmd -db lncpred.fasta -entry $d -range $e-$f >> buff_final_Coord_1Dn100UpDn.fa 
elif [[ "$e" -le "0"  &&  "$f" -le  "$var2" ]];
then
blastdbcmd -db lncpred.fasta -entry $d -range 1-$f >> buff_final_Coord_1Dn100UpDn.fa 
elif [[ "$e" -gt "0"  &&  "$f" -gt  "$var2" ]];
then
blastdbcmd -db lncpred.fasta -entry $d -range $e-$var2 >> buff_final_Coord_1Dn100UpDn.fa 

fi
done < buff_Coord_1Dn100UpDn.txt