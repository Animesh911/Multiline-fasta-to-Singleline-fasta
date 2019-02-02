#!/usr/local/bin/perl

open(FILE, "parseseq.fasta"); #parseseq.fasta is a multiline fasta

my @FileData=<FILE>;
open(OUTFILE,">refined_parseseq.fasta");
my $fil=join("",@FileData);
@df=split(">", $fil);
foreach(@df)
{
@df1=split("\n",$_);
$df1[0].="|";
my $seq=join("",@df1);
print OUTFILE $seq."\n";
}
