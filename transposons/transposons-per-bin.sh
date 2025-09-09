# Transposon density counter

# Index and filter assembly
samtools faidx I-73-1_flye.contigs.fasta
cut -f1,2 I-73-1_flye.contigs.fasta.fai > I-73-1.chrom.sizes
awk '$2 >= 100000' I-73-1.chrom.sizes > I-73-1.chrom.sizes.filtered

# Create 50kbp bins (-w for size) as a bed file for use with intersect
bedtools makewindows -g I-73-1.chrom.sizes.filtered -w 50000 > I-73-1.50kb-bins.bed

# EDTA does not output a bed file, use the following to convert gff3 to bed
# Double check tig names in the bed file, some may be truncated and need fixing with sed
# EarlGrey can skip and go right to next step
awk '$0 !~ /^#/ {print $1"\t"($4-1)"\t"$5"\t"$3}' I-73-1.EDTA.intact.raw.gff3 > I-73-1.EDTA.bed

# Intersect transposon bed file with the bin bed file, output counts (-c)
# Can use this output in R density plots
bedtools intersect -a I-73-1.50kb-bins.bed -b I-73-1.filteredRepeats.bed -c > I-73-1.50kb-bins.counts.earlGrey.bed
