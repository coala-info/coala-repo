---
name: treeqmc
description: TREE-QMC (Quartet Max Cut) is a specialized phylogenetic tool designed to infer species trees from a collection of gene trees or characters.
homepage: https://github.com/molloy-lab/TREE-QMC
---

# treeqmc

## Overview
TREE-QMC (Quartet Max Cut) is a specialized phylogenetic tool designed to infer species trees from a collection of gene trees or characters. While similar in purpose to ASTRAL, it utilizes a different algorithmic framework that is more robust to missing data across gene trees. It supports various weighting schemes for quartets and provides advanced features for detecting non-treelike evolution through its "tree of blobs" functionality.

## Installation
The tool is available via Bioconda:
```bash
conda install bioconda::treeqmc
```

## Common CLI Patterns

### Basic Species Tree Estimation
To estimate a species tree from a set of gene trees (Newick format):
```bash
tree-qmc -i gene_trees.tre -o species_tree.tre
```

### Recommended Weighting Scheme
For most phylogenomic datasets, the hybrid weighting scheme (balancing support and branch length) is recommended:
```bash
tree-qmc -i gene_trees.tre -w h -o species_tree.tre
```

### Working with Character Matrices
TREE-QMC can estimate trees directly from FASTA, PHYLIP, or NEXUS alignments:
```bash
tree-qmc --chars -i alignment.fasta -o species_tree.tre
```
For binary (0/1) characters, use the `--bp` flag instead of `--chars`.

### Tree of Blobs (Network Evolution)
To reconstruct a tree of blobs to evaluate gene flow or network-level processes:
```bash
tree-qmc -i gene_trees.tre --blob -o tree_of_blobs.tre
```

### Mapping Individuals to Species
If gene trees contain multiple individuals per species, provide a mapping file (format: `individual_name species_name`):
```bash
tree-qmc -i gene_trees.tre -a mapping.txt -o species_tree.tre
```

## Expert Tips and Best Practices

### Weighting Presets
Instead of manually setting hyperparameters, use presets based on your input support values:
- **Bayesian Support:** Use `-B` (sets `-n 0.333 -x 1.0 -d 0.333`).
- **Likelihood Ratio Test (LRT):** Use `-L` (sets `-n 0.0 -x 1.0 -d 0.0`).
- **Bootstrap Support:** Use `-S` (sets `-n 0 -x 100 -d 0`).

### Handling Large Datasets
If the dataset is extremely large and performance is an issue, use the `--fast` flag. Note that this refines polytomies arbitrarily and does not support weights.

### Post-Processing and Support
- **Rooting:** Use `--root` followed by a comma-separated list of outgroup species to root the output tree.
- **Quartet Support:** Add `--support` to compute quartet support for the branches in the output species tree.
- **Branch Contraction:** Use `-c <threshold>` to contract internal branches with support lower than the specified value (normalized 0 to 1).

### Inputting Quartets Directly
If you have quartet frequencies (e.g., from PhyloNetworks qCF format), use the `--quartets` flag. You can specify custom formats using `--quartetformat`.

## Reference documentation
- [TREE-QMC GitHub Repository](./references/github_com_molloy-lab_TREE-QMC.md)
- [TREE-QMC Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_treeqmc_overview.md)