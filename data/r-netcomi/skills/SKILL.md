---
name: r-netcomi
description: NetCoMi provides a comprehensive workflow for the construction, analysis, and comparison of microbial association networks from compositional microbiome data. Use when user asks to construct microbial networks, handle compositional data normalization, compute associations using methods like SPIEC-EASI or SPRING, or compare network topologies between experimental groups.
homepage: https://cran.r-project.org/web/packages/netcomi/index.html
---

# r-netcomi

name: r-netcomi
description: Construction, analysis, and comparison of microbial association networks from compositional data (e.g., 16S rRNA sequencing). Use when Claude needs to perform microbial network analysis, handle compositional data normalization, compute associations (SPIEC-EASI, SPRING, etc.), or compare network topologies between two experimental groups.

# r-netcomi

## Overview
NetCoMi (Network Construction and Comparison for Microbiome Data) provides a comprehensive workflow for microbial network analysis. It addresses the challenges of compositional data (sparsity, relative abundance) by offering modular tools for data preprocessing, association estimation, network sparsification, and statistical comparison of network properties between groups.

## Installation
```R
install.packages("devtools")
install.packages("BiocManager")

# Install required dependencies from GitHub
devtools::install_github("zdk123/SpiecEasi")
devtools::install_github("GraceYoon/SPRING")

# Install NetCoMi
devtools::install_github("stefpeschel/NetCoMi", 
                         repos = c("https://cloud.r-project.org/", 
                                   BiocManager::repositories()))

# Install optional packages for specific methods
NetCoMi::installNetCoMiPacks()
```

## Core Workflow

### 1. Network Construction
Use `netConstruct()` to build networks from a count matrix.
- **Methods**: `pearson`, `spearman`, `bicor`, `sparcc`, `spieceasi`, `spring`.
- **Normalization**: `clr` (centered log-ratio), `vst`, `tss`.
- **Zero handling**: `multRepl`, `bayes-laplace`.

```R
# Example: Constructing two networks for comparison
net_output <- netConstruct(data = count_matrix,
                           group = group_vector,
                           measure = "spring",
                           normMethod = "none", # SPRING handles its own
                           zeroMethod = "none",
                           sparsMethod = "threshold",
                           thresh = 0.3)
```

### 2. Network Analysis
Use `netAnalyze()` to calculate centrality measures and cluster nodes.
- **Centralities**: Degree, Betweenness, Closeness, Eigenvector.
- **Clustering**: `cluster_fast_greedy`, `cluster_louvain`, `cluster_walktrap`.

```R
analyzed_net <- netAnalyze(net_output, 
                           centrLCC = TRUE, 
                           clustering = TRUE)
```

### 3. Network Comparison
Use `netCompare()` for quantitative comparison of network properties using permutation tests.

```R
comp_net <- netCompare(analyzed_net, permTest = TRUE, nPerm = 1000)
summary(comp_net)
```

### 4. Visualization
Use `plot.microNetProps()` to visualize networks.
- **Layouts**: `spring`, `circle`, `mds`.
- **Comparison**: Use `sameLayout = TRUE` to compare two groups visually.

```R
plot(analyzed_net, 
     sameLayout = TRUE, 
     nodeColor = "cluster", 
     nodeSize = "degree",
     title1 = "Group A", 
     title2 = "Group B")
```

## Differential Networks
Construct networks where edges represent significantly different associations between groups using `diffNet()`.

## Tips for Success
- **Compositionality**: Always use appropriate transformations (like CLR) when using correlation-based measures (Pearson/Spearman) on microbiome data.
- **Sparsity**: For high-dimensional data with many zeros, `SPRING` or `SPIEC-EASI` are generally preferred over standard correlations.
- **Memory**: Permutation tests in `netCompare()` can be computationally intensive; start with a low `nPerm` (e.g., 100) to test code before running full analyses.

## Reference documentation
- [NEWS.md](./references/NEWS.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)
- [index.md](./references/index.md)
- [readme.Rmd.md](./references/readme.Rmd.md)
- [readme.md](./references/readme.md)