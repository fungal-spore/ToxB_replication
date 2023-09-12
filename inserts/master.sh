#usage: bash master.sh blastout insert-length genome

#parse blast output
python parse-insert-hits.py $1 $2

#fiter parsed
python parse-out.py
cat out.count >> insert_counts.tsv

#extract outs
bedtools getfasta -fi $3 -bed out.bed -fo $2.$3.asmb

#For testing, checks if the number of hits from the parse file matches number of extracted sequences
#grep -c '>' $2.$3.asmb >> insert_counts.tsv

rm output.tsv out.bed out.count
