#Script for basic Ptr assembly with CANU
#Polish with Pilon+short-read after if available

samtools bam2fq ~/gourlier/_raw/_pacbio_set2/isolate.subreads.bam > isolate.subreads.fq
canu -p isolate -d ~/gourlier/assembly/canu/isolate gridEngineResourceOption="-pe smp 40 -l mem_free=300" genomesize=40m -pacbio-raw isolate.subreads.fq
