---
name: bioconductor-treekor
description: treekoR identifies associations between cell subpopulations and clinical outcomes by analyzing single-cell cytometry data through hierarchical tree structures. Use when user asks to derive cluster hierarchies, perform significance testing on cell proportions relative to total or parent populations, and generate interactive visualizations of tree-based clinical correlations.
homepage: https://bioconductor.org/packages/release/bioc/html/treekoR.html
---


# bioconductor-treekor

name: bioconductor-treekor
description: Analyze single-cell cytometry data using hierarchical tree structures to find associations between cell subpopulations and clinical outcomes. Use when Claude needs to perform significance testing on cell cluster proportions (both %total and %parent), construct cluster hierarchies using HOPACH or hclust, and generate interactive visualizations or extract features for machine learning.

# bioconductor-treekor

## Overview

treekoR is a framework for identifying robust and interpretable associations between cell subsets and patient clinical endpoints. It utilizes the hierarchical nature of single-cell data by:
1. Deriving a tree structure of cell clusters.
2. Measuring proportions relative to the total population (%total) and relative to the immediate parent node (%parent).
3. Performing significance testing to correlate these proportions with clinical outcomes.

## Typical Workflow

### 1. Data Preparation
Ensure you have the following components:
- `exprs`: Matrix of marker expressions (cells x markers).
- `clusters`: Vector of cluster assignments for each cell.
- `classes`: Vector of clinical outcomes/conditions for each cell.
- `samples`: Vector of sample/patient IDs for each cell.

```r
library(treekoR)
library(SingleCellExperiment)

# Example using SingleCellExperiment
exprs <- t(assay(sce, "exprs"))
clusters <- colData(sce)$cluster_id
classes <- colData(sce)$condition
samples <- colData(sce)$sample_id
```

### 2. Construct Cluster Hierarchy
Use `getClusterTree` to build the tree. The default method is `hopach`, but any `hclust` method (e.g., "average", "complete", "ward.D2") is supported.

```r
clust_tree <- getClusterTree(exprs, 
                             clusters, 
                             hierarchy_method = "hopach")
```

### 3. Significance Testing
Use `testTree` to calculate p-values for both %total and %parent proportions.

```r
# Default t-test
tested_tree <- testTree(phylo = clust_tree$clust_tree,
                        clusters = clusters,
                        samples = samples,
                        classes = classes)

# Using edgeR for count-based modeling
tested_tree_edgeR <- testTree(clust_tree$clust_tree,
                              clusters = clusters,
                              samples = samples,
                              classes = classes,
                              sig_test = "edgeR")
```

### 4. Extract and Interpret Results
Extract a dataframe of results including test statistics and p-values for each node.

```r
res_df <- getTreeResults(tested_tree)
# Columns: node, parent, isTip, clusters, stat_total, stat_parent, pval_total, pval_parent
```

### 5. Visualization
Generate an interactive heatmap that displays the tree (colored by test statistics) alongside marker expression.

```r
plotInteractiveHeatmap(tested_tree,
                       clust_med_df = clust_tree$median_freq,
                       clusters = clusters)
```

### 6. Feature Extraction
Extract proportions or geometric means for downstream analysis or machine learning.

```r
# Proportions (%total and %parent)
prop_df <- getCellProp(phylo = clust_tree$clust_tree,
                       clusters = clusters,
                       samples = samples,
                       classes = classes)

# Geometric means of markers per cluster per sample
means_df <- getCellGMeans(clust_tree$clust_tree,
                          exprs = exprs,
                          clusters = clusters,
                          samples = samples,
                          classes = classes)
```

## Tips and Best Practices
- **%parent vs %total**: %total identifies overall changes in abundance, while %parent can pinpoint specific branches where a subpopulation diverges from its lineage, providing higher resolution.
- **Hierarchy Methods**: If `hopach` is too slow for very large datasets, consider using `hierarchy_method = "average"`.
- **Significance Tests**: Use `sig_test = "GLMM"` or `"edgeR"` when dealing with complex experimental designs or when count-based modeling is preferred over t-tests.
- **Interactive Plots**: The `plotInteractiveHeatmap` function uses `ggiraph`; ensure your environment supports interactive HTML widgets to view the output.

## Reference documentation
- [treekoR Vignette](./references/vignette.md)