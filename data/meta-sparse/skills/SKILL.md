---
name: meta-sparse
description: The `meta-sparse` tool (Strain Prediction and Analysis using Representative SEquences) is designed to identify the taxonomic origins of metagenomic reads with high precision.
homepage: https://github.com/zheminzhou/SPARSE/
---

# meta-sparse

## Overview

The `meta-sparse` tool (Strain Prediction and Analysis using Representative SEquences) is designed to identify the taxonomic origins of metagenomic reads with high precision. It utilizes a hierarchical indexing system covering over 100,000 reference genomes, allowing it to distinguish between closely related microbial strains. 

Use this skill when you need to:
1. Predict which reference genomes or subpopulations are present in a metagenomic sample.
2. Generate taxonomic profiles from raw FASTQ data.
3. Extract specific reads that map to particular reference organisms for downstream analysis.

## Installation and Environment

`meta-sparse` primarily runs on Unix-based systems and historically requires **Python 2.7**. It is recommended to use a dedicated Conda environment to manage its specific dependencies (samtools, mash, bowtie2).

```bash
conda install bioconda::meta-sparse
```

## Core Workflow

### 1. Database Preparation
The tool requires a pre-compiled database. The standard RefSeq-based database is large (~350GB).

```bash
# Download and unpack the database
curl -o refseq_db.tar.gz http://enterobase.warwick.ac.uk/sparse/refseq_20180519.tar.gz
tar -vxzf refseq_db.tar.gz
```

### 2. Predicting Read Origins
The `predict` command performs the mapping and evaluation. You must specify the mapping databases (e.g., representative, subpopulation, Virus, Eukaryota).

**Paired-end reads:**
```bash
sparse predict --dbname refseq_20180519 --mapDB representative,subpopulation --r1 reads_R1.fq.gz --r2 reads_R2.fq.gz --workspace my_analysis
```

**Single-end reads:**
```bash
sparse predict --dbname refseq_20180519 --mapDB representative --r1 reads.fq.gz --workspace my_analysis
```

### 3. Generating Reports
Once the prediction is complete, generate a human-readable profile report.

```bash
sparse report my_analysis
```
*Output:* The report is saved as `my_analysis/profile.txt`.

### 4. Extracting Specific Reads
To isolate reads belonging to a specific reference identified in the report, use the `extract` command with the corresponding reference IDs.

```bash
sparse extract --dbname refseq_20180519 --workspace my_analysis --ref_id 101,205
```

## Expert Tips and Best Practices

- **Workspace Management**: Always use a unique directory name for `--workspace`. The tool stores intermediate mapping files and final results there; reusing a workspace without clearing it may cause conflicts.
- **Database Selection**: The `--mapDB` flag accepts a comma-delimited list. For general bacterial screening, use `representative`. For finer resolution, include `subpopulation`.
- **Memory and Storage**: Ensure at least 400GB of free disk space if using the full RefSeq database, as the unpacked index and intermediate workspace files are substantial.
- **Legacy Support**: If encountering syntax errors during execution, verify that the active environment is using Python 2.7, as Python 3 support was not native in the primary release versions.

## Reference documentation
- [SPARSE GitHub Repository](./references/github_com_zheminzhou_SPARSE.md)
- [Bioconda meta-sparse Overview](./references/anaconda_org_channels_bioconda_packages_meta-sparse_overview.md)