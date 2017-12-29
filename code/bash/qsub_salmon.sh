## qsub_salmon.sh

#!/bin/bash
#$ -l highp,h_data=10G,h_vmem=10G,h_rt=10:00:00
#$ -pe shared 4
#$ -V
#$ -o /u/project/geschwind/gandalm/NHP_MIA_RNAseq/data/Salmon_DESeq2/log
#$ -e /u/project/geschwind/gandalm/NHP_MIA_RNAseq/data/Salmon_DESeq2/log


SALMON_BIN=/u/nobackup/dhg/Software/salmon/Salmon-0.7.2_linux_x86_64/bin/salmon

## define directories
REFDIR=/u/nobackup/dhg/sparhami/tools/SalmonTE/reference/scripts
BASEDIR=/u/project/geschwind/gandalm/NHP_MIA_RNAseq
FQDIR=$BASEDIR/data/fastq_unzipped

FQ1_TXT=$BASEDIR/data/Salmon_DESeq2/fq1.txt
FQ2_TXT=$BASEDIR/data/Salmon_DESeq2/fq2.txt
IFS=$'\n' readarray -t FQ1_LIST < $FQ1_TXT
IFS=$'\n' readarray -t FQ2_LIST < $FQ2_TXT
ind=$( expr $SGE_TASK_ID - 1 )
INFQ1=$FQDIR/${FQ1_LIST[${ind}]}
INFQ2=$FQDIR/${FQ2_LIST[${ind}]}
S=${FQ1_LIST[${ind}]}
S=$(echo $S | sed 's/_cat_R1.fastq//')


## Salmon quantification
## -l/LibType for MMU fastqs ISR (inward, stranded, reverse)
## or set A to determine automatically
$SALMON_BIN quant -i $REFDIR/mmu_index -l ISR -1 $INFQ1 -2 $INFQ2 -o $BASEDIR/data/Salmon_DESeq2/mmu_quant/$S



## if this was faster than 10 minutes, sleep for the rest
END=$SECONDS
ELAPSED=$((END-START))
if [ "$ELAPSED" -lt 600 ]; then
  TOSLEEP=$((600 - ELAPSED))
  sleep $TOSLEEP
fi

