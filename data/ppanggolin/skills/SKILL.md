---
name: ppanggolin
description: PPanGGOLiN is a suite of tools that uses a statistical approach and genomic context to model and partition microbial pangenomes. Use when user asks to build a partitioned pangenome graph, predict regions of genomic plasticity, identify conserved modules, or analyze large-scale datasets including metagenomic assembled genomes.
homepage: https://github.com/labgem/PPanGGOLiN
---


# ppanggolin

## Overview
PPanGGOLiN (Partitioned PanGenome Graph of Linked Neighbors) is a suite of tools designed to model microbial species diversity. Unlike traditional methods that use fixed sequence identity thresholds, PPanGGOLiN uses a statistical approach and genomic context (neighborhood) to partition the pangenome. This makes it exceptionally robust for large-scale datasets and low-quality data such as Metagenomic Assembled Genomes (MAGs) or Single-cell Amplified Genomes (SAGs).

## Core Workflows

### 1. Complete Analysis
The `all` subcommand is the standard entry point. It performs annotation (if needed), clustering, graph construction, partitioning, and prediction of RGPs and modules in a single execution.

```bash
# Using FASTA files
ppanggolin all --fasta genomes_list.tsv

# Using existing annotations (GFF/GBK)
ppanggolin all --anno annotations_list.tsv
```

### 2. Specialized Workflows
If you do not need the full suite of predictions, use more targeted commands to save time:
*   `ppanggolin workflow`: Builds the partitioned pangenome graph only.
*   `ppanggolin panrgp`: Builds the graph and predicts RGPs and insertion spots.
*   `ppanggolin panmodule`: Builds the graph and predicts conserved modules.

## Input Preparation
PPanGGOLiN requires a tab-separated values (TSV) file to define the input genomes.

**FASTA List Format (`--fasta`):**
`Genome_Name    /path/to/genome.fasta`

**Annotation List Format (`--anno`):**
`Genome_Name    /path/to/genome.gff` (or .gbk/.gbff)

*Note: Genome names must be unique and contain no spaces.*

## Best Practices and Expert Tips

### Genome Selection
*   **Minimum Count**: While the tool runs with 5 genomes, use at least **15 genomes** with genomic variation to ensure the statistical partitioning approach is robust.
*   **Diversity**: Ensure the dataset contains actual genomic variation rather than just SNPs for meaningful pangenome partitioning.

### Iterative Analysis with HDF5
The primary output is `pangenome.h5`. This file stores the state of the pangenome and should be used as input for downstream subcommands to avoid recomputing previous steps.

```bash
# Example: Generating a rarefaction curve from an existing pangenome
ppanggolin rarefaction -p pangenome.h5
```

### Handling MAGs and SAGs
Because PPanGGOLiN integrates genomic neighborhood information, it can accurately classify genes even when the assembly is fragmented. If working with highly fragmented MAGs, the statistical model often outperforms traditional presence/absence matrices.

### Integration with Annotation Tools
PPanGGOLiN works best with high-quality annotations. It is highly compatible with outputs from:
*   **Bakta**: Recommended for modern, fast, and feature-rich annotation.
*   **Prokka**: The traditional standard for rapid prokaryotic annotation.

## Common Subcommands for Downstream Analysis
*   `ppanggolin write`: Export pangenome data to various formats (TSV, GEXF for Gephi, etc.).
*   `ppanggolin draw`: Generate visualizations like rarefaction curves or tile plots.
*   `ppanggolin info`: Get summary statistics of the pangenome (number of families per partition, etc.).

## Reference documentation
- [PPanGGOLiN GitHub Repository](./references/github_com_labgem_PPanGGOLiN.md)
- [PPanGGOLiN Wiki](./references/github_com_labgem_PPanGGOLiN_wiki.md)