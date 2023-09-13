import sys
from Bio import SeqIO

# Input multisequence FASTA file
input_filename = sys.argv[1]

# Load sequences from the input file
sequences = list(SeqIO.parse(input_filename, 'fasta'))

# Determine the orientation of the first sequence
first_seq_orientation = sequences[0].seq

# Reorient all other sequences to match the first sequence's orientation
for seq_record in sequences[1:]:
    if seq_record.seq != first_seq_orientation:
        seq_record.seq = seq_record.seq.reverse_complement()

# Output the FASTA file
output_filename =  sys.argv[1]+'.oriented'

# Write the reoriented sequences to the output file
with open(output_filename, 'w') as output_file:
    SeqIO.write(sequences, output_file, 'fasta')

print(f"Sequences have been reoriented and saved to {output_filename}.")
