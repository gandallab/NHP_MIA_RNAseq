#!/bin/bash

k=~/bin/kallisto
k_idx=~/project-geschwind/RefGenome/Macaca_mulatta/Mmul_8/Sequence/WholeGenomeFasta/kallisto_index.idx

outdir=/u/home/g/gandalm/project-geschwind/NHP_MIA_RNAseq/data/kallisto/
datadir=/u/home/g/gandalm/project-geschwind/NHP_MIA_RNAseq/data/fastq_combined
code=/u/home/g/gandalm/project-geschwind/NHP_MIA_RNAseq/code

cd $datadir

for file in *_R1.fastq.gz; do

base=`basename $file _cat_R1.fastq.gz`
R1=${base}_cat_R1.fastq.gz
R2=${base}_cat_R2.fastq.gz

$k quant -i $k_idx -b 50 -o $outdir/$base --rf-stranded --bias $R1 $R2

done
