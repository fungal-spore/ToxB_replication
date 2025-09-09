# Transposon density
#25-09-09

library(ggplot2)
library(readr)
library(dplyr)

# Import data; pick EDTA output or EarlGrey
data <- read.table("~/I-73-1.50kb-bins.counts.EDTA.bed")
data <- read.table("~/I-73-1.50kb-bins.counts.earlGrey.bed")
colnames(data) <- c("chrom", "start", "end", "count")

# Average across the whole genome
mean_per_bin <- mean(data$count)
mean_per_Mb <- mean_per_bin / 50000 * 1e6

# Average for each contig
per_chr <- data %>%
  group_by(chrom) %>%
  summarise(mean_per_bin = mean(count), mean_per_Mb = mean(count) / 50000 * 1e6)
print(per_chr)

# pick a contig to look at in detail
chr  <- "contig_12_pilon"
start <- 50000
end   <- 100000

# output each bin along with counts and densities
bin <- data %>%
  dplyr::filter(chrom == chr, start == start, end == end) %>%
  dplyr::mutate(bin_size = end - start,
    density_per_bp = count / bin_size,
    density_per_Mb = count / bin_size * 1e6)
print(bin)

# plot the whole genome density; change lab for EDTA or EarlGrey
ggplot(data, aes(x = count)) +
  geom_density(fill = "steelblue", alpha = 0.5, adjust = 1.2) +
  labs(x = "Number of EarlGrey annotations per 50 kbp bin",
       y = "Density")+
  theme_minimal(base_size = 14)

# print per contig density; change lab for EDTA or EarlGrey
ggplot(data, aes(x = count)) +
  geom_density(fill = "tomato", alpha = 0.4) +
  facet_wrap(~ chrom, scales = "free_y") +
  labs(x = "Number of EDTA annotations per 50 kb bin",
       y = "Density") +
  theme_minimal(base_size = 12)
