# transposon/repeat density
data <- read.table('X:/0transfer/I73-1.fasta.mod.EDTA.TEanno.gff3.stripped')
data <- read.table('X:/0transfer/K11_hicanu.contigs.fasta.mod.EDTA.TEanno.gff3.stripped')

#function to shift a column up or down by 1
shiftup <- function(x, n){
  c(x[-(seq(n))], rep(0, n))
}

shiftdown <- function(x, n){
  c(x[+(seq(n))], rep(0, n))
}

#all genes
repeat_frame <- data[,]

#duplicate columns
repeat_frame$V3.2 <- repeat_frame$V3
repeat_frame$V4.2 <- repeat_frame$V4

#shift duplicates up by 1
repeat_frame$V4.2 <- shiftup(repeat_frame$V4.2, 1)
repeat_frame['V3.2'] <- c(0, head(repeat_frame['V3.2'], dim(repeat_frame)[1] - 1)[[1]])

#length
#repeat_frame$length <- repeat_frame$V4 - repeat_frame$V3
#intergenic distance 3' of previous gene to 5' of the current gene
repeat_frame$fiveITL <- repeat_frame$V4 - repeat_frame$V3.2
#intergenic distance 3' of the current gene to 5' of the next
repeat_frame$threeITL <- repeat_frame$V4.2 - repeat_frame$V3

repeat_frame <- repeat_frame[repeat_frame$fiveITL >= 0, ]
repeat_frame <- repeat_frame[repeat_frame$threeITL >= 0, ]

#subset single contig
tig <- subset(repeat_frame, V1 == "contig_1_pilo")
tig <- subset(repeat_frame, V1 == "contig_2_pilo")
tig <- subset(repeat_frame, V1 == "contig_3_pilo")
tig <- subset(repeat_frame, V1 == "contig_6_pilo")
tig <- subset(repeat_frame, V1 == "contig_7_pilo")
tig <- subset(repeat_frame, V1 == "contig_9_pilo")
tig <- subset(repeat_frame, V1 == "contig_12_pil")
tig <- subset(repeat_frame, V1 == "contig_16_pil")
tig <- subset(repeat_frame, V1 == "contig_17_pil")
tig <- subset(repeat_frame, V1 == "contig_18_pil")
tig <- subset(repeat_frame, V1 == "contig_20_pil")

tig <- subset(repeat_frame, V1 == "tig00000047")

#library(dplyr)

#Set break limits for mutate(cut())
min_val <- 0
max_val <- max(tig$V3)
breaks <- seq(from = min_val, to = max_val, by = 50000)

#Break into bins based on set break points
tig_bin <- tig %>%
  mutate(bins = cut(V3, 
                    breaks = breaks, 
                    labels = paste(head(breaks, -1), tail(breaks, -1), sep = "-"),
                    right = FALSE))
count_table<-as.data.frame(table(tig_bin$bins))
#setting for highlighting specific
count_table <- count_table %>% mutate( ToHighlight = ifelse( Var1 == "500000-550000", "yes", "no" ) )

I731tig12plot <- ggplot(count_table, aes(Var1, Freq, fill = ToHighlight))+
  geom_bar(width = 0.5, color = 'black', stat="identity") +
  theme(text = element_text(size = 10), axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))+
  scale_fill_manual(values = c( "yes"="tomato", "no"="skyblue" ), guide = FALSE )+
  xlab("50 Kb bins")+
  ylab("Transposon frequency")+
  ylim(0,50)

I731tig12plot

K11tig47plot <- ggplot(count_table, aes(Var1, Freq))+
  geom_col(width = 0.5, fill = 'skyblue', color = 'black') +
  theme(text = element_text(size = 10), axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))+
  xlab("50 Kb bins")+
  ylab("Transposon frequency")+
  ylim(0,50)

library(cowplot)
plot_grid(I731tig12plot,K11tig47plot,labels = c('I-73-1 tig12', 'K11 tig47'), label_size = 15)




# hexplot
iso <- ggplot(repeat_frame, aes(x=threeITL,y=fiveITL)) +
  geom_hex(aes(color=..count..),bins=50)+
  scale_fill_distiller(palette = "Spectral", name="repeat\ncount")+
  #geom_point(data=subset(table2, group == "SP"), color = 'black',alpha = 0.25)+
  #geom_point(data=subset(table2, Gene_name == "BLGH_03023"), color = 'orange',alpha = 1)+
  #geom_point(data=subset(table2, Gene_name == "BLGH_03022"), color = 'orange',alpha = 1)+
  #geom_point(data=subset(table2, Gene_name == "BLGH_02099"), color = 'red',alpha = 1)+
  scale_x_log10()+
  scale_y_log10()+
  ylab("5' prime intergenic length (bp)") +
  xlab("3' prime intergenic length (bp)") +
  guides(color = FALSE)+
  ggtitle("I73-1 ITLs")+
  theme_minimal()
iso

