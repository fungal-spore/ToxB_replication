'''
This script is for parsing blast outfmt 6 tables.
Compares query length to hit length, then counts hits that match over 90% of the query length.
Dumps to output.txt
'''

import pandas as pd
import re
import sys

#import blastfile
inputFile = pd.read_csv(sys.argv[1], sep="\t", header=None)

#set column names
inputFile.columns = ['qseqid','sseqid','pident','length','mismatch','gapopen','qstart','qend','sstart','send','evalue','bitscore']

#set query length
q_length = int(sys.argv[2])
#print(q_length)
#print(type(q_length))

#create ratio column by dividing the hit lenght by the full query
inputFile['ratio'] = (inputFile['length']/q_length)

#counts the rows (i.e. hits) with greater than 90% of query
rows = pd.DataFrame(inputFile.loc[inputFile['ratio'] > 0.9])
print(len(rows))

#print lines with ratio scores greater than 90% of the query length
with open("output.txt", "w") as f:
        print(inputFile.loc[inputFile['ratio'] > 0.9], file=f)
(base) [gourlier@biocluster blastout]$
