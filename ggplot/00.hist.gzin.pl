#! /usr/bin/perl
use strict;
use warnings;

my $list=shift;
my $name=shift;
die "$0 List RowName\n" unless $name;
open(OUT,"> $list.$name.Rscript");
print OUT "pdf(file=\"$list.$name.pdf\")\n";
print OUT "library(\"ggplot2\")\n";

print OUT "
a <- read.table(gzfile(\"$list\"),head=T)\n
ggplot(a,aes(x=a\$$name))+geom_histogram()+xlab(\"$list\")+ylab(\"frequence\")\n
#ggplot(a,aes(x=a\$$name))+geom_histogram()+xlab(\"$list\")+ylab(\"frequence\")\n
";

print OUT "dev.off()\n";
close OUT;
`/ifshk4/BC_PUB/biosoft/PIPE_RD/Package/R-3.1.1/bin/Rscript $list.$name.Rscript`;
`rm $list.$name.Rscript`;
