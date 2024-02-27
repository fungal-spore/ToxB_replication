#Creats circular alignments of contigs

#mamba activate sibelia
#make sure to install circos in this env as well
#need extract.py

#usage bash circ-align-contigs.sh genome1 contig1 genome2 contig2 block

#Set genomes and contigs
echo Genome1 is set to $1
echo Selected contig from genome1 is $2
echo Genome2 is set to $3
echo Selected contig from genome2 is $4
echo Syntenic Block length is $5

#shorten fasta headers
echo Crunching headers.
sed '/^>/s/^>\([^ ]*\) .*/>\1 /' $1 | sed 's/\s//g' > genome1.shorthead
sed '/^>/s/^>\([^ ]*\) .*/>\1 /' $3 | sed 's/\s//g' > genome2.shorthead

#Pull contigs
echo Pulling contigs.
echo $2 > hitlist.txt
python extract.py genome1.shorthead
mv all.fa $1.$2.nt

echo $4 > hitlist.txt
python extract.py genome2.shorthead
mv all.fa $3.$4.nt

rm genome1.shorthead
rm genome2.shorthead

#align with Sibelia
echo Creating alignment.
Sibelia -s fine $1.$2.nt $3.$4.nt -m $5 -o ./sibelia_output/

#circos
echo Visualzing alignment.
cd sibelia_output/circos
circos

echo Cleanup.
mv circos.png ../$1.$2.$3.$4.$5.png
mv circos.svg ../$1.$2.$3.$4.$5.svg
cd ..
mv $1.$2.$3.$4.$5.png ../
mv $1.$2.$3.$4.$5.svg ../
cd ..
mv $1.$2.$3.$4.$5.png ./images
mv $1.$2.$3.$4.$5.svg ./images
rm -r sibelia_output

echo 'Can change sibelia settings for smaller or larger syntenic blocks.'
echo 'Done.'
