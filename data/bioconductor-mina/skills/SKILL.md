---
name: bioconductor-mina
description: The mina package performs microbial community profiling by integrating diversity analysis with co-occurrence network inference and statistical comparison. Use when user asks to normalize ASV tables, calculate beta-diversity, identify network clusters, or compare ecological network topologies across different conditions.
homepage: https://bioconductor.org/packages/release/bioc/html/mina.html
---

# bioconductor-mina

## Overview
The `mina` package is designed for microbial community profiling analysis. It extends traditional composition-based diversity analysis by incorporating higher-order community structures (network clusters) and providing a robust statistical framework for comparing ecological networks across different conditions.

## Core Workflow

### 1. Data Import and Preparation
`mina` uses a custom S4 object to manage quantitative (ASV/OTU) and descriptive (metadata) tables.
- **Requirement**: The descriptive table must have a `Sample_ID` column.
- **Quantitative table**: Rows are taxa (ASVs/OTUs), columns are samples.

```r
library(mina)
# Create object
maize <- new("mina", tab = maize_asv, des = maize_des)

# Tidy data (ensure samples match between tables)
maize <- fit_tabs(maize)
```

### 2. Normalization and Diversity
Before analysis, normalize data to account for sequencing depth.
- **Methods**: `total` (sum normalization), `raref` (rarefaction).
- **Beta-diversity**: Calculate distance matrices (e.g., Bray-Curtis, TINA).

```r
# Normalization
maize <- norm_tab(maize, method = "raref", depth = 5000, multi = 9)

# Calculate Dissimilarity
maize <- com_dis(maize, method = "bray")

# Evaluate unexplained variance (R2)
com_r2(maize, group = c("Compartment", "Soil"))
```

### 3. Visualization
Use PCoA for beta-diversity visualization.
```r
maize <- dmr(maize) # Dimensionality reduction
com_plot(maize, match = "Sample_ID", color = "Compartment", shape = "Soil")
```

### 4. Network Inference and Clustering
Infers co-occurrence networks and identifies modules (clusters) of interacting taxa.
- **Adjacency**: `pearson` or `spearman`.
- **Clustering**: `mcl` (Markov Cluster Algorithm) or `ap` (Affinity Propagation).

```r
# Generate adjacency matrix
maize <- adj(maize, method = "spearman", sig = TRUE)

# Cluster the network
maize <- net_cls(maize, method = "mcl", cutoff = 0.6)

# Create higher-order feature table (summing abundances by cluster)
maize <- net_cls_tab(maize)
```

### 5. Statistical Network Comparison
Compare networks between groups using bootstrap-permutation to test for significant differences in network topology.
- **Distance Methods**: `spectra` (eigenvalue-based) or `Jaccard`.

```r
# Bootstrap and permutation
maize <- bs_pm(maize, group = "Compartment", bs = 11, pm = 11)

# Calculate network distance and significance
maize <- net_dis(maize, method = "spectra")
dis_stat(maize) # View results
```

## Tips for Success
- **Filtering**: For large datasets, use `per` (occupancy threshold) in `bs_pm` to filter rare taxa, as network comparison is computationally intensive.
- **TINA**: For the TINA dissimilarity (Schmidt et al. 2017), use the `tina()` function directly if you need custom correlation or similarity parameters.
- **Parallelization**: Functions like `tina()` support a `threads` argument for faster computation on large matrices.

## Reference documentation
- [Microbial dIversity and Network Analysis with mina](./references/mina.Rmd)
- [Microbial dIversity and Network Analysis with mina (Markdown)](./references/mina.md)