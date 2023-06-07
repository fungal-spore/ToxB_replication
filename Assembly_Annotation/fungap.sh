#Fungap command, need conda envs fungap3 active and paths from .bashrc
#See publication for RNA details
#Augustus species selected via option with Fungap

mamba activate fungap3
python ~/FunGAP/fungap.py \
 --output_dir /isilon/projects/J-003002_Ptr_genomics/predic/I-33-16_hicanu/ \
 --trans_read_1 /isilon/projects/J-003002_Ptr_genomics/rna/Ptr-veg_1.fastq \
 --trans_read_2 /isilon/projects/J-003002_Ptr_genomics/rna/Ptr-veg_2.fastq \
 --genome_assembly /isilon/projects/J-003002_Ptr_genomics/assembly/hi-canu/I-33-16_hicanu/I-33-16_hicanu.contigs.fasta \
 --augustus_species magnaporthe_grisea \
 --busco_dataset pleosporales_odb10 \
 --sister_proteome /isilon/projects/J-003002_Ptr_genomics/predic/sister_orgs/prot_db.faa \
 --num_cores 20

#generate dna files, run only produces amino acid
cd /isilon/projects/J-003002_Ptr_genomics/predic/I-33-16_hicanu/fungap_out/
python3 ~/FunGAP/gff3_transcript.py -f /isilon/projects/J-003002_Ptr_genomics/assembly/hi-canu/I-33-16_hicanu/I-33-16_hicanu.contigs.fasta -g fungap_out.gff3

#run busco on final dataset
/home/AAFC-AAC/gourlier/mambaforge/envs/fungap3/bin/busco \
 --mode proteins --out busco \
 --in /isilon/projects/J-003002_Ptr_genomics/predic/SW21-5_hicanu/fungap_out/fungap_out_prot.faa \
 --out_path /isilon/projects/J-003002_Ptr_genomics/predic/SW21-5_hicanu/fungap_out \
 --lineage_dataset /isilon/projects/J-003002_Ptr_genomics/predic/busco_downloads/lineages/pleosporales_odb10 \
 --force
