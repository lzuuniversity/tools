#!/usr/bin/perl
use warnings;
use strict;

# test bin size, make sure that for the bin size you are using the ratio of average to its sd is around 4-5.
# cnvnator -root file.root -eval bin_size


# you may want to change few things first:
my $cnvnator='/home/wanglizhong/software/cnvnator/CNVnator_v0.2.7/src/cnvnator';
#my @bin=(50,100,150,200,250,300,350,400,450,500,550,600,650,700,750,800,850,900,950,1000);
#my @bin=(700,800,900,1000,1100,1200,1300,1400);
#my @bin=(1500,1600,1700,1800,1900,2000,2100,2200,2300,2400,2500,3000,4000,5000);
my @bin=(50,100,200,300,400,500,800,1000,1500);
my $in="bam.list"; # input file is bamlist

my $present_dir=`pwd`;chomp $present_dir;
my $outdir="$present_dir/$0.out"; 
`mkdir -p $outdir`;
open(O1,">  $0.sh");

foreach my $bin(@bin){
    open(IN,"$in");
    while(<IN>){
	chomp;
	my @s=split(/\t/,$_);
	my $tem=(split(/\//,$_))[-1];
	my $sample=(split(/\./,$tem))[0];
	my $bam=$_;
	
	my $cnv="$outdir/$sample"; 
	`mkdir -p $cnv`;
	
	my $chr="Chr1";
	my $chrdir="/ifshk5/PC_HUMAN_EU/USER/zhuwenjuan/work/Cattle/step12.CNV/split_chr";
	my $head="$chr.$bin";
	
	#print O1 "export ROOTSYS=/ifshk5/PC_HUMAN_EU/USER/zhuwenjuan/bin/software/root;export LD_LIBRARY_PATH=/ifshk5/PC_HUMAN_EU/USER/zhuwenjuan/bin/software/root/lib:\$LD_LIBRARY_PATH;cd $cnv;";
	print O1 "export ROOTSYS=/home/wanglizhong/software/root/root-5.34.36;export LD_LIBRARY_PATH=/home/wanglizhong/software/root/root-5.34.36/lib:\$LD_LIBRARY_PATH; cd $cnv;";
	print O1 "$cnvnator -root $sample.$head.root -unique -tree $bam -chrom $chr >$sample.$head.root.l1 2>$sample.$head.root.e1;  ";
	print O1 "$cnvnator -root $sample.$head.root -d $chrdir  -his $bin -chrom $chr >$sample.$head.root.l2 2>$sample.$head.root.e2;";
	print O1 "$cnvnator -root $sample.$head.root -stat $bin -chrom $chr >$sample.$head.root.l3 2>$sample.$head.root.e3;";
	print O1 "$cnvnator -root $sample.$head.root -partition $bin -chrom $chr >$sample.$head.root.l4 2>$sample.$head.root.e4;";
	print O1 "$cnvnator -root $sample.$head.root -call $bin -chrom $chr > $sample.$head.cnv 2>$sample.$head.root.e5;\n";
    }
    close IN;
}
close O1;

