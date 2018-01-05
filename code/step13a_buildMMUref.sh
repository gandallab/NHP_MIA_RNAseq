## step13a_buildMMUref.sh
## extract primate + ancestral (belonging to higher taxon) transposable elements from RepBase browser tool
## Using RepBase 22.12, retrieved 1/3/2018
RBDIR=/u/nobackup/dhg/sparhami/tools/RepBase
#wget -O $RBDIR/primateTE.fa http://mgandal:cali4nia@www.girinst.org/protected/repbase_extract.php?division=Primates&customdivision=&rank=&type=Transposable+Element&autonomous=1&nonautonomous=1&simple=1&format=FASTA&full=true


## using wget gives us a lot of extra text not in FASTA format--copy-paste sequences from this url into primateTE.fa
