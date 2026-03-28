---
name: pilea
description: Pilea profiles bacterial growth dynamics from metagenomic short-read data by estimating Peak-to-Trough Ratios using sketching algorithms. Use when user asks to estimate bacterial replication rates, profile metagenomes, or index custom genomes for growth rate analysis.
homepage: https://github.com/xinehc/pilea
---

# pilea

## Overview

Pilea is a specialized bioinformatics tool designed to profile bacterial growth dynamics from metagenomic short-read data. It utilizes sketching algorithms to provide fast and memory-efficient estimates of the Peak-to-Trough Ratio (PTR), which serves as a proxy for bacterial replication rates. This tool is ideal for researchers who need to process large metagenomes against extensive reference sets (like the GTDB) or custom-assembled genomes while minimizing the computational overhead typically associated with traditional alignment-based methods.

## Installation and Setup

Install Pilea via Conda using the bioconda and conda-forge channels:

```bash
conda create -n pilea -c bioconda -c conda-forge pilea
conda activate pilea
```

## Core Workflows

### 1. Database Preparation

You can either download a pre-built database or create a custom index from your own Metagenome-Assembled Genomes (MAGs).

**Download GTDB Reference:**
Use the `fetch` command to retrieve the pre-built GTDB reference database from Zenodo.
```bash
pilea fetch
```

**Create Custom Index:**
Index your own MAGs (files must end in `.fa`, `.fna`, or `.fasta`).
```bash
# -a: Optional taxonomy mapping (e.g., GTDB-Tk summary)
# -o: Output database directory
pilea index mags/*.fna -a gtdbtk.bac120.summary.tsv -o custom_db
```

### 2. Profiling Metagenomes

The `profile` command processes short reads against the indexed database. It supports both FASTA and FASTQ formats.

**Standard Profiling:**
```bash
# -d: Path to the database directory
# -o: Output directory for results (output.tsv)
pilea profile samples/*.fastq.gz -d custom_db -o results/
```

**Single-End Reads:**
By default, Pilea attempts to identify paired-end patterns (e.g., `_R1`/`_R2`). Use the `--single` flag if your data is single-end.
```bash
pilea profile single_reads.fasta --single -d custom_db -o .
```

## Expert Tips and Best Practices

- **Batch Processing:** When dealing with multiple samples, pass them all in a single command (e.g., `*.fasta`). This prevents the overhead of reloading the database for every individual sample, which is critical when using large reference sets.
- **Taxonomy Mapping:** If providing a taxonomy file with `-a`, ensure it is a tab-separated file where the first column is the genome ID and the second is the taxonomy string. Pilea is designed to work specifically with bacterial genomes; exclude archaea or non-prokaryotes for optimal results.
- **Memory Management:** Pilea uses sketching to reduce memory usage, but peak memory can still be high during indexing of very large, redundant databases. Recent versions (v1.3.1+) include optimized decoders to mitigate this.
- **Output Interpretation:** The primary output is `output.tsv`. As of v1.3.8, the tool outputs PTR values as `log2(PTR)`.
- **Filtering:** Pilea uses Interquartile Range (IQR) filtering rather than IDR for quality control of the growth estimates.



## Subcommands

| Command | Description |
|---------|-------------|
| pilea | pilea: error: argument {index,fetch,profile,rebuild}: invalid choice: 'bacterial' (choose from index, fetch, profile, rebuild) |
| pilea | pilea: error: argument {index,fetch,profile,rebuild}: invalid choice: 'new' (choose from index, fetch, profile, rebuild) |
| pilea fetch | Fetch data from Pilea. |
| pilea profile | Profile genomes from fasta or fastq files. |
| pilea rebuild | Rebuilds a sketch database. |
| pilea_index | Index fasta files for Pilea. |

## Reference documentation

- [Pilea README](./references/github_com_xinehc_pilea_blob_master_README.md)
- [Pilea Changelog](./references/github_com_xinehc_pilea_blob_master_CHANGELOG.md)