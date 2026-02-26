---
name: gsalign
description: GSAlign is a high-performance alignment tool designed for comparing and identifying differences between genomes of the same species. Use when user asks to align a query genome to a reference, index a genome, generate variant calls in VCF format, or create dot-plots for genomic comparisons.
homepage: https://github.com/hsinnan75/GSAlign
---


# gsalign

## Overview
GSAlign is a high-performance alignment tool optimized for comparing genomes within the same species. It leverages Burrows-Wheeler Transform (BWT) and a divide-and-conquer approach to efficiently handle large-scale genomic data. It is particularly effective at finding exact matches and differences between two genome sequences significantly faster than traditional methods, producing pairwise alignments (MAF/ALN), variant calls (VCF), and visual dot-plots.

## Installation
The most efficient way to install GSAlign is via Bioconda:
```bash
conda install bioconda::gsalign
```

## Command Line Usage

### 1. Indexing a Reference Genome
Before alignment, the reference genome must be indexed. You can do this as a standalone step or let GSAlign do it automatically during the first run.
```bash
# Syntax: GSAlign index <reference.fasta> <index_prefix>
GSAlign index reference.fa ref_index
```

### 2. Basic Alignment
Align a query genome against a reference genome.
```bash
# Using raw fasta files (GSAlign will index on the fly if needed)
GSAlign -r reference.fa -q query.fa -o output_prefix

# Using a pre-built index (Recommended for multiple queries)
GSAlign -i ref_index -q query.fa -o output_prefix
```

### 3. Common Parameter Patterns

| Task | Command Flag | Default |
| :--- | :--- | :--- |
| **Parallel Processing** | `-t INT` | 8 threads |
| **Sensitive Mode** | `-sen` | False (Use for higher sensitivity) |
| **Output Format** | `-fmt INT` | 1 (1: MAF, 2: ALN) |
| **Identity Threshold** | `-idy INT` | 70 (Minimum sequence identity) |
| **One-to-One Mapping** | `-one` | False (Forces query to align to at most one position) |
| **Unique Alignment** | `-unique` | False (Only output unique alignments) |
| **Disable Variants** | `-no_vcf` | False (Skips VCF generation) |

## Expert Tips and Best Practices

### Tuning for Low Similarity
If comparing sequences with lower similarity, adjust the seed length and cluster size to increase sensitivity:
- Decrease seed length: `-slen 10` (Default is 15).
- Decrease cluster size: `-clr 150` (Default is 250).

### Structural Variation Analysis
GSAlign is designed for intra-species comparison. To capture larger indels or specific structural variations:
- Adjust the maximal indel size: `-ind <INT>` (Default is 25).
- Use `-one` to ensure a linear mapping of the query genome to the reference, which is often preferred for synteny and structural variant discovery.

### Visualizing Alignments
To generate dot-plots, ensure `gnuplot` is installed on your system and use the `-dp` flag.
```bash
GSAlign -i ref_index -q query.fa -o output -dp -gp /usr/bin/gnuplot
```
*Note: Dot-plot generation may have compatibility issues on macOS.*

### Performance Optimization
Always match the thread count (`-t`) to your available CPU cores. For very large genomes, using a pre-built index (`-i`) saves significant time when running multiple query comparisons against the same reference.

## Reference documentation
- [GSAlign GitHub Repository](./references/github_com_hsinnan75_GSAlign.md)
- [Bioconda GSAlign Overview](./references/anaconda_org_channels_bioconda_packages_gsalign_overview.md)