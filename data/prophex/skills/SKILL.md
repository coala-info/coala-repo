---
name: prophex
description: ProPhex is a specialized tool designed for efficient k-mer indexing with a minimal memory footprint.
homepage: https://github.com/prophyle/prophex
---

# prophex

## Overview
ProPhex is a specialized tool designed for efficient k-mer indexing with a minimal memory footprint. It leverages the BWA implementation of the BWT-index to allow for rapid querying of genomic sequences. You should use this skill to construct indices from FASTA files and query sequencing reads (FASTQ) against those indices. It supports k-LCP (longest common prefix) arrays to accelerate queries and provides output in an extended Kraken format, making it compatible with downstream metagenomic analysis pipelines.

## Installation
ProPhex can be installed via Bioconda:
```bash
conda install -c bioconda prophex
```

## Core Workflows

### 1. Index Construction
To query k-mers, you must first build a BWT-based index of your reference sequences.

```bash
# Basic index construction
prophex index -k <kmer_length> <reference.fa>

# Parallel construction of k-LCP and Suffix Array (SA) for speed
prophex index -k 25 -s <reference.fa>
```
*   **Tip**: The `-k` parameter is essential if you plan to use k-LCP for faster querying later.

### 2. Querying Reads
Once the index is built, you can search for k-mer matches from sequencing data.

```bash
# Query with k-LCP acceleration (requires index built with -k)
prophex query -k 25 -u -t 4 <index_prefix> <reads.fq>

# Standard query without k-LCP
prophex query -k 20 <index_prefix> <reads.fq>
```
*   **-u**: Enables k-LCP for significant speedups.
*   **-t**: Specifies the number of threads.
*   **-v**: Outputs the set of chromosomes for every k-mer (useful for detailed assignment).

### 3. Index Maintenance and Conversion
*   **Construct k-LCP separately**: If you have an existing BWA index, you can add k-LCP support:
    ```bash
    prophex klcp -k 25 <idxbase>
    ```
*   **Reconstruct FASTA**: To verify index contents or recover sequences from a BWT:
    ```bash
    prophex bwt2fa <idxbase> <output.fa>
    ```
*   **Downgrade BWT**: To save space by removing Occ values (uses the older, more compact format):
    ```bash
    prophex bwtdowngrade <input.bwt> <output.bwt>
    ```

## Output Format
ProPhex produces a tab-delimited file (Extended Kraken format):
1.  **Category**: Legacy value (usually 'U').
2.  **Sequence Name**: ID from the input FASTQ.
3.  **Final Decision**: Legacy value (usually '0').
4.  **Sequence Length**: Length of the query read.
5.  **Assigned k-mers**: Space-delimited blocks (e.g., `node_id:count`). `0:N` indicates N unassigned k-mers.

## Expert Tips
*   **Memory Optimization**: If the index is too large, consider removing duplicate k-mers using a pre-processor like `ProphAsm` or `BCalm` before indexing.
*   **Border Check**: By default, ProPhex checks if a k-mer spans the border of two contigs. Use `-p` in the `query` command to disable this check if your reference consists of long, continuous sequences where border k-mers are negligible.
*   **Log Statistics**: Use `-l <logfile>` during queries to capture performance metrics and match statistics for pipeline optimization.

## Reference documentation
- [ProPhex GitHub Repository](./references/github_com_prophyle_prophex.md)
- [Bioconda ProPhex Package](./references/anaconda_org_channels_bioconda_packages_prophex_overview.md)