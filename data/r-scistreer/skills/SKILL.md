---
name: r-scistreer
description: The r-scistreer package infers maximum-likelihood phylogenetic trees from single-cell genotype probability matrices. Use when user asks to infer cell phylogenies, perform nearest neighbor interchange searches to refine tree topologies, or annotate mutations onto phylogenetic branches.
homepage: https://cran.r-project.org/web/packages/scistreer/index.html
---

# r-scistreer

## Overview

The `scistreer` package provides an R interface for the ScisTree algorithm, optimized for scale using Rcpp and RcppParallel. It is designed to infer maximum-likelihood phylogenies from single-cell data where genotypes are represented as probabilities (0 to 1). It can handle large datasets exceeding 10,000 cells.

## Installation

```R
install.packages("scistreer")
```

## Core Workflow

The primary entry point is `run_scistree()`, which encapsulates the full pipeline from initialization to maximum-likelihood search.

### 1. Fast Inference
Input `P` must be a matrix of genotype probabilities (cells as rows, mutations as columns).

```R
library(scistreer)

# P is a cell x mutation probability matrix
# init can be "UPGMA" or "NJ"
tree <- run_scistree(P, init = "UPGMA", ncores = 1)
```

### 2. Step-by-Step ML Search
If you have an existing tree and want to refine it using Nearest Neighbor Interchanges (NNI):

```R
# Perform NNI search to improve likelihood
tree_list <- perform_nni(tree_init = my_tree, P = P_matrix, max_iter = 100)

# The result is a multiPhylo object; the last tree is usually the best
best_tree <- tree_list[[length(tree_list)]]
```

### 3. Scoring and Annotation
Evaluate the likelihood of a specific tree topology or map mutations onto the branches.

```R
# Get likelihood score
score <- score_tree(tree, P)$l_tree

# Annotate mutations on the tree (returns a tbl_graph/igraph object)
gtree <- annotate_tree(tree, P)

# Convert back to phylo if needed
phylo_tree <- to_phylo(gtree)
```

### 4. Visualization
`scistreer` integrates with `ggplot2` and `ggtree` to visualize the relationship between the phylogeny and the underlying mutation data.

```R
# Plot tree with a mutation probability heatmap
p <- plot_phylo_heatmap(tree, P)
print(p)
```

## Data Structures

- **P Matrix**: Rows are cells, columns are mutations. Values are probabilities $[0, 1]$.
- **phylo**: Standard phylogenetic tree object (from `ape` package).
- **tbl_graph**: An annotated graph object (from `tidygraph`) used when mutations are mapped to specific nodes/edges.

## Tips for Large Datasets

- **Parallelization**: Use the `ncores` argument in `run_scistree` or `perform_nni` to utilize multiple CPU cores.
- **Initialization**: UPGMA is generally faster for initial tree construction on very large matrices compared to Neighbor-Joining (NJ).
- **Memory**: For >10,000 cells, ensure the system has sufficient RAM as the genotype matrix and distance calculations can be memory-intensive.

## Reference documentation

- [Package ‘scistreer’](./references/reference_manual.md)