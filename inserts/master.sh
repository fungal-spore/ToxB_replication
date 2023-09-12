#usage: bash master.sh blastout insert-length genome

#parse blast output
python parse-insert-hits.py $1 $2

#fiter parsed
python parse-out.py

#extract outs
bedtools getfasta -fi $3 -bed out.bed -fo $2.$3.asmb

rm output.tsv out.bed
