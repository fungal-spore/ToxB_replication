# Run python script to parse 90% identity over 90% query; $1 is blastoutput $2 is sequence length (i.e sequnce junction is 251)
python parse-hits_90-over-90.py $1 $2

## Parsing 90-over-90.py output
  # removes header and renames file
tail -n +2 output.tsv > output
mv output $1.90-over-90.tsv
rm output.tsv

  # pulls tig name and coordinates, then makes sure the 2nd column always has the lowest number
awk '{print $2,$9,$10}' $1.90-over-90.tsv > $1.bedtemp
awk -v OFS='\t' '{ if ($2 < $3) print $1,$2,$3; else print $1,$3,$2}' $1.bedtemp > $1.bed

