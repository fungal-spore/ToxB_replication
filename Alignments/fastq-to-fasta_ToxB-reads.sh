#Purpose of this script is to convert reads to fasta format so we can blast them
#Reason to blast is to see if single reads overlap the replication of ToxB
#This confirms that it is no misassembly

#Convert fastq reads to fasta format
mamba activate bbmap
bash reformat.sh in=isolate.fastq out=isolate_reads.fasta

#make blast db of reads
bash makedb.sh isolate_reads.fasta

#blast reads for ToxB-ORF (file format 6)
bash _blast_db.nt ToxB-ORF.nt isolate_reads.fasta

#extract ToxB containing reads
awk '{print $2}' ToxB-ORF.nt.isolate_reads.fasta.blastout > hitlist.txt
mamba deactiavte
python3 extract-gene-list.py isolate_reads.fasta
mv all.fa isolate_reads-w-ToxB.fasta

#align with assembly to confirm overlap
