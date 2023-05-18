#Script for assembling HiFi with hi-CANU; followed by quast assembly statistics
#do not polish with short-reads; it is not recommended

#run from hi-canu directory
#1 = isolate name
#2 = hifi.fastq

#activate env
mamba activate canu
#make output directory
mkdir $1
#assemble with hi-canu
canu -p $1 -d ~/assembly/hi-canu/$1_hi-canu gridEngineResourceOption="-pe smp 20 -l mem_free=300" genomesize=50m -pacbio-hifi ~/_raw/_pacbiohifi/$2

#run quast on assembly
cd ~/assembly/hi-canu/$1_hi-canu
mamba activate quast
quast $1.contigs.fasta
