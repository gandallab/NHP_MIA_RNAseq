#!/bin/bash

#STARcall=~/project-geschwind/bin/STAR-STAR_2.4.2a/bin/Linux_x86_64/STAR
STARcall=/u/home/g/gandalm/bin/STAR-2.5.3a/bin/Linux_x86_64_static/STAR
genomeDir=/u/home/g/gandalm/project-geschwind/RefGenome/Macaca_mulatta/Mmul_8/Sequence/STARindex
genomeFa=/u/home/g/gandalm/project-geschwind/RefGenome/Macaca_mulatta/Mmul_8/Sequence/WholeGenomeFasta/Macaca_mulatta.Mmul_8.0.1.dna.toplevel.fa
mmulGTF=/u/home/g/gandalm/project-geschwind/RefGenome/Macaca_mulatta/Mmul_8/Annotation/Macaca_mulatta.Mmul_8.0.1.87.gtf
datadir=/u/home/g/gandalm/project-geschwind/NHP_MIA_RNAseq/data/fastq_combined
outputdir=/u/home/g/gandalm/project-geschwind/NHP_MIA_RNAseq/data/bam
dir='/'
basereadpair=$1
${STARcall} --runThreadN 8 --genomeDir ${genomeDir} --outFileNamePrefix ${outputdir}/${dir}/${basereadpair} --readFilesCommand gunzip -c --readFilesIn ${datadir}/${basereadpair}_R1.fastq.gz ${datadir}/${basereadpair}_R2.fastq.gz --outSAMtype BAM SortedByCoordinate --outBAMsortingThreadN 8


