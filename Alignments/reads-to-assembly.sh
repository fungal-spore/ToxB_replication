#usage: bash reads-to-assembly.sh genome1 reads2 isolate-name

#build genome index
bowtie2-build $1 $3

#align reads to
bowtie2 -p 8 -x $3 -U $2 -S $3_aligned-reads.sam

#convert alignment from SAM to BAM
samtools view -S -b $3_aligned-reads.sam > $3_aligned-reads.bam
rm $3_aligned-reads.sam

#sort BAM by position
samtools sort $3_aligned-reads.bam -o $3_aligned-reads.sort.bam
rm $3_aligned-reads.bam

#index the sorted BAM file
samtools index $3_aligned-reads.sort.bam

#import to IGV to see read coverage
