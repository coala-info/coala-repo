---
name: quicktree
description: QuickTree rapidly infers phylogenetic trees from large alignments or distance matrices using Neighbor-Joining or UPGMA methods. Use when user asks to construct a phylogeny, generate a Newick tree from a Stockholm alignment, perform bootstrap analysis, or build a tree from a PHYLIP distance matrix.
homepage: https://github.com/khowe/quicktree
---


# quicktree

## Overview
QuickTree is a high-performance tool designed for the rapid inference of phylogenies from large datasets. While many phylogenetic tools struggle with scale, QuickTree is optimized for speed and efficiency, making it suitable for "huge" alignments. It primarily implements the Neighbor-Joining method but also supports UPGMA and bootstrapping to provide robust evolutionary trees in standard Newick format.

## Installation
The most reliable way to install QuickTree is via Bioconda:
```bash
conda install bioconda::quicktree
```

## Common CLI Patterns

### Basic Tree Construction
To generate a Neighbor-Joining tree from a Stockholm alignment:
```bash
quicktree alignment.stockholm > tree.nwk
```

### Using Distance Matrices
If you already have a distance matrix in PHYLIP format, use the `-in m` flag:
```bash
quicktree -in m distance_matrix.phylip > tree.nwk
```

### Bootstrapping
To perform bootstrap analysis (e.g., 100 iterations) to assess branch support:
```bash
quicktree -b 100 alignment.stockholm > bootstrapped_trees.nwk
```

### Alternative Algorithms
To use the UPGMA algorithm instead of the default Neighbor-Joining:
```bash
quicktree -u alignment.stockholm > tree.nwk
```

## Expert Tips and Best Practices

### Input Format Requirements
QuickTree is strict about its input formats:
- **Alignments**: Must be in **Stockholm** format (the native format for Pfam).
- **Distance Matrices**: Must be in **PHYLIP** format.
- **Conversion**: If your alignment is in FASTA or Clustal format, use the `sreformat` tool from the HMMer package to convert it:
  ```bash
  sreformat stockholm my_alignment.fasta > my_alignment.stockholm
  ```

### Handling Output
QuickTree writes trees directly to `stdout`. Always redirect the output to a file to avoid flooding the terminal with Newick strings.

### Large Scale Processing
Because QuickTree is written in ANSI C and optimized for efficiency, it is often the preferred choice for initial tree building in pipelines where computational resources or time are limited, or where the number of sequences exceeds the capacity of maximum likelihood or Bayesian methods.

## Reference documentation
- [QuickTree GitHub README](./references/github_com_khowe_quicktree.md)
- [Bioconda QuickTree Overview](./references/anaconda_org_channels_bioconda_packages_quicktree_overview.md)