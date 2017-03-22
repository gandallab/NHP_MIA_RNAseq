#!/bin/bash

STARcall=/u/home/g/gandalm/bin/STAR-2.5.2b/bin/Linux_x86_64/STAR

#Downloaded from: ftp://ftp.ensembl.org/pub/release-87/fasta/macaca_mulatta/dna/Macaca_mulatta.Mmul_8.0.1.dna.toplevel.fa.gz
GenomeFA=/u/home/g/gandalm/project-geschwind/RefGenome/Macaca_mulatta/Mmul_8/Sequence/WholeGenomeFasta/Macaca_mulatta.Mmul_8.0.1.dna.toplevel.fa

#Downloaded from:ftp://ftp.ensembl.org/pub/release-87/gtf/macaca_mulatta/Macaca_mulatta.Mmul_8.0.1.87.gtf.gz
GTF=/u/home/g/gandalm/project-geschwind/RefGenome/Macaca_mulatta/Mmul_8/Annotation/Macaca_mulatta.Mmul_8.0.1.87.gtf

STARindex=/u/home/g/gandalm/project-geschwind/RefGenome/Macaca_mulatta/Mmul_8/Sequence/STARindex


${STARcall} --runThreadN 1 --runMode genomeGenerate --genomeFastaFiles $GenomeFA --sjdbGTFfile $GTF --genomeDir $STARindex
