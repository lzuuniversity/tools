my $dir=shift;
die "$0 (dir)01.depth.pl.05.vst.pl.b0.2.txt.sort.head100\n"unless $dir;

my @sample_dp=(NA,NA);
my @id=(NA,NA);
open(I,"00.id.pl.txt");
while(<I>){
    chomp;
    my @a=split(/\s+/);
    push(@sample_dp,$a[2]);
    push(@id,$a[1]);
}
close I;
#print join("\t",@depth);

open(O1,"> $0.$dir.1.sh");
open(O2,"> $0.$dir.2.sh");
open(O3,"> $0.$dir.3.sh");
open(O4,"> $0.$dir.4.sh");
my @depth=<$dir/*/*depth.gz>;
foreach my $depth(@depth){
    print O1 "perl AveregeTo1.pl $depth ; perl AveregeTo1.v2.pl $depth;\n";
    print O2 "perl plotDepth.pl $depth; convert -sample 500%x500% $depth.V1.pdf $depth.V1.png;\n";
    print O3 "perl plotDepth.V3.pl $depth;  convert -sample 500%x500% $depth.V3.pdf $depth.V3.png; \n";
    print O4 "perl plotDepth.v2.pl $depth; convert -sample 500%x500% $depth.V2.pdf $depth.V2.png;\n";
    
}
close O1;
close O2;
close O3;
close O4;
