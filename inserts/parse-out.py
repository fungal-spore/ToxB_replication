import pandas as pd

df = pd.read_csv("output.tsv", sep="\t")

# Function to compare values and print results
def print_lower_of_sstart_higher_of_send(row):
    sseqid = row['sseqid']
    lower_of_sstart = min(row['sstart'], row['send'])
    higher_of_send = max(row['sstart'], row['send'])
    with open('out.bed', 'a') as file:
        file.write(f"{sseqid}\t{lower_of_sstart}\t{higher_of_send}\n")

# Apply the function to each row
df.apply(print_lower_of_sstart_higher_of_send, axis=1)
