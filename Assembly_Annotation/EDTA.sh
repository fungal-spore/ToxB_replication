#Annotate genome with EDTA
# mamba activate EDTA
#Run EDTA on individual assemblies
perl ~/EDTA/EDTA.pl --genome ~/assemblies/Ptr/isolate_hicanu.contigs.fasta --sensitive 1 --anno 1 --threads 40
