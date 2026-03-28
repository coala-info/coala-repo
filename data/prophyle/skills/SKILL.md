---
name: prophyle
description: ProPhyle is a DNA sequence classifier that uses k-mer based approaches and phylogenetic structures to analyze metagenomic data. Use when user asks to download reference genomes, index sequences according to a taxonomic tree, classify sequencing reads, or estimate organism abundance.
homepage: https://github.com/karel-brinda/prophyle
---

# prophyle

## Overview

ProPhyle is a DNA sequence classifier designed for metagenomics that combines k-mer based approaches with phylogenetic structures. It utilizes the Burrows-Wheeler Transform (BWT) and phylogenetic compression to create "simplitigs," which significantly reduce the memory footprint of genomic indices. Use this skill to guide the workflow of downloading reference genomes, indexing them according to a taxonomic tree, and classifying sequencing data with high deterministic accuracy.

## Core Workflow and CLI Patterns

### 1. Database Preparation
ProPhyle can automatically fetch genomic data and taxonomy.

```bash
# Download a specific dataset (e.g., bacteria, viruses)
prophyle download <dataset_name>

# Common datasets: 'bacteria', 'viruses', 'hmp'
```

### 2. Index Construction
Indexing requires a phylogenetic tree (Newick format) and the corresponding genomic sequences.

```bash
# Build the index
prophyle index -t <tree.nwk> <library_dir> <index_prefix>

# Optimization: Use -k to specify k-mer length (default is 31)
prophyle index -k 23 -t tree.nwk ./sequences/ my_index
```

### 3. Sequence Classification
Classify reads against the constructed index. ProPhyle typically outputs results in a format compatible with downstream analysis (often SAM-like or assignments to tree nodes).

```bash
# Classify reads
prophyle classify <index_prefix> <reads.fastq> > <assignments.txt>

# For paired-end reads
prophyle classify <index_prefix> <reads_1.fq> <reads_2.fq> > <assignments.txt>
```

### 4. Abundance Analysis
After classification, use the analyze command to estimate the abundance of organisms.

```bash
# Estimate abundances
prophyle analyze <index_prefix> <assignments.txt> <output_prefix>
```

## Expert Tips and Best Practices

- **Memory Management**: ProPhyle is designed to be frugal, but for very large bacterial databases, ensure your system has sufficient RAM for the BWT construction phase.
- **K-mer Selection**: Use shorter k-mers (e.g., k=21 or 23) for higher sensitivity in divergent species, and longer k-mers (e.g., k=31) for higher specificity.
- **Tree Customization**: You can provide custom Newick trees to focus classification on specific clades or to use non-NCBI taxonomies.
- **Simplitigs**: If manually managing sequences, remember that ProPhyle converts k-mers into simplitigs (maximal non-branching paths in a de Bruijn graph) to optimize the BWT.



## Subcommands

| Command | Description |
|---------|-------------|
| prophyle analyze | Analyze classified reads based on an index directory or phylogenetic tree. |
| prophyle classify | Classify reads using a prophyle index. |
| prophyle compress | Compresses a prophyle index directory into a tar.gz archive. |
| prophyle decompress | Decompress a prophyle archive |
| prophyle download | Download genomic libraries and associated data. |
| prophyle_classify | Classify reads based on a prophyle index. |
| prophyle_compile | Compile prophyle database |
| prophyle_footprint | Calculate footprint of prophages in a genome. |
| prophyle_index | Index phylogenetic trees for efficient querying. |

## Reference documentation
- [ProPhyle Homepage/Index](./references/prophyle_github_io_index.md)
- [Installation Guide](./references/prophyle_github_io_install.html.md)
- [Usage Examples](./references/prophyle_github_io_example.html.md)
- [GitHub Repository README](./references/github_com_prophyle_prophyle_blob_master_README.rst.md)