---
name: r-ctree
description: The r-ctree tool builds, samples, and visualizes tumor clone trees from subclonal deconvolution data using Cancer Cell Fractions. Use when user asks to model cancer evolutionary trajectories, infer subclonal hierarchies from bulk sequencing data, or generate phylogenetic trees of tumor clones.
homepage: https://cran.r-project.org/web/packages/ctree/index.html
---


# r-ctree

name: r-ctree
description: Expert guidance for the ctree R package to build, sample, and visualize tumor clone trees from subclonal deconvolution data (Cancer Cell Fractions). Use this skill when analyzing cancer evolutionary trajectories, modeling subclonal hierarchies from bulk sequencing data, or generating phylogenetic trees of tumor clones.

## Overview

The `ctree` package implements clone trees for cancer evolutionary studies. It models evolutionary trajectories using Cancer Cell Fractions (CCFs) clusters derived from tumor subclonal deconvolution. It supports both single-sample and multi-region biopsy data, providing S3 objects for mutation trees and a Monte Carlo sampler to explore the space of possible tree topologies.

## Installation

Install the package from GitHub using `devtools`:

```R
# install.packages("devtools")
devtools::install_github("caravagnalab/ctree")
```

## Main Functions and Workflow

### 1. Data Preparation
The package requires CCF clusters. You typically provide a data frame with cluster IDs and their mean CCF values across samples.

```R
# Example CCF data structure
# clusters: cluster ID, and columns for each sample's CCF
ccf_data <- data.frame(
  cluster = c("Cl1", "Cl2", "Cl3"),
  Sample1 = c(1.0, 0.6, 0.3),
  stringsAsFactors = FALSE
)
```

### 2. Building and Sampling Trees
Use the `ctrees` function to generate clone trees. It uses a Monte Carlo sampler to find trees that satisfy the pigeonhole principle and sum-rule constraints.

```R
library(ctree)

# Generate trees
# x: CCF data, min_ccf: threshold for presence
trees <- ctrees(
  ccf_data, 
  samples = c("Sample1"), 
  patient = "Patient_A"
)
```

### 3. Visualization
`ctree` provides several plotting methods to inspect the inferred evolution.

```R
# Plot the best tree (or a specific index)
plot(trees[[1]])

# Plot CCF clusters across samples
plot_clusters(trees[[1]])

# Plot the clone tree structure
plot_clone_tree(trees[[1]])
```

### 4. S3 Methods and Analysis
- `print(tree)`: Summary of the tree structure and clusters.
- `summary(tree)`: Detailed metrics of the tree.
- `get_adj_matrix(tree)`: Retrieve the adjacency matrix of the clone hierarchy.

## Tips for Effective Usage

- **Pigeonhole Principle**: Ensure your input CCFs are consistent; the sum of CCFs of children nodes cannot exceed the CCF of the parent node.
- **Multi-region Data**: When using multiple biopsies, `ctree` uses the joint CCF distributions to constrain the tree search more effectively than single-sample analysis.
- **Mutation Trees vs. Clone Trees**: Use `ctree` for CCF-based clusters. If you are working with binary (presence/absence) mutation profiles, consider the sibling package `mtree`.

## Reference documentation

- [NEWS.md](./references/NEWS.md)
- [README.Rmd.md](./references/README.Rmd.md)
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)