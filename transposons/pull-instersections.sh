# trim intersect file
awk -v OFS='\t' '{print $4,$5,$6,$7,$8,$9}' $1 > intersects.bed

# extract sequences; $2 is genome file; -s uses strandedness to revcomp seq
bedtools getfasta -fi $2 -bed intersects.bed -name -s -fo $1.SJ-TEs.fasta

rm intersects.bed
