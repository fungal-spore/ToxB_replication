#Circular alignments of contig sections

#mamba activate sibelia
#make sure to install circos and bedtools in this env as well
#need extract.py

echo usage: bash circ-align-contig-part.sh genome1 contig1 start end genome2 contig2 start end block

#Set genomes and contigs
echo Genome1 is set to $1
echo Selected contig from genome1 is $2
echo Start on $2 is position $3
echo End on $2 is position $4
echo $2$'\t'$3$'\t'$4 > bed1

echo Genome2 is set to $5
echo Selected contig from genome2 is $6
echo Start on $6 is position $7
echo End on $6 is position $8
echo $6$'\t'$7$'\t'$8 > bed2

echo Syntenic Block length is $9

#shorten fasta headers
echo Crunching headers.
sed '/^>/s/^>\([^ ]*\) .*/>\1 /' $1 | sed 's/\s//g' > genome1.shorthead
sed '/^>/s/^>\([^ ]*\) .*/>\1 /' $5 | sed 's/\s//g' > genome2.shorthead

#Pull contigs
echo Pulling contigs.
echo $2 > hitlist.txt
python extract.py genome1.shorthead
mv all.fa $1.$2.nt

echo $6 > hitlist.txt
python extract.py genome2.shorthead
mv all.fa $5.$6.nt

#Cut contig parts
echo Cutting contig sections.
bedtools getfasta -fi $1.$2.nt -bed bed1 -fo $1.$2.part.nt
bedtools getfasta -fi $5.$6.nt -bed bed2 -fo $5.$6.part.nt

#align with Sibelia
echo Creating alignment.
Sibelia -s fine $1.$2.part.nt $5.$6.part.nt -m $9 -o ./sibelia_output/

#circos
echo Visualzing alignment.
cd sibelia_output/circos
circos

echo Cleanup.
mv circos.png ../$1.$2.part.$5.$6.part.$9.png
mv circos.svg ../$1.$2.part.$5.$6.part.$9.svg
cd ..
mv $1.$2.part.$5.$6.part.$9.png ../
mv $1.$2.part.$5.$6.part.$9.svg ../
cd ..
mv $1.$2.part.$5.$6.part.$9.png ./images
mv $1.$2.part.$5.$6.part.$9.svg ./images
#rm -r sibelia_output

mv $1.$2.nt ./contigs/
mv $5.$6.nt ./contigs/

rm genome1.shorthead genome2.shorthead bed1 bed2 *.fai *.part.nt

echo 'Done.'
