---
name: pplacer
description: pplacer places DNA fragments into a fixed phylogenetic reference tree to identify their origin. Use when user asks to place query sequences into a reference phylogeny, calculate phylogenetic diversity metrics, or perform taxonomic analysis on metagenomic reads.
homepage: http://matsen.fredhutch.org/pplacer/
metadata:
  docker_image: "quay.io/biocontainers/pplacer:1.1.alpha17--0"
---

# pplacer

## Overview
The `pplacer` suite provides a high-performance workflow for placing fragments of DNA (query sequences) into a pre-established phylogenetic context. Unlike traditional tree-building, `pplacer` keeps the reference tree fixed, making it ideal for analyzing large metagenomic datasets where you need to identify the origin of reads without re-calculating the entire phylogeny. The suite includes `pplacer` for the core placement, `guppy` for downstream transformations and diversity metrics, and `rppr` for reference package management and taxonomic analysis.

## Core Workflow and CLI Patterns

### 1. Basic Placement
The primary command requires a reference alignment, a reference tree, and the query sequences. It is highly recommended to use a "reference package" (.refpkg) created by `taxtastic` to simplify the command.

```bash
# Using a reference package (Recommended)
pplacer -c my_refpkg.refpkg query_alignment.fasta

# Manual specification (If no refpkg is available)
pplacer -t reference_tree.tre -r reference_alignment.fasta query_alignment.fasta
```

### 2. Key Parameters for Accuracy
- `-n`: Number of placements to keep for each query (default is 7). Increase this if you need to explore uncertainty.
- `--max-pend`: Maximum number of "pendant" branch lengths to consider.
- `--map-identity`: Filters out sequences that do not meet a specific identity threshold to the reference.

### 3. Downstream Analysis with Guppy
`guppy` is the Swiss-army knife for handling `.jplace` files produced by `pplacer`.

- **Visualization**: Convert placements to a format viewable in FigTree or Archaeopteryx.
  ```bash
  guppy tog my_placements.jplace
  ```
- **Diversity Metrics**: Calculate Phylogenetic Diversity (PD) or UniFrac.
  ```bash
  guppy fpd my_placements.jplace
  guppy unifrac my_placements.jplace
  ```
- **Ordination**: Perform Edge PCA to see how samples differ in phylogenetic space.
  ```bash
  guppy epca my_placements.jplace
  ```

### 4. Taxonomic Analysis with Rppr
Use `rppr` when you need to reconcile phylogenetic placements with taxonomic databases.

- **Check Discordance**: Identify where the tree topology disagrees with the taxonomy.
  ```bash
  rppr check -c my_refpkg.refpkg
  ```

## Expert Tips
- **Memory Management**: For very large reference trees, use the `--mmap` flag to reduce RAM usage by mapping the tree structure to disk.
- **Gzip Support**: Modern versions of `pplacer` (v1.1+) support `.gz` compressed FASTA and `.jplace` files directly.
- **Alignment Consistency**: Ensure your query sequences are aligned to the *same* Hidden Markov Model (HMM) or profile used for the reference alignment. Discrepancies here are the leading cause of poor placement scores.
- **Deduplication**: Use the `deduplicate_sequences.py` script (included in the suite) before running `pplacer` to speed up processing of high-depth datasets.

## Reference documentation
- [Matsen Group Pplacer Home](./references/matsen_fredhutch_org_pplacer.md)
- [Bioconda Pplacer Package](./references/anaconda_org_channels_bioconda_packages_pplacer_overview.md)