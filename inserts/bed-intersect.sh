# compares output from 90-over-90 parsed blastoutput with earlGrey transposon annotations 
# -a is bedfile 1 and -b is bedfile 2
# -wb option prints full info on file 2, can use -wa if you want full infor on file 1
bedtools intersect -wb -a $1 -b $2
