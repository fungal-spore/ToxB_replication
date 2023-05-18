#Fungap command, need conda envs fungap3 active and paths from .bashrc
#Same RNA source as: https://bmcbiol.biomedcentral.com/articles/10.1186/s12915-022-01433-w
#Augustus species selected via option with Fungap

mamba activate fungap3
python ~/FunGAP/fungap.py \
 --output_dir /isilon/projects/P-3807_Ptr-genomics/predic/225796_Pseminiperda/ \
 --trans_read_1 /isilon/projects/P-3807_Ptr-genomics/rna/Ptr-veg_1.fastq \
 --trans_read_2 /isilon/projects/P-3807_Ptr-genomics/rna/Ptr-veg_2.fastq \
 --genome_assembly /isilon/projects/P-3807_Ptr-genomics/assembly/hi-canu/225796_Pseminiperda/225796_Pseminiperda.contigs.fasta \
 --augustus_species magnaporthe_grisea \
 --sister_proteome /isilon/projects/P-3807_Ptr-genomics/predic/sister_orgs/prot_db.faa \
 --num_cores 40
