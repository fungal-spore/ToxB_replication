# -X skips self and dual mapping
# -N reatin secondary alignments
# -p minimum secondary-to-primary score ratio
# -c ouptu cigar to PAF
minimap2 -X -N 5 -p 0.5 -c gggenomes_ToxB.fasta gggenomes_ToxB.fasta > gggenomes_ToxB.paf
