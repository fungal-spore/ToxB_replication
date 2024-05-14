#install.packages('Rtools')
#install.packages('gggenomes')
#devtools::install_github("thackl/gggenomes")
#library(gggenomes)
#library(ggplot2)
#install.packages('tidyverse')
#library(tidyverse)
#library(dplyr)


# Load LASTZ output; assuming it's a tab-delimited file with appropriate headers
lastz_output <-read.delim("z:/Gourlie/genome/Ptr/lastz/gggenome_ToxB_lastz.txt", comment.char = "#", header = FALSE)


# Define column names based on your LASTZ output format
colnames(lastz_output) <- c("name1","strand1","start1","end1","length1","name2","strand2","start2","end2","length2","cov","identity")

# filter alignments less than 3000bp for clarity
lastz_output <- lastz_output %>%
  mutate(identity = as.numeric(str_replace(identity, "%", "")))

# Convert to a DataFrame compatible with gggenomes
# Assuming you want to visualize links between name1 and name2
lzlinks <- lastz_output %>%
  transmute(
    seq_id = name1,
    start = start1,
    end = end1,
    seq_id2 = name2,
    start2 = start2,
    end2 = end2,
    strand = strand2,  
    perc_id = identity # Including the % identity column
  ) 

# Read in minimap2 links from .paf file
Minimap2_links <- read_paf("z:/Gourlie/genome/Ptr/lastz/gggenomes_ToxB.paf")

# Read the FASTA file into a seq object
Sanc_seq <- read_fai("z:/Gourlie/genome/Ptr/lastz/gggenomes_ToxB.fasta.fai")

# Read in gff annotation
gff <-read.delim("z:/Gourlie/genome/Ptr/lastz/test2.gff", comment.char = "#", header = FALSE)
colnames(gff) <- c("chr","source","type","start","end","dot","strand","dot2","Feature") 
genes<- gff %>%
  transmute(
    seq_id=chr,
    start= start,
    end = end,
    strand= strand,
    feat_id = type)

rhg_cols <- c("red","#F27314", "#E25033", "#AA3929", "yellow", 
              "pink", "green", "#000000", "#D0E1F9", "blue")

# my test
gggenomes(
  seqs = Sanc_seq, links= lzlinks, genes = genes)+
  #feats = list(emale_tirs, ngaros=emale_ngaros, gc=emale_gc)) |> 
  #add_sublinks(emale_prot_ava) |>
  #sync() + # synchronize genome directions based on links
  #geom_feat(position="identity", size=6) +
  geom_bin_label(expand_left = .5) +
  geom_seq(size=1.2) +
  geom_link(color="cornsilk3",alpha=0.4) +
  geom_bin_label() +
  geom_gene(aes(fill=feat_id), size=4)+
  theme(legend.text=element_text(size=15),
        legend.title = element_text(size=17),
        axis.text.x=element_text(size=15))+
  scale_fill_manual("Features", values=rhg_cols)

