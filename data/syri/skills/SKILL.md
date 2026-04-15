---
name: syri
description: SyRI identifies syntenic regions and structural rearrangements by comparing two whole-genome assemblies. Use when user asks to find genomic differences between assemblies, classify structural variations, or identify syntenic regions.
homepage: https://github.com/schneebergerlab/syri
metadata:
  docker_image: "quay.io/biocontainers/syri:1.7.1--py311hcf77733_1"
---

# syri

## Overview

SyRI (Synteny and Rearrangement Identifier) is a specialized tool for comparing two whole-genome assemblies to find genomic differences. Unlike tools that focus solely on small variants, SyRI classifies the entire genome into syntenic regions (conserved order) and various types of structural rearrangements. It works by analyzing the alignments between a reference and a query genome, providing a comprehensive map of how the two genomes relate structurally.

## Installation and Setup

The most reliable way to install SyRI is via Bioconda:

```bash
conda create -n syri_env -c bioconda syri
conda activate syri_env
```

## Common CLI Patterns

### Running with PAF Alignments (Recommended)
If you have generated alignments using `minimap2` in PAF format, use the `-F P` flag:

```bash
syri -c alignments.paf -r reference.fasta -q query.fasta -F P
```

### Running with NUCmer (MUMmer) Coords
If using MUMmer's `show-coords` output:

```bash
syri -c out.coords -r reference.fasta -q query.fasta -F n
```

### Adjusting Structural Variation Output
To control the reporting of sequence information for large structural variants (SVs) and Highly Divergent Regions (HDR):

```bash
# Limit sequence printing to SVs smaller than 100kb
syri -c alignments.paf -r ref.fa -q query.fa -F P --maxsize 100000

# Toggle printing of HDR sequences
syri -c alignments.paf -r ref.fa -q query.fa -F P --hdrseq
```

## Expert Tips and Best Practices

### 1. Chromosome Orientation (Critical)
SyRI requires homologous chromosomes to be on the same strand. If the majority of alignments between two chromosomes are inverted, SyRI may crash or fail to find synteny.
*   **Fix**: Manually check a dot plot. If a chromosome is inverted, reverse-complement the query chromosome sequence and re-align before running SyRI.

### 2. Alignment Quality
The accuracy of SyRI is entirely dependent on the input alignments. 
*   For `minimap2`, use the latest version (2.18+) to ensure inverted regions are aligned correctly.
*   Ensure you are using chromosome-level assemblies; fragmented assemblies (scaffolds/contigs) can lead to excessive "novel" or "unaligned" classifications.

### 3. Handling Inversions
If you suspect inversions are being missed or incorrectly split, adjust the `--invgaplen` parameter. This regulates the allowed gap length between alignments that form an inversion.

### 4. Visualizing Results
SyRI output is often used in conjunction with `plotsr`, a separate tool from the same laboratory, to generate high-quality synteny plots.

## Troubleshooting Common Errors

*   **Contig Mismatch**: If you see "No matching contig was found," ensure that the headers in your FASTA files exactly match the chromosome IDs in your alignment (`.paf` or `.coords`) file.
*   **Memory Usage**: Large translocations or duplications involving many alignments can significantly increase CPU and RAM usage. Ensure your environment has sufficient resources for large eukaryotic genomes.

## Reference documentation
- [SyRI GitHub Repository](./references/github_com_schneebergerlab_syri.md)
- [SyRI Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_syri_overview.md)