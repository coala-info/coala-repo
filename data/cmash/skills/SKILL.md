---
name: cmash
description: CMash uses containment min hashing to estimate the presence and proportion of reference genomes within large genomic or metagenomic query samples. Use when user asks to build a reference database, query a metagenome for taxonomic profiling, perform multi-resolution k-mer analysis, or calculate containment and Jaccard indices.
homepage: https://github.com/dkoslicki/CMash
metadata:
  docker_image: "quay.io/biocontainers/cmash:0.5.2--pyh5e36f6f_0"
---

# cmash

## Overview
CMash is a probabilistic data analysis tool designed for large-scale genomic comparisons. It utilizes containment min hashing to provide multi-resolution estimations of how much of a reference genome is contained within a query sample (like a metagenome). This is particularly useful for taxonomic profiling, identifying organisms in complex environmental samples, and performing rapid pairwise comparisons of thousands of genomes. While the project notes it has been largely supplanted by Sourmash and YACHT, it remains a specialized tool for workflows requiring specific k-mer size flexibility and containment index visualizations.

## Core Workflows

### 1. Building a Reference Database
To query against a set of genomes, you must first create a training database.
1. Create a text file (e.g., `FileNames.txt`) containing the absolute paths to your reference FASTA/Q files.
2. Run the database construction script:
   ```bash
   MakeDNADatabase.py FileNames.txt TrainingDatabase.h5
   ```
*Tip: Use `MakeStreamingDNADatabase.py` if you want to support multiple k-mer sizes simultaneously for multi-resolution analysis.*

### 2. Querying a Metagenome
To estimate which references are present in a query sample:
```bash
QueryDNADatabase.py Metagenome.fa TrainingDatabase.h5 Output.csv
```
The resulting CSV contains:
- **Containment Index Estimate**: The proportion of the reference found in the query.
- **Intersection Cardinality**: The estimated number of shared k-mers.
- **Jaccard Index Estimate**: The overall similarity between the two sets.

### 3. Using Bloom Filters (Optional)
For very large query files, you can pre-process the metagenome into a bloom filter (nodegraph) to speed up subsequent queries:
```bash
MakeNodeGraph.py Metagenome.fa .
```

### 4. Streaming Analysis
For workflows where disk space is a concern or when analyzing containment across a range of k-mer sizes:
```bash
StreamingQueryDNADatabase.py Metagenome.fa TrainingDatabase.h5 Output.csv
```
This approach avoids the creation of intermediate bloom filter files and is ideal for generating "containment vs. k" plots.

## Expert Tips and Best Practices
- **Database Management**: Use the `MinHash` Python module (`from CMash import MinHash as MH`) for advanced operations like `MH.insert_to_database`, `MH.delete_from_database`, or `MH.union_databases` to avoid rebuilding large databases from scratch.
- **Identifying Redundancy**: Use `MH.form_jaccard_matrix` to create a pairwise similarity matrix of your reference database. This helps identify nearly identical genomes that might skew your metagenomic results.
- **Memory Issues**: If installing on Linux and encountering `cairo` errors, ensure `libcairo2-dev` is installed via the system package manager.
- **Multi-resolution**: When using the streaming scripts, you can visualize the containment index as a function of $k$. A stable containment index across various $k$ values typically indicates a more confident match.



## Subcommands

| Command | Description |
|---------|-------------|
| MakeDNADatabase.py | This script creates training/reference sketches for each FASTA/Q file listed in the input file. |
| MakeStreamingDNADatabase.py | This script creates training/reference sketches for each FASTA/Q file listed in the input file. |
| QueryDNADatabase.py | This script creates a CSV file of similarity indicies between the input file and each of the sketches in the training/reference file. |
| StreamingQueryDNADatabase.py | This script calculates containment indicies for each of the training/reference sketches by streaming through the query file. |

## Reference documentation
- [CMash GitHub README](./references/github_com_dkoslicki_CMash_blob_master_README.md)
- [CMash Setup and Requirements](./references/github_com_dkoslicki_CMash_blob_master_setup.py.md)