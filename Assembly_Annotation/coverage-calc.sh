#mamba activate minimap
#align raw reads to assembly
minimap2 -ax map-pb ~/assemblies/isolate_hicanu.contigs.fasta ~/_raw/sequences/isolate.fastq > isolate.sam

#mamba activate samtools
#convert aligned sam file to bam format
samtools view -bS isolate.sam > isolate.bam
#sort bam file
samtools sort isolate.bam -o isolate.sorted.bam
#calculate depth by position
samtools depth -a isolate.sorted.bam > isolate.coverage
#get the average of the 3rd column 
awk '{sum+=$3} END {print "Average coverage:", sum/NR}' isolate.coverage > isolate.avg.coverage

