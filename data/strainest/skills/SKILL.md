---
name: strainest
description: StrainEst resolves the strain-level composition and relative abundance of microbial communities by comparing metagenomic reads against a database of known SNV profiles. Use when user asks to estimate strain abundance, profile microbial micro-diversity, or build custom SNV profile databases for specific species.
homepage: https://github.com/compmetagen/strainest
metadata:
  docker_image: "quay.io/biocontainers/strainest:1.2.4--py35_0"
---

# strainest

## Overview
StrainEst is a bioinformatic tool designed to resolve the strain-level composition of microbial communities. It operates by comparing metagenomic reads against a database of known SNV profiles for a specific species. By applying a Lasso-based regression model, it determines which strains are present and at what proportions. This is particularly useful for tracking specific pathogen strains or studying the micro-diversity of the human microbiome.

## Core Workflow

### 1. Data Preparation
Before running StrainEst, you must align your metagenomic reads to a reference genome or a representative set of sequences for the species of interest.
- **Trimming**: Use tools like Sickle to quality-trim raw FASTQ reads.
- **Alignment**: Use Bowtie2 (with `--very-fast` or `--sensitive`) to align reads to the species reference.
- **Processing**: Convert the output to a sorted and indexed BAM file using `samtools`.

### 2. Abundance Estimation
The primary command for profiling is `strainest est`.

```bash
strainest est <snp_clust.dgrp> <reads.sorted.bam> <output_directory>
```

- **snp_clust.dgrp**: The SNV profile database (precomputed or custom-built).
- **reads.sorted.bam**: Your aligned metagenomic data.
- **output_directory**: Where results will be stored.

### 3. Interpreting Results
The output directory contains several key files:
- `abund.txt`: The final relative abundance for each reference strain.
- `max_ident.txt`: The percentage of alleles from each reference genome detected in the sample.
- `info.txt`: Summary statistics, including the Pearson correlation coefficient (R) of the prediction.
- `counts.txt`: Raw SNV position and base pair counts.
- `mse.pdf`: Cross-validation plot for the Lasso shrinkage coefficient.

## Building Custom Databases
If a precomputed database is not available, you can build one using the following components:
- **Assembly List**: A table of sequences used for the database.
- **Map Alignment**: A FASTA file containing reference sequences for read alignment.
- **SNV Matrix**: The `snv.txt` file required for the estimation command.

## Expert Tips
- **Reference Selection**: Ensure the reference database (`.dgrp` or `snv.txt`) matches the species you aligned your reads against.
- **Pearson R**: Check `info.txt` for the Pearson R value. A low R-value may indicate that the strains in your sample are not well-represented by the reference database.
- **Docker Usage**: For environment consistency, run via Docker:
  `docker run --rm -v $(pwd):/data -w /data compmetagen/strainest strainest est ...`



## Subcommands

| Command | Description |
|---------|-------------|
| strainest est | Estimate relative abundance of strains. The BAM file must be sorted and indexed. |
| strainest map2snp | Build the SNP matrix in DGRP format. |
| strainest mapgenomes | Map genomes to a reference. |
| strainest mapstats | Compute basic statistics on the mapped genomes file. |
| strainest snpclust | Given a SNP matrix (in DGRP format) and a distance matrix, snpdist clusters the profiles returning a SNP matrix containing the representative profiles (SNPOUT) and a cluster file (CLUST). |
| strainest snpdist | Compute the Hamming distances between sequences in SNP matrix (in DGRP format). Moreover, it returns the distances histogram in HIST. |

## Reference documentation
- [StrainEst GitHub Repository](./references/github_com_compmetagen_strainest_blob_master_README.rst.md)
- [StrainEst Setup and Requirements](./references/github_com_compmetagen_strainest_blob_master_setup.py.md)