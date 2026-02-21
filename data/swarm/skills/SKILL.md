---
name: swarm
description: Swarm is a specialized tool designed for the clustering of massive sets of amplicons, typically used in environmental DNA and microbiome studies.
homepage: https://github.com/torognes/swarm
---

# swarm

## Overview

Swarm is a specialized tool designed for the clustering of massive sets of amplicons, typically used in environmental DNA and microbiome studies. Unlike traditional algorithms that rely on a global clustering threshold (e.g., 97% similarity), Swarm uses a local linking threshold ($d$) and an iterative growth process. It leverages sequence abundance values to distinguish between true biological sequences and experimental noise (like PCR or sequencing errors), resulting in stable and high-resolution clusters.

## Installation and Setup

Swarm is available via Bioconda or can be compiled from source.

```bash
# Install via conda
conda install -c bioconda swarm

# Compile from source
git clone https://github.com/torognes/swarm.git
cd swarm/
make
```

## Mandatory Input Formatting

Swarm requires input FASTA files to be **strictly dereplicated** and sorted by decreasing abundance. Each sequence header must contain an abundance value.

### Header Format
The default format is `>label_abundance`.
Example:
```fasta
>seq1_1000
ACGT...
>seq2_25
ACGT...
```

### Dereplication Workflow
Before running Swarm, use a tool like `vsearch` to prepare your data:
```bash
vsearch --derep_fulllength input.fasta \
        --sizeout \
        --relabel_sha1 \
        --fasta_width 0 \
        --output dereplicated.fasta
```

## Common CLI Patterns

### Basic Clustering
The default threshold is $d=1$, which is recommended for most datasets.
```bash
swarm -o clusters.txt dereplicated.fasta
```

### High-Resolution Clustering (Recommended)
For the highest quality results at $d=1$, use the "fastidious" option to reduce the number of small, spurious clusters.
```bash
swarm -d 1 -f -z -w representatives.fasta -o clusters.txt dereplicated.fasta
```

### Key Parameters
- `-d <int>`: Maximum number of differences allowed between two sequences to be linked (default: 1).
- `-f, --fastidious`: (Only for $d=1$) Performs a second pass to link low-abundance clusters to larger ones.
- `-z`: Use this if your abundance values are formatted as `size=N` (standard in VSEARCH/USEARCH) instead of `_N`.
- `-w <file>`: Output the representative sequence of each cluster in FASTA format.
- `-o <file>`: Output the cluster definitions (one cluster per line).
- `-t <int>`: Number of threads to use.

## Expert Tips and Best Practices

- **Threshold Selection**: Do not attempt to convert a 97% global similarity threshold into a $d$ value. Tests show that $d=1$ or $d=2$ provides the best biological resolution for most markers. Values higher than $d=3$ are rarely justified.
- **Memory Management**: Swarm's memory footprint is roughly 0.6x the size of the input FASTA. However, `--fastidious` mode increases memory usage significantly. Use `-c` to cap the Bloom filter size if you encounter memory limits on extremely large datasets.
- **Abundance is Critical**: Swarm's algorithm relies on the "abundance peak" logic. If your sequences do not have accurate abundance counts, the clustering logic will fail to distinguish between biological variation and errors.
- **Output Sorting**: When using `-w`, Swarm 3.0+ outputs results sorted by decreasing abundance, which is ideal for downstream taxonomic assignment.

## Reference documentation

- [Swarm GitHub README](./references/github_com_torognes_swarm.md)
- [Swarm Wiki and FAQ](./references/github_com_torognes_swarm_wiki.md)
- [Bioconda Swarm Package](./references/anaconda_org_channels_bioconda_packages_swarm_overview.md)