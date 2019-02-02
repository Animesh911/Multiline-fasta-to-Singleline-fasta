#!/usr/local/bin/perl

open(FILE, "refined_parseseq.fasta");
my @files=<FILE>;
open(COOR, "seqid");
my @seqi=<COOR>;
open (POSITIVE, ">precursor.fasta");

for($i=0;$i<=$#seqi;$i++){
chomp($seqi[$i]);
chomp($files[$i]);
@seqid=split("\t", $seqi[$i]);
@filed=split('\|', $files[$i]);
$end=$seqid[$#seqid];
$start=$seqid[$#seqid-1]-1;
$med1=$start;
$med2=$end;
#print $start."\t".$end."\n";
$file=$#filed;
$rflank=150;
$lflank=150;
if ($end<$start){$end=$start+1;$start=$med2-1;}
$inv=$end-$start;
if (($start-$lflank)<0){
$lflank=$start;
}
if(($end+$lflank)>length($filed[$file])){
$rflank=length($filed[$file])-$end;
}
$invt=$inv+$lflank+$rflank;
print $inv."\t".$lflank."\t".$rflank."\t".$invt."\n";
$seq=substr($filed[$file], $start-$lflank, $invt);
if ($med2<$med1){$seq=~tr/ATGC/TACG/;
$seq=reverse($seq);}
print POSITIVE $seq."\n";
}
