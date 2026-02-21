---
name: cmash
description: CMash is a bioinformatics tool designed for efficient genomic set similarity estimation using containment MinHash.
homepage: https://github.com/dkoslicki/CMash
---

# cmash

## Overview
CMash is a bioinformatics tool designed for efficient genomic set similarity estimation using containment MinHash. It allows researchers to determine the presence and abundance of reference sequences within large query datasets, such as metagenomes. By reducing sequences to probabilistic sketches, it enables rapid calculation of Jaccard and containment indices. While the developers note that the tool has largely been supplanted by Sourmash and YACHT, CMash remains a functional option for multi-resolution k-mer analysis and specific containment estimation workflows.

## Installation
The recommended installation method is via Bioconda:
```bash
conda install bioconda::cmash
```

## Core Workflow

### 1. Prepare Reference List
Create a text file (e.g., `FileNames.txt`) containing the absolute paths to your reference FASTA or FASTQ files, one per line.
```text
/path/to/ref1.fa
/path/to/ref2.fa
/path/to/ref3.fa
```

### 2. Build the Reference Database
Generate a training database in HDF5 format from your list of references.
```bash
MakeDNADatabase.py FileNames.txt TrainingDatabase.h5
```

### 3. Query the Database
Compare a query file (metagenome) against the training database to estimate containment.
```bash
QueryDNADatabase.py Metagenome.fa TrainingDatabase.h5 Output.csv
```
The output CSV contains:
- Containment index estimate
- Intersection cardinality
- Jaccard index estimate

## Streaming and Multi-K-mer Analysis
For workflows requiring multiple k-mer sizes simultaneously or to avoid the memory overhead of bloom filters, use the streaming scripts.

### Create Streaming Database
```bash
MakeStreamingDNADatabase.py FileNames.txt TrainingDatabase.h5
```

### Query Streaming Database
```bash
StreamingQueryDNADatabase.py Metagenome.fa TrainingDatabase.h5 Output.csv
```

## Expert Tips and Best Practices
- **Absolute Paths**: Always use absolute paths in your `FileNames.txt` to avoid issues when running scripts from different directories.
- **Streaming Preference**: Use the `Streaming` versions of the scripts if you need to visualize containment as a function of $k$ or if you are working with limited memory, as they do not require pre-forming bloom filters.
- **Database Management**: The Python API (`from CMash import MinHash as MH`) provides advanced functions like `MH.insert_to_database` and `MH.union_databases` for updating existing HDF5 databases without rebuilding them from scratch.
- **Redundancy Check**: Use `MH.form_jaccard_matrix` within a Python script to identify structural redundancies in your training database before running large-scale queries.
- **Deprecation Note**: Be aware that CMash is in a maintenance state. For new projects requiring long-term support or integration with the latest k-mer tools, consider transitioning to Sourmash.

## Reference documentation
- [CMash GitHub Repository](./references/github_com_dkoslicki_CMash.md)
- [Bioconda CMash Overview](./references/anaconda_org_channels_bioconda_packages_cmash_overview.md)