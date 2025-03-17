# Path to your FASTA file
fasta_file="gggenomes_ToxB.fasta"

# Run lastz and output with useful fields.Note most important setting is to report start2+ and end2+ which reports alignments on plus
# strand. This is REQUIRED for correct plotting of hits on the minus strand by gggenomes()
lastz ${fasta_file}[multiple] ${fasta_file}[multiple] --gapped --step=20 --seed=12of19 --output=gggenome_ToxB_lastz.txt --hspthresh=3000 --format=general:name1,strand1,start1,end1,length1,name2,strand2,start2+,end2+,length2,identity
