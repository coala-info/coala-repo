---
name: mp-est
description: MP-EST reconstructs species trees from a collection of rooted gene trees by maximizing a pseudo-likelihood function based on triplet frequencies. Use when user asks to estimate species tree topology and branch lengths in coalescent units, calculate triplet or quartet distances, or evaluate species-tree-gene-tree concordance.
homepage: https://github.com/lliu1871/mp-est
metadata:
  docker_image: "quay.io/biocontainers/mp-est:3.1.0--h7b50bb2_0"
---

# mp-est

## Overview
MP-EST (Maximum Pseudo-likelihood Estimation of Species Trees) is a specialized phylogenetic tool that reconstructs species-level relationships from a set of independent gene trees. By maximizing a pseudo-likelihood function based on the frequency of rooted triplets, it provides estimates of species tree topology and branch lengths in coalescent units. Modern versions (3.0+) utilize a direct command-line interface, supporting features like NJst tree initialization, polytomy handling, and concordance score calculation.

## Command Line Usage

### Basic Species Tree Estimation
To estimate a species tree from a set of rooted gene trees in Nexus format:
```bash
mpest -i gene_trees.nexus
```

### Improving Search Robustness
For complex datasets, run the optimization multiple times with different starting points to avoid local optima:
```bash
mpest -i gene_trees.nexus -n 10 -s 12345
```
*   `-n`: Number of independent runs (default is 1).
*   `-s`: Sets a specific seed for reproducibility.

### Handling Short Branches and Polytomies
MP-EST can handle or create polytomies to reduce noise from poorly supported short branches:
```bash
mpest -i gene_trees.nexus -c 0.000001
```
*   `-c`: Converts branches shorter than the specified value into polytomies before estimation.

### Using NJst Initialization
Use the Neighbor-Joining species tree from gene tree distances (NJst) as the starting tree for the pseudo-likelihood search:
```bash
mpest -i gene_trees.nexus -N
```

### Fixed Tree Analysis
If you have a specific species tree topology and want to optimize branch lengths or calculate likelihood:
*   **Optimize branch lengths**: `mpest -i gene_trees.nexus -u species_topology.tre -B`
*   **Calculate log-likelihood**: `mpest -i gene_trees.nexus -u species_topology.tre -L`

### Tree Distance Calculations
MP-EST can calculate distances between gene trees in the input file:
*   **Quartet distances**: `mpest -i gene_trees.nexus -Q`
*   **Triplet distances**: `mpest -i gene_trees.nexus -T`

## Best Practices and Tips
*   **Input Requirements**: Gene trees must be **rooted**. While the tool can handle polytomies, the underlying pseudo-likelihood theory for MP-EST specifically utilizes rooted triplets.
*   **File Format**: Ensure the input file is in valid Nexus format.
*   **Output Interpretation**:
    *   `[input]_besttree.tre`: Contains the best species tree(s) found across all runs.
    *   `[input]_output.tre`: Contains intermediate trees updated during the algorithm.
*   **Concordance Scores**: Version 3.0+ automatically outputs species-tree-gene-tree concordance scores for each internal node of the resulting MP-EST tree, which is useful for assessing nodal support.
*   **Branch Lengths**: Remember that the estimated branch lengths are in **coalescent units** (2N generations), not substitutions per site.

## Reference documentation
- [MP-EST GitHub Repository](./references/github_com_lliu1871_mp-est.md)
- [Bioconda mp-est Package](./references/anaconda_org_channels_bioconda_packages_mp-est_overview.md)