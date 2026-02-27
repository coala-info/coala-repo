---
name: bioconductor-tscan
description: TSCAN performs pseudotime analysis on single-cell RNA-seq data to reconstruct cellular trajectories using Traveling Salesman Problem algorithms. Use when user asks to preprocess single-cell data, cluster cells, construct pseudotime trajectories, or identify genes with differential expression along a path.
homepage: https://bioconductor.org/packages/release/bioc/html/TSCAN.html
---


# bioconductor-tscan

name: bioconductor-tscan
description: Tools for Single-Cell ANalysis (TSCAN). Use this skill to perform pseudotime analysis on single-cell RNA-seq data, including preprocessing, clustering, trajectory construction using Traveling Salesman Problem (TSP) algorithms, and differential expression testing along the pseudotime path.

## Overview
TSCAN (Tools for Single-Cell ANalysis) is a Bioconductor package designed to reconstruct the differentiation lineage of single cells and order them along a "pseudotime" trajectory. Unlike methods that use Minimum Spanning Trees (MST) exclusively, TSCAN utilizes a Traveling Salesman Problem (TSP) approach on cluster centroids to find the shortest path through cellular states. It includes a preprocessing pipeline, model-based clustering, and tools for identifying genes that change significantly across the reconstructed trajectory.

## Typical Workflow

### 1. Data Preprocessing
Filter out lowly expressed or non-variable genes. By default, `preprocess` log2-transforms the data (with a pseudocount of 1) and filters genes based on expression frequency and coefficient of variation.

```r
library(TSCAN)
# lpsdata is a matrix of raw expression values
procdata <- preprocess(lpsdata)
```

### 2. Clustering and Dimension Reduction
TSCAN uses Principal Component Analysis (PCA) followed by model-based clustering to group cells into states.

```r
# Perform PCA and clustering
lpsmclust <- exprmclust(procdata)

# Visualize the clusters and the initial MST
plotmclust(lpsmclust)
```

### 3. Constructing Pseudotime Ordering
The `TSCANorder` function determines the cell sequence. You can manually specify the path or use marker genes to orient the trajectory.

```r
# Get default ordering
lpsorder <- TSCANorder(lpsmclust)

# Get ordering with specific cluster sequence (e.g., starting at cluster 1, then 2, then 3)
lpsorder_custom <- TSCANorder(lpsmclust, MSTorder = c(1, 2, 3))

# Flip the order if the biological direction is reversed
lpsorder_flipped <- TSCANorder(lpsmclust, flip = TRUE)
```

### 4. Differential Expression Testing
Identify genes that vary significantly along the pseudotime path using Generalized Additive Models (GAM).

```r
# Test for genes changing over pseudotime
diffval <- difftest(procdata, lpsorder)

# Filter for significant genes (q-value < 0.05)
sig_genes <- row.names(diffval)[diffval$qval < 0.05]
```

### 5. Visualization
Plot the expression of specific genes against the calculated pseudotime.

```r
# Prepare expression data for a specific gene
gene_expr <- log2(lpsdata["STAT2", ] + 1)

# Plot expression vs pseudotime
# Note: orderonly=FALSE returns pseudotime values instead of just the cell names
singlegeneplot(gene_expr, TSCANorder(lpsmclust, orderonly = FALSE))
```

## Tips and Best Practices
- **Starting Points**: TSP and MST algorithms do not inherently know the "start" of a biological process. Use known marker genes to determine which end of the trajectory represents the initial state.
- **POS (Pseudotemporal Ordering Score)**: Use `orderscore()` to quantitatively compare different pseudotime constructions if you have sub-population/label information.
- **Input Formats**: While TSCAN works with standard matrices, it is often used within the `SingleCellExperiment` ecosystem. Ensure your input to `preprocess` is a matrix of expression values (rows=genes, columns=cells).
- **GUI**: TSCAN includes a Shiny app (`TSCANui()`) for interactive exploration, though programmatic use via the functions above is preferred for reproducible pipelines.

## Reference documentation
- [TSCAN](./references/TSCAN.md)