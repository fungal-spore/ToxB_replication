#Usage: bash reads-2-contig.sh reference_sequence reference_name fastq_R1 fastq_                                                                  R2 isolate_name
#Programs: bowtie2 and samtools

# Script for aligning raw fastq reads to a reference genome
# Output will be a sorted BAM file
# Sorted BAM and its BAI index can be imported to IGV for viewing

#mamba activate bowtie2

#build an index for reference genome
bowtie2-build $1 $2

#align reads to reference
# -p is number of cpus
# -x is reference genome name used above
# -U is a file which contains a list of unpaired fastq files (i.e. single long r                                                                  ead fastq)
# -1 is a file which contains a list of read set 1 from paired data
# -2 is a file which contains a list of read set 2 from paired data
# -S output is SAM file
# need to replace 'isolate' with actual isolate name
bowtie2 -p 2 -x $2 -1 $3 -2 $4 -S $5_aligned-reads.$2.sam

#mamba activate samtools

#convert alignment file from SAM format to BAM
# -S indicates input is a SAM file
# -b indicates output is a BAM file
samtools view -S -b $5_aligned-reads.$2.sam > $5_aligned-reads.$2.bam

#sort BAM file by position
samtools sort $5_aligned-reads.$2.bam -o $5_aligned-reads.$2.sort.bam

#index the sorted BAM file
samtools index $5_aligned-reads.$2.sort.bam

#cleanup intermediate files
rm $5_aligned-reads.$2.sam $5_aligned-reads.$2.bam
