---
name: r-fastbaps
description: The r-fastbaps package performs fast hierarchical Bayesian analysis of population structure to cluster large genomic datasets. Use when user asks to cluster genetic sequences, perform population structure analysis, partition phylogenetic trees, or optimize Dirichlet prior hyperparameters for genomic data.
homepage: https://cran.r-project.org/web/packages/fastbaps/index.html
---

# r-fastbaps

name: r-fastbaps
description: Fast hierarchical Bayesian analysis of population structure (BAPS) for clustering genetic data. Use when Claude needs to perform population structure analysis, cluster genetic sequences (FASTA), or partition phylogenetic trees using Dirichlet Process Mixture models (DPM).

# r-fastbaps

## Overview
The `fastbaps` package provides a fast approximation to a Dirichlet Process Mixture model (DPM) for clustering genetic data. It implements hierarchical Bayesian clustering (BHC) optimized for large genomic datasets, capable of handling thousands of sequences and hundreds of thousands of SNPs. It can be used to cluster sequences from scratch or to partition an existing phylogenetic tree.

## Installation
To install the package from CRAN:
```R
install.packages("fastbaps")
```
For the development version:
```R
# install.packages("devtools")
devtools::install_github("gtonkinhill/fastbaps")
```

## Core Workflow

### 1. Data Import
Load a FASTA file into a sparse matrix format.
```R
library(fastbaps)
fasta.file <- "path/to/sequences.fa"
sparse.data <- import_fasta_sparse_nt(fasta.file)
```

### 2. Prior Optimization
Choose and optimize the Dirichlet prior hyperparameters. Options include `symmetric`, `baps`, `optimised.symmetric`, and `optimised.baps`.
```R
sparse.data <- optimise_prior(sparse.data, type = "optimise.symmetric")
```

### 3. Clustering
Run the fast BAPS algorithm to generate a hierarchical clustering object.
```R
baps.hc <- fast_baps(sparse.data)
```

### 4. Partitioning
Find the best partition of the hierarchy that maximizes the BAPS likelihood.
```R
# Using the generated BHC
best.partition <- best_baps_partition(sparse.data, baps.hc)

# Or partitioning an existing tree (ape phylo object)
library(ape)
tree <- read.tree("my_tree.nwk")
tree.rooted <- phytools::midpoint.root(tree)
tree.partition <- best_baps_partition(sparse.data, tree.rooted)
```

## Advanced Features

### Multi-resolution Clustering
Run the algorithm across multiple levels of granularity.
```R
multi.res <- multi_res_baps(sparse.data)
# Access levels via multi.res$`Level 1`, multi.res$`Level 2`, etc.
```

### Bootstrap Stability
Assess the stability of inferred clusters using bootstrapping.
```R
boot.result <- boot_fast_baps(sparse.data)
```

## Tips for Success
- **k.init**: When running `fast_baps`, the default `k.init` is `n.seqs / 4`. If you expect a very high number of clusters, increase this value.
- **Tree Partitioning**: If you already have a high-quality phylogeny (e.g., from IQ-TREE), using `best_baps_partition` directly on the rooted tree is often more biologically meaningful than clustering from SNPs alone.
- **Visualization**: Use `ggtree` to plot the resulting partitions alongside your phylogeny for interpretation.

## Reference documentation
- [LICENSE.md](./references/LICENSE.md)
- [README.Rmd.md](./references/README.Rmd.md)
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)