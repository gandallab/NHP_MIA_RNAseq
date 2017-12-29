## step12a_quantSalmonTE.sh
## perform counts for transposable elements ID'd by Salmon using SalmonTE

module load R/3.4.0 ## R >= 3.3 req'd for tximport package
module load anaconda
source activate SalmonTE ## anaconda environment

BASEDIR=/u/project/geschwind/gandalm/NHP_MIA_RNAseq
FQDIR=$BASEDIR/data/fastq_unzipped

FQ1_TXT=$BASEDIR/data/SalmonTE/fq1.txt
FQ2_TXT=$BASEDIR/data/SalmonTE/fq2.txt

ls $FQDIR -1 | grep R1 > $FQ1_TXT
cp $FQ1_TXT tmp.txt
sed 's/R1/R2/g' tmp.txt > $FQ2_TXT
rm tmp.txt

N_FQ=$( wc -l $FQ1_TXT | awk '{print $1}' )


## call to SalmonTE quant for each fastq
qsub -t 1:$N_FQ -N salmonTE.quant $BASEDIR/code/bash/qsub_SalmonTE_quant.sh
