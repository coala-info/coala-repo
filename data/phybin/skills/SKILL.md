---
name: phybin
description: PhyBin organizes large collections of phylogenetic trees by grouping them based on topological similarity or Robinson-Foulds distance. Use when user asks to bin identical trees, perform hierarchical clustering, calculate Robinson-Foulds distances, or normalize taxa names across multiple gene trees.
homepage: https://github.com/rrnewton/PhyBin
metadata:
  docker_image: "biocontainers/phybin:v0.3-3-deb_cv1"
---

# phybin

## Overview
PhyBin is a command-line utility designed to organize large collections of phylogenetic trees by their topological similarity. It serves two primary functions: "binning," which groups trees with identical topologies, and "clustering," which groups trees based on the Robinson-Foulds symmetric difference metric. By collapsing short branches and normalizing taxa names, PhyBin helps researchers navigate complex tree search results and identify the most frequent evolutionary signals in a dataset.

## Core CLI Patterns

### Basic Binning
To group exactly identical trees into bins and save the results to a specific directory:
```bash
phybin --bin *.tree -o results_dir/
```

### Hierarchical Clustering
To perform UPGMA clustering (default) and generate a distance matrix and a dendrogram visualization:
```bash
phybin -g *.tree --rfdist
```
*Note: Requires GraphViz installed for PDF visualization.*

### Flat Clustering by Distance
To combine all trees within a specific Robinson-Foulds distance (e.g., 5) into flat clusters:
```bash
phybin --editdist=5 *.tree
```

### Tree Pre-processing
Refine tree comparisons by ignoring insignificant branches or filtering by support values:
- **Collapse short branches**: `-b 0.01` (collapses branches shorter than 0.01).
- **Filter by bootstrap**: `--minbootstrap 70` (treats nodes with support < 70 as polytomies).
- **Focus on specific taxa**: `--prune "TaxonA,TaxonB,TaxonC"` to zoom in on a subset.

## Taxa Name Normalization
PhyBin often deals with gene trees where leaf names include extra metadata. Use these flags to extract consistent taxa names:
- **Prefix**: `-p 5` (uses the first 5 characters as the taxon name).
- **Delimiter**: `-s "_"` (stops at the first underscore).
- **Mapping File**: `-m mapping.txt` (uses a find/replace table for complex renaming).

## Expert Tips
- **Performance**: PhyBin uses the `HashRF` algorithm by default for distance matrices. For very small datasets where you suspect issues, you can force the slower algorithm with `--simple`.
- **Missing Taxa**: If your trees do not all contain the same set of taxa, use the `--tolerant` mode to compute RF distances based on the intersection of taxa.
- **Visualization**: Use the `--interior` flag when generating dendrograms to see the consensus trees for internal nodes, which helps in understanding what defines a specific cluster.
- **Disambiguation**: If a single file contains multiple trees, PhyBin automatically appends a suffix (e.g., `_0`, `_1`) to distinguish them.

## Reference documentation
- [PhyBin Main Documentation](./references/github_com_rrnewton_PhyBin.md)