---
name: pilea
description: Pilea profiles bacterial growth dynamics from metagenomic datasets by using sketching algorithms to estimate peak-to-trough ratios. Use when user asks to profile metagenomes, estimate bacterial growth rates, index custom genomes, or fetch reference databases.
homepage: https://github.com/xinehc/pilea
---


# pilea

## Overview
Pilea is a high-performance bioinformatics tool that leverages sketching algorithms to profile bacterial growth dynamics from metagenomic datasets. Unlike traditional alignment-heavy methods, Pilea uses sketching to significantly speed up the estimation of Peak-to-Trough Ratios (PTR), which serve as a proxy for instantaneous growth rates. The workflow typically involves preparing a reference database (either from custom MAGs or GTDB) and then profiling metagenomic reads against that database.

## Installation
Install Pilea via Bioconda for the most stable environment:
```bash
conda create -n pilea -c bioconda -c conda-forge pilea
conda activate pilea
```

## Core Workflows

### 1. Database Preparation
You can either download a pre-built database or index your own Metagenome-Assembled Genomes (MAGs).

**Fetching GTDB:**
If you do not have specific MAGs, download the pre-built GTDB database:
```bash
pilea fetch
```

**Indexing Custom MAGs:**
To use your own genomes, provide the directory containing FASTA files.
```bash
pilea index path/to/mags/*.fna -o my_database
```
*   **Expert Tip:** If you have taxonomy information (e.g., from GTDB-Tk), provide it using `-a/--taxonomy`. This file should be a tab-separated file where the first column is the genome name and the second is the taxonomy.

### 2. Profiling Metagenomes
The `profile` command estimates PTR and metadata for genomes that pass quality filters.

**Standard Profiling:**
```bash
pilea profile samples/*.fasta -d my_database -o output_dir
```

**Single-end Reads:**
By default, Pilea looks for paired-end patterns (`_1`, `_R1`, etc.). For single-end data, use the flag:
```bash
pilea profile sample.fastq -d my_database -o . --single
```

## Best Practices and Expert Tips
*   **Batch Processing:** When processing multiple samples, pass them all in a single command (e.g., `*.fasta`). This prevents Pilea from reloading the database into memory for every individual file, which is a significant time-saver for large reference sets.
*   **File Extensions:** Ensure your MAGs use standard extensions: `.fa`, `.fna`, or `.fasta`.
*   **Taxonomy Filtering:** When providing a taxonomy mapping file, ensure it contains only bacteria. Pilea is optimized for bacterial growth dynamics; archaea or non-prokaryotes should be filtered out of the mapping file to avoid noise.
*   **Memory Management:** Sketching is memory-efficient, but the initial indexing of a very large number of MAGs can be resource-intensive. Ensure your environment has sufficient RAM for the `index` step if working with thousands of genomes.

## Reference documentation
- [Pilea Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_pilea_overview.md)
- [Pilea GitHub Repository](./references/github_com_xinehc_pilea.md)