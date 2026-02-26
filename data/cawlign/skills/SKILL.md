---
name: cawlign
description: cawlign is a high-performance tool designed for codon-aware alignment of FASTA sequences to a reference genome. Use when user asks to align sequences to a reference, perform codon-aware mapping, handle out-of-frame indels, or use the HXB2 pol reference.
homepage: https://github.com/veg/cawlign
---


# cawlign

## Overview

`cawlign` is a high-performance C++ tool designed for aligning FASTA sequences to a reference. Unlike general-purpose aligners, it specializes in codon-aware mapping, making it particularly effective for bioinformatics workflows involving viral genomes where maintaining the reading frame and handling homopolymer errors or out-of-frame indels is critical. It is a standalone port of the `bealign` tool from the BioExt package and is optimized for speed and low memory usage.

## Installation

The tool is primarily distributed via Bioconda:

```bash
conda install -c bioconda cawlign
```

## Common CLI Patterns

### Basic Nucleotide Alignment
Align a query FASTA to the default HIV-1 HXB2 pol reference using standard nucleotide scoring:

```bash
cawlign -o alignment.fa query.fa
```

### Codon-Aware Alignment
Perform alignment in codon space. This requires the reference to be in-frame. You can specify the genetic code using NCBI identifiers (e.g., 1 for Universal).

```bash
cawlign -t codon -c 1 -r reference.fa -o output.fa query.fa
```

### Handling Insertions
By default, `cawlign` uses the `refmap` format, which aligns query sequences to the reference but does **not** retain insertions relative to that reference. To retain insertions, use the `pairwise` format:

```bash
cawlign -f pairwise query.fa
```

### Local vs. Global Alignment
*   **Trim (Default)**: Performs a Smith-Waterman type local alignment to maximize the score.
*   **Global**: Forces a full string alignment where all gaps are scored equally.

```bash
cawlign -l global query.fa
```

## Expert Tips and Best Practices

*   **Reference Resolution**: When using `-r`, `cawlign` first checks if the provided string is a valid file path. If not, it searches its internal resource directory (typically `/usr/local/share/cawlign/references`).
*   **Memory Optimization**: For very long sequences, use `-S linear` to utilize a divide-and-conquer recursion that keeps only 6 columns in memory. Note that this is **not** currently implemented for codon-based data (`-t codon`).
*   **Affine Gap Scoring**: Affine gap scoring is enabled by default to better model biological indels. Use the `-a` flag to disable it if you require simple linear gap penalties.
*   **Reference Inclusion**: Use the `-I` flag if you want the reference sequence itself to be written into the output file, which is useful for downstream visualization or MSA-like processing.
*   **Genetic Codes**: When using `-t codon`, if the `-c` argument is omitted, the tool defaults to the universal genetic code. It supports NCBI table numbers (1, 2, 4, etc.) or names (e.g., "standard").

## Reference documentation

- [cawlign GitHub Repository](./references/github_com_veg_cawlign.md)
- [cawlign Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_cawlign_overview.md)