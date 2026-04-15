---
name: stringmlst
description: stringMLST is a k-mer based tool designed to predict the sequence type of bacterial isolates directly from raw sequencing reads without the need for assembly. Use when user asks to download MLST databases, build k-mer databases for specific species, or predict sequence types from FASTQ files.
homepage: https://github.com/jordanlab/stringMLST
metadata:
  docker_image: "quay.io/biocontainers/stringmlst:0.6.3--py_0"
---

# stringmlst

## Overview
stringMLST is a lightweight, k-mer based tool designed to predict the sequence type (ST) of a bacterial isolate directly from genome sequencing reads. Unlike traditional MLST methods that require time-consuming de novo assembly or compute-intensive read alignment, stringMLST utilizes an assembly-free approach. It works by matching k-mers from raw FASTQ files against a database of known alleles, making it exceptionally fast and suitable for high-throughput genomic surveillance.

## Installation
The tool can be installed via Bioconda or pip:
```bash
conda install bioconda::stringmlst
# OR
pip install stringMLST
```

## Core Workflows

### 1. Database Preparation
You must have a species-specific database before predicting STs.

**Automated Retrieval (Recommended):**
Download and build databases directly from pubMLST.
```bash
# Download specific species (e.g., Neisseria)
stringMLST.py --getMLST -P neisseria_db --species neisseria

# Download all available species
stringMLST.py --getMLST -P all_dbs --species all
```

**Manual Database Building:**
If you have local allele sequences and a profile file, use a config file.
```bash
# 1. Create a config.txt with [loci] and [profile] sections
# 2. Build the database
stringMLST.py --buildDB -c config.txt -k 35 -P output_prefix
```

### 2. Sequence Type Prediction
Once the database is built, you can run predictions in three modes.

**Single Sample Mode:**
```bash
stringMLST.py --predict -1 sample_R1.fastq -2 sample_R2.fastq -k 35 -P db_prefix
```

**Batch Mode (Directory):**
Processes all FASTQ files in a specified directory.
```bash
stringMLST.py --predict -d ./path/to/fastqs/ -k 35 -P db_prefix
```

**List Mode:**
Processes samples defined in a text file (tab-delimited for paired-end).
```bash
stringMLST.py --predict -l list_paired.txt -k 35 -P db_prefix
```

## Expert Tips and Best Practices

- **K-mer Size Selection**: A k-mer size of 35 (`-k 35`) is the standard recommendation for most bacterial MLST schemes. Larger k-mers increase specificity but may reduce sensitivity if sequencing quality is low.
- **Compressed Files**: stringMLST natively handles gzipped FASTQ files. Use the `-p` flag if you encounter issues with specific Python versions when handling `.gz` files.
- **Database Currency**: stringMLST is a tool, not a static database. Always use the `--getMLST` command regularly to ensure your local k-mer databases reflect the most recent allele and profile definitions from pubMLST.
- **Output Interpretation**: The output provides the allele designations for each locus in the scheme followed by the predicted ST. If an allele cannot be confidently identified, it may return 'NA'.
- **Advanced Coverage Analysis**: For tasks requiring genome coverage calculations, ensure `pyfaidx`, `bwa`, `samtools`, and `bedtools` are installed in your environment, as these are external dependencies for advanced routines.

## Reference documentation
- [stringMLST GitHub Repository](./references/github_com_jordanlab_stringMLST.md)
- [Bioconda stringMLST Package Overview](./references/anaconda_org_channels_bioconda_packages_stringmlst_overview.md)