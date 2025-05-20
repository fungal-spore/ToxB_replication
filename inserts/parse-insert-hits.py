'''
This script is for parsing blast outfmt 6 tables.
Compares query length to hit length, then counts hits that match over 90% of the query length.
Dumps to output.txt
'''
#usage: python parse-insert-hits.py *.blastout query-length

#pip install pandas
import pandas as pd
import sys

#import blastfile
inputFile = pd.read_csv(sys.argv[1], sep="\t", header=None)

#set column names
inputFile.columns = ['qseqid','sseqid','pident','length','mismatch','gapopen','qstart','qend','sstart','send','evalue','bitscore']

#set query length
q_length = int(sys.argv[2])

#create ratio column by dividing the hit length by the full query
inputFile['ratio'] = (inputFile['length']/q_length)

#print the number of rows (i.e. hits) with greater than 90% of the query
rows = pd.DataFrame(inputFile.loc[inputFile['ratio'] > 0.9])

#print to file
rows.to_csv('output.tsv', sep='\t', index=False)

#print(rows)
print(sys.argv[1], 'Total:', len(rows))

with open("out.count", "w") as file:
    print(sys.argv[1]+ "\t" + str(len(rows)), file=file)

