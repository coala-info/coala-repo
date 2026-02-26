---
name: tree-qmc
description: TREE-QMC is a phylogenomic tool that infers species trees and analyzes network-like evolution using the Quartet Max Cut framework. Use when user asks to estimate a species tree, map individuals to species, estimate a tree from character matrices, analyze network-like evolution, get branch support for the output tree, or root the output tree.
homepage: https://github.com/molloy-lab/TREE-QMC
---


# tree-qmc

## Overview
TREE-QMC (Quartet-based species tree and tree of blob estimation) is a phylogenomic tool that utilizes the Quartet Max Cut framework to infer species trees. While similar in purpose to ASTRAL, TREE-QMC employs a different algorithmic approach that makes it more robust for datasets where many taxa are missing across different gene trees. It supports various input formats, including Newick gene trees and character matrices (FASTA, PHYLIP, NEXUS), and provides specialized functionality for hypothesis testing regarding star-tree vs. network-like evolution.

## Common CLI Patterns

### Basic Species Tree Estimation
The most common use case involves estimating a species tree from a set of gene trees:
```bash
tree-qmc -i gene_trees.tre -o species_tree.tre
```

### Using Recommended Weighting
For most phylogenomic datasets, the hybrid weighting scheme (combining support and length) is recommended for better accuracy:
```bash
tree-qmc -i gene_trees.tre -w h -o species_tree.tre
```

### Mapping Individuals to Species
If your gene trees use individual names but you want a species-level tree, provide a mapping file:
```bash
tree-qmc -i gene_trees.tre -a mapping.txt -o species_tree.tre
```
*Note: The mapping file should be space-separated: `individual_name species_name`.*

### Character Matrix Input
To estimate a tree directly from binary or multi-state characters:
```bash
# For binary characters (0/1)
tree-qmc --bp -i binary_data.fasta -o species_tree.tre

# For multi-state characters
tree-qmc --chars -i data.phy -o species_tree.tre
```

### Tree of Blobs (Network Analysis)
To identify non-treelike evolution and gene flow:
```bash
tree-qmc -i gene_trees.tre --blob -o tree_of_blobs.tre
```

## Expert Tips and Best Practices

### Handling Support Values
TREE-QMC provides presets for different types of input branch support. Use these to ensure the weighting algorithm interprets your input values correctly:
- **Bayesian Posterior Probabilities**: Use `-B` or `--bayes` (interprets values as 0.33 to 1.0).
- **Likelihood Ratio Test (LRT)**: Use `-L` or `--lrt` (interprets values as 0.0 to 1.0).
- **Bootstrap Support**: Use `-S` or `--bootstrap` (interprets values as 0 to 100).

### Branch Support and Output
To get a comprehensive analysis of the resulting tree, use the support and table flags:
```bash
tree-qmc -i gene_trees.tre --support --writetable support_stats.csv -o species_tree.tre
```
This generates quartet support for the output branches and saves detailed statistics to a CSV file.

### Rooting the Output
You can specify a root during the estimation process to avoid post-processing:
```bash
tree-qmc -i gene_trees.tre --root OutgroupA,OutgroupB -o species_tree.tre
```

### Performance Optimization
If you have a very large number of taxa and do not require weighted quartets or the handling of polytomies, use the fast algorithm:
```bash
tree-qmc -i gene_trees.tre --fast -o species_tree.tre
```

## Reference documentation
- [TREE-QMC GitHub Repository](./references/github_com_molloy-lab_TREE-QMC.md)
- [TREE-QMC Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_tree-qmc_overview.md)