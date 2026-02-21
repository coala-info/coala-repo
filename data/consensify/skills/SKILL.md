---
name: consensify
description: Consensify is a tool designed to produce high-quality pseudohaploid sequences by mitigating the impact of sequencing errors and post-mortem DNA damage.
homepage: https://github.com/jlapaijmans/Consensify
---

# consensify

## Overview

Consensify is a tool designed to produce high-quality pseudohaploid sequences by mitigating the impact of sequencing errors and post-mortem DNA damage. Unlike standard methods that sample a single random read at a position, Consensify samples a user-defined number of reads and only calls a base if a specific threshold of those reads match. This "consensus" approach significantly reduces the noise inherent in low-coverage or degraded genomic data.

## Installation and Setup

The tool is primarily distributed via bioconda.

```bash
# Install via conda
conda install -c bioconda consensify

# Verify installation
consensify_c -h
```

## Core Workflow

Consensify requires three specific input files, typically generated from BAM files using tools like `angsd`.

### 1. Input Preparation
The most common way to generate the required `.pos` and `.counts` files is using `angsd`:

```bash
angsd -doCounts 1 -dumpCounts 3 -i input.bam -out output_prefix
```
*   **Counts file (`.counts`):** Contains four columns representing the total counts of A, C, G, and T.
*   **Positions file (`.pos`):** Contains scaffold name, position, and read depth.
*   **Scaffold file (`.txt`):** A user-created tab-delimited file with the header `name start end`.

### 2. Running the Tool
The basic command structure for `consensify_c` is:

```bash
consensify_c -p data.pos.gz -c data.counts.gz -s scaffolds.txt -o consensus.fasta
```

### 3. Parameter Optimization
Adjust these flags based on your data quality and coverage:

*   `-min`: Minimum coverage required to attempt a call (default: 3).
*   `-max`: Maximum coverage allowed (default: 100). Positions exceeding this are masked as 'N'.
*   `-n_random_reads`: The number of reads to randomly sample from the stack (default: 3).
*   `-n_matches`: The number of sampled reads that must match to call the base (default: 2).

**Example for high-stringency calls:**
To require 3 out of 3 sampled reads to match:
```bash
consensify_c -p in.pos -c in.counts -s in.txt -o out.fasta -n_random_reads 3 -n_matches 3
```

## Expert Tips

*   **Generating Scaffold Lengths:** You can quickly generate the required `-s` file using a reference FASTA and `samtools`:
    ```bash
    samtools faidx reference.fasta
    awk 'BEGIN {print "name\tstart\tend"} {print $1 "\t1\t" $2}' reference.fasta.fai > scaffolds.txt
    ```
*   **Compressed Inputs:** Version 2.4.0+ supports reading `.gz` files directly for the `-p` and `-c` arguments, saving significant disk space.
*   **Handling Transitions:** When working with ancient DNA, it is often best practice to exclude transitions during the `angsd` preprocessing step to avoid C->T and G->A damage artifacts.
*   **Empty Scaffolds:** Use the `-no_empty_scaffold` flag if you want to keep the output FASTA clean of scaffolds that have no data in your counts file.

## Reference documentation
- [Consensify GitHub Repository](./references/github_com_jlapaijmans_Consensify.md)
- [Consensify Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_consensify_overview.md)