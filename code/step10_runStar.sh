#!/bin/bash
datadir=/u/home/g/gandalm/project-geschwind/NHP_MIA_RNAseq/data/fastq_combined
outputdir=/u/home/g/gandalm/project-geschwind/NHP_MIA_RNAseq/data/bam
code=/u/home/g/gandalm/project-geschwind/NHP_MIA_RNAseq/code

cd $datadir

for file in *_R1.fastq.gz; do

name=`basename $file _R1.fastq.gz`

if ! [ -s ${outputdir}/${name}*.bam ]; then
   echo ${name}_R1.fastq.gz ${name}_R2.fastq.gz
   qsub -o ${code}/log -e ${code}/log -l h_rt=8:00:00,h_data=16G,highp -pe shared 8  ${code}/bash/qsub_star.sh ${name}
fi
done
