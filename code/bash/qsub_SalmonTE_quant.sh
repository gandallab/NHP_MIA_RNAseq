#!/bin/bash
#$ -l highp,h_data=10G,h_vmem=10G,h_rt=10:00:00
#$ -pe shared 4
#$ -V
#$ -o /u/project/geschwind/gandalm/NHP_MIA_RNAseq/data/SalmonTE/log
#$ -e /u/project/geschwind/gandalm/NHP_MIA_RNAseq/data/SalmonTE/log
#$ -N salmonTE.quant

BASEDIR=/u/project/geschwind/gandalm/NHP_MIA_RNAseq
FQDIR=$BASEDIR/data/fastq_unzipped

FQ1_TXT=$BASEDIR/data/SalmonTE/fq1.txt
FQ2_TXT=$BASEDIR/data/SalmonTE/fq2.txt
IFS=$'\n' readarray -t FQ1_LIST < $FQ1_TXT
IFS=$'\n' readarray -t FQ2_LIST < $FQ2_TXT
ind=$( expr $SGE_TASK_ID - 1 )
INFQ1=$FQDIR/${FQ1_LIST[${ind}]}
INFQ2=$FQDIR/${FQ2_LIST[${ind}]}
OUTDIR=$BASEDIR/data/SalmonTE/quant${ind}

SalmonTE.py quant --reference=hs --exprtype=count --outpath=$OUTDIR $INFQ1 $INFQ2

## if this was faster than 10 minutes, sleep for the rest
END=$SECONDS
ELAPSED=$((END-START))
if [ "$ELAPSED" -lt 600 ]; then
  TOSLEEP=$((600 - ELAPSED))
  sleep $TOSLEEP
fi

