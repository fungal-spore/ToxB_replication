
#Convert fastq reads to fasta format
mamba activate bbmap
bash reformat.sh in=file.fasta out=file.fasta

#make blast db of reads
#blast reads for ToxB-ORF 
#extract ToxB containing reads
#align with assembly to confirm overlap
