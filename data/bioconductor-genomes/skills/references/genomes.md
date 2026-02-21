Genome and assembly reports

Chris Stubben

October 30, 2025

The genomes package reads genome or assembly reports from the NCBI genomes FTP.
The main function reports lists files in the GENOME_REPORTS directory (or ASSEM-
BLY_REPORTS if assembly=TRUE) and uses the readr package to download the tables.
Additonal functions to download genome features and sequences in the genbank and ref-
seq directories will be added soon (currently FTP paths in the prokaryotes.txt files are still
missing).

R> reports()
R> proks <- reports("prokaryotes.txt")

1

