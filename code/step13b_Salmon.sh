## step13b_Salmon.sh
## prepare and submit batch job for Salmon quantification of TEs


SALMON_BIN=/u/nobackup/dhg/Software/salmon/Salmon-0.7.2_linux_x86_64/bin/salmon

## define directories
REFDIR=/u/nobackup/dhg/sparhami/tools/SalmonTE/reference/scripts
BASEDIR=/u/project/geschwind/gandalm/NHP_MIA_RNAseq
FQDIR=$BASEDIR/data/fastq_unzipped


## create index for RepeatMasker MMU transposable elements
#$SALMON_BIN index -t $REFDIR/mmu.fa -i $REFDIR/mmu_index --type quasi -k 31

## set up list of fastqs
FQ1_TXT=$BASEDIR/data/Salmon_DESeq2/fq1.txt
FQ2_TXT=$BASEDIR/data/Salmon_DESeq2/fq2.txt

#ls $FQDIR -1 | grep R1 > $FQ1_TXT
#cp $FQ1_TXT tmp.txt
#sed 's/R1/R2/g' tmp.txt > $FQ2_TXT
#rm tmp.txt

N_FQ=$( wc -l $FQ1_TXT | awk '{print $1}' )


## submit batch job to queue
qsub -t 1:$N_FQ -N salmon $BASEDIR/code/bash/qsub_salmon.sh