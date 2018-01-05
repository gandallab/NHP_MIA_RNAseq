## step13c_aggregateCounts.sh
## aggregate sample-by-sample counts for TEs as output by Salmon
## stats are: length, effective length, TPM, NumReads (estimate of absolute count)


## define directories
BASEDIR=/u/project/geschwind/gandalm/NHP_MIA_RNAseq
QUANTDIR=$BASEDIR/data/Salmon_DESeq2/quant_files
COUNTDIR=$BASEDIR/data/Salmon_DESeq2/counts
FQDIR=$BASEDIR/data/fastq_unzipped
cd $COUNTDIR

## initialize files for writing results
if [ -e "TE_lengths.csv" ]; then rm TE_lengths.csv; fi
if [ -e "TE_efflengths.csv" ]; then rm TE_efflengths.csv; fi
if [ -e "TE_TPM.csv" ]; then rm TE_TPM.csv; fi
if [ -e "TE_counts.csv" ]; then rm TE_counts.csv; fi
touch TE_lengths.csv; touch TE_efflengths.csv; touch TE_TPM.csv; touch TE_counts.csv 


## set up fastq pairs
FQ1_TXT=$BASEDIR/data/Salmon_DESeq2/fq1.txt
IFS=$'\n' readarray -t FQ1_LIST < $FQ1_TXT
N_FQ=$( wc -l $FQ1_TXT | awk '{print $1}' )


## loop through each sample to extract counts, etc. from tab-delimited columns
## Name	Length	EffectiveLength	TPM NumReads
for ((ind = 0; ind < $N_FQ; ind++)); do
     S=${FQ1_LIST[${ind}]}
     S=$(echo $S | sed 's/_cat_R1.fastq//')
     s_file=$QUANTDIR/$S/quant.sf
     if [ "$ind" -eq 0 ]; then
	  ## extract list of elements
          elements=$( cut -f 1 $s_file | tail -n +2 ) ## omit header
          col_TE="TE $elements"
          echo $col_TE | tr " " "\n" >> TE_lengths.csv ## 1 value per line
          echo $col_TE | tr " " "\n" >> TE_efflengths.csv
          echo $col_TE | tr " " "\n" >> TE_TPM.csv
          echo $col_TE | tr " " "\n" >> TE_counts.csv
     fi


     lengths=$( cut -f 2 $s_file | tail -n +2 ) ## omit header
     col_lengths="$S $lengths"
     efflengths=$( cut -f 3 $s_file | tail -n +2 )
     col_efflengths="$S $efflengths"
     TPM=$( cut -f 4 $s_file | tail -n +2 )
     col_TPM="$S $TPM"
     counts=$( cut -f 5 $s_file | tail -n +2 )  ## extract raw salmon counts, which are under the header NumReads
     col_counts="$S $counts"


     ## use process substitution to paste new column into file
     paste TE_lengths.csv <(echo $col_lengths | tr " " "\n") > temp1.csv  ## 1 value per line
     mv temp1.csv TE_lengths.csv

     paste TE_efflengths.csv <(echo $col_efflengths | tr " " "\n") > temp2.csv
     mv temp2.csv TE_efflengths.csv

     paste TE_TPM.csv <(echo $col_TPM | tr " " "\n") > temp3.csv
     mv temp3.csv TE_TPM.csv

     paste TE_counts.csv <(echo $col_counts | tr " " "\n") > temp4.csv  ## 1 value per line
     mv temp4.csv TE_counts.csv
 done










