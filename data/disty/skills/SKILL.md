---
name: disty
description: disty transforms core genome alignments into distance matrices while providing multiple strategies for handling ambiguous bases. Use when user asks to calculate genetic distances, generate a distance matrix from a FASTA alignment, or handle ambiguous bases in genomic data.
homepage: https://github.com/c2-d2/disty
metadata:
  docker_image: "quay.io/biocontainers/disty:0.1.0--1"
---

# disty

## Overview
The `disty` tool (also known as Disty McMatrixface) is a high-performance utility designed to transform core genome alignments into distance matrices. It provides several strategies for handling ambiguous bases (N's) and supports both standard nucleotide (ACGT) and binary (01) input formats. Use this skill to generate the necessary matrices for downstream clustering or tree-building applications.

## Usage Patterns

### Basic Distance Calculation
To generate a distance matrix from a standard FASTA alignment:
```bash
disty alignment.fa > distance_matrix.txt
```

### Handling Ambiguous Bases (N's)
The tool offers multiple strategies for dealing with N's via the `-s` flag. Choosing the right strategy is critical for the accuracy of the distance metrics:

- **Pairwise Deletion (Default, `-s 0`):** Ignores N's only in the specific pair being compared.
- **Normalized Pairwise Deletion (`-s 1`):** Ignores N's pairwisely and normalizes the distance based on the number of valid sites.
- **Global Deletion (`-s 2`):** Ignores any column in the alignment that contains at least one N across all samples.
- **Major Allele Replacement (`-s 3`):** Replaces N's with the most frequent allele at that position.

### Filtering High-Ambiguity Columns
If an alignment contains columns with too many missing values, use the `-n` flag to skip them:
```bash
# Skip columns where more than 20% of sequences have an 'N'
disty -n 0.20 alignment.fa
```

### Working with Binary Data
For alignments already converted to binary format (0/1):
```bash
disty -i 1 binary_alignment.fa
```

## Expert Tips
- **Input Consistency:** Ensure all sequences in the input FASTA are of equal length (a "core" alignment). The tool may produce errors or unexpected results if lengths are mismatched.
- **Performance:** `disty` is written in C++ and is highly efficient for large alignments. For massive datasets, prefer the default pairwise deletion or global deletion to minimize memory overhead.
- **Output Format:** The output is a standard tab-delimited square matrix where the first row and column contain the sequence identifiers. This format is directly compatible with most R packages (like `ape`) and clustering tools.

## Reference documentation
- [Disty McMatrixface GitHub Repository](./references/github_com_c2-d2_disty.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_disty_overview.md)