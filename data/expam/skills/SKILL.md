---
name: expam
description: expam is a computational tool for high-resolution metagenomic profiling that maps sequencing reads to phylogenetic trees. Use when user asks to build genomic databases, perform tree-based metagenomic profiling, map results to NCBI taxonomy, or visualize microbial community distributions.
homepage: https://github.com/seansolari/expam
---


# expam

## Overview
`expam` is a computational tool designed for high-resolution metagenomic profiling. Unlike traditional methods that rely solely on k-mer matches or Lowest Common Ancestor (LCA) approaches, `expam` leverages phylogenetic trees to provide a more accurate representation of microbial communities. It maps sequencing reads to nodes within a reference phylogeny, allowing for both phylogenetic and taxonomic interpretations of the data. It is particularly useful for researchers who need to manage large-scale genomic databases and require deterministic, tree-based classification.

## Installation and Setup
The recommended way to install `expam` is via Conda to ensure all dependencies, including the ETE3 toolkit for visualization, are correctly managed.

```bash
# Recommended installation with visualization support
conda create -n expam -c conda-forge -c bioconda -c etetoolkit expam ete3

# Basic installation without ETE3
conda create -n expam -c conda-forge -c bioconda expam
```

## Core Workflows and CLI Patterns

### 1. Database Construction
When building a database, `expam` requires an `accession_ids.csv` file. 
*   **Critical Step**: After a successful database build, you must manually specify Taxonomic IDs in the third column of the `accession_ids.csv` file to enable taxonomic mapping.

### 2. Metagenomic Profiling
Profiling generates counts for sequences mapped to the phylogeny.
*   **Filtering**: Use the `--cpm` (counts per million) flag to apply automated cutoffs. Note that the older `--cutoff` flag has been deprecated.
*   **Output**: The tool produces sample summaries that combine Single-Lineage (SL) and Multi-Lineage (ML) counts into a 'total' counts column.

### 3. Taxonomic Mapping
If you have phylogenetic results and need to convert them to standard NCBI taxonomy:
```bash
expam to_taxonomy <input_results>
```
*   **Note**: Ensure you are using version 1.4.0.0 or higher, as earlier versions had bugs related to "environmental samples" in the NCBI taxonomy.

### 4. Visualization
`expam` can generate phylogenetic trees of your results.
*   **ETE3 Integration**: Use the `expam tree` command to create plots.
*   **iTOL Support**: Use the `--itol` flag to generate files compatible with the Interactive Tree of Life web tool.
*   **Scaling**: Use `--log-scale` for better visualization of samples with high dynamic range in abundance.

### 5. Distance Matrix Calculation
For comparative metagenomics, `expam` integrates with Sourmash:
```bash
expam tree ... --sourmash
```
*   Ensure your signatures file is present before running, as the tool checks for this file to calculate distance matrices.

## Expert Tips and Best Practices
*   **Memory Management**: For large databases, use the `expam_limit` utility to prevent the system OOM (Out of Memory) killer from terminating processes. Avoid using an excessively high number of processes on memory-constrained systems.
*   **Taxonomy Updates**: `expam` now uses ETE3 to interface with the NCBI taxonomy. If your taxonomic outputs seem inconsistent, verify your ETE3 database is up to date.
*   **Unique K-mers**: Use the included `CountUniqueKmers.py` script in the `scripts/` directory to analyze the uniqueness of k-mers within your reference set before running full profiles.

## Reference documentation
- [expam - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_expam_overview.md)
- [GitHub - seansolari/expam](./references/github_com_seansolari_expam.md)