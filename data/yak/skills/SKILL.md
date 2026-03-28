---
name: yak
description: Yak evaluates genomic assembly quality and base-level accuracy by comparing sequences against k-mer spectra from high-quality short reads. Use when user asks to estimate assembly quality values, calculate k-mer completeness, build k-mer hash tables, or partition sex chromosomes.
homepage: https://github.com/lh3/yak
---

# yak

## Overview
Yak is a specialized bioinformatics tool designed to evaluate the quality of genomic assemblies and long reads (specifically PacBio CCS/HiFi) by comparing them against the k-mer spectrum of high-quality short reads. It provides a robust, reference-free method for estimating base-level accuracy (Quality Value or QV) and completeness. It is particularly effective at high accuracy levels (up to Q50) where naive estimators often fail due to sampling bias or short-read errors.

## Core Workflows and CLI Patterns

### 1. Building K-mer Hash Tables
Before analysis, you must count k-mers in your input data to create `.yak` files.

*   **For Assemblies:** Count all k-mers, including singletons.
    ```bash
    ./yak count -K1.5g -t32 -o asm.yak asm.fa.gz
    ```
*   **For High-Coverage Reads:** Discard singletons to reduce noise and memory usage.
    ```bash
    ./yak count -b37 -t32 -o ccs.yak ccs-reads.fq.gz
    ```
*   **For Paired-End Short Reads:** Provide both files to create a combined spectrum.
    ```bash
    ./yak count -b37 -t32 -o sr.yak <(zcat sr_1.fq.gz) <(zcat sr_2.fq.gz)
    ```

### 2. Quality Value (QV) Estimation
Estimate the base accuracy of an assembly or long reads by comparing them to a short-read k-mer hash table.

*   **Assembly QV:**
    ```bash
    ./yak qv -t32 -p -K3.2g -l100k sr.yak asm.fa.gz > asm-sr.qv.txt
    ```
*   **CCS Read QV:**
    ```bash
    ./yak qv -t32 -p sr.yak ccs-reads.fq.gz > ccs-sr.qv.txt
    ```

### 3. Inspection and Completeness
Evaluate how well the assembly represents the k-mers found in the raw reads.

*   **K-mer QV for Reads:**
    ```bash
    ./yak inspect ccs.yak sr.yak > ccs-sr.kqv.txt
    ```
*   **Assembly Completeness:**
    ```bash
    ./yak inspect sr.yak asm.yak > sr-asm.kqv.txt
    ```
*   **K-mer Histogram:** Generate a frequency distribution of k-mers.
    ```bash
    ./yak inspect sr.yak > sr.hist
    ```

### 4. Sex Chromosome Partitioning
For human de novo assemblies, yak can help separate X and Y contigs using specialized k-mer databases.

```bash
# Partition contigs based on k-mer counts
./yak sexchr -K2g -t16 chrY-no-par.yak chrX-no-par.yak par.yak hap1.fa hap2.fa > cnt.txt

# Use the provided helper script to group and extract sequences
./groupxy.pl cnt.txt | awk '$4==1' | cut -f2 | seqtk subseq -l80 <(cat hap1.fa hap2.fa) - > new-hap1.fa
```

## Best Practices
*   **Memory Management:** Use the `-K` flag to pre-allocate hash table memory (e.g., `-K1.5g`). This prevents frequent re-allocations during the counting phase.
*   **Threading:** Yak is highly multi-threaded. Always utilize the `-t` flag to match your available CPU cores for significant speedups in `count` and `qv` operations.
*   **Singleton Handling:** When working with high-coverage short reads (e.g., Illumina), use `-b` (typically `-b37`) to ignore k-mers that appear only once, as these are likely sequencing errors. For assemblies, keep singletons to ensure every part of the sequence is evaluated.



## Subcommands

| Command | Description |
|---------|-------------|
| yak count | Count k-mers in FASTA files |
| yak inspect | Evaluates k-mer QV and k-mer sensitivity. |
| yak qv | Calculate k-mer quality values (QV) for sequences. |
| yak triobin | Identify and extract triobins from yak files. |
| yak trioeval | Evaluate trios from yak files and a reference FASTA. |

## Reference documentation
- [Yak GitHub Repository Overview](./references/github_com_lh3_yak.md)
- [Yak README and Getting Started](./references/github_com_lh3_yak_blob_master_README.md)