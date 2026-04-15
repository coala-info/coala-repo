---
name: bioconductor-netboost
description: The netboost package performs dimension reduction on high-dimensional biological data by identifying feature modules through boosting-based network filtering and topological overlap measures. Use when user asks to identify gene modules, reduce data dimensionality using principal components, or transfer clustering models to new datasets.
homepage: https://bioconductor.org/packages/release/bioc/html/netboost.html
---

# bioconductor-netboost

## Overview

The `netboost` package implements a sophisticated dimension reduction technique designed for high-dimensional biological data. It identifies "modules" of features (like genes or CpG sites) by combining boosting-based network filtering with the Topological Overlap Measure (TOM). The workflow reduces thousands of features into a manageable set of aggregate measures (Principal Components) that represent the underlying biological signals.

## Core Workflow

### 1. Data Preparation
Data should be a numeric matrix or data frame where rows are samples and columns are features.

```r
library(netboost)
# Example data: 80 patients x 500 features
data("tcga_aml_meth_rna_chr18", package = "netboost")
datan <- tcga_aml_meth_rna_chr18
```

### 2. Integrated Analysis
The `netboost()` function is the primary interface. It performs filtering, clustering, and PC extraction in one call.

```r
results <- netboost(
  datan = datan,
  stepno = 20L,           # Number of boosting steps
  soft_power = 3L,        # Exponent for correlation transformation (NULL for auto)
  min_cluster_size = 10L, # Minimum features per module
  n_pc = 2,               # Max principal components to compute per module
  scale = TRUE,           # Scale/center data
  ME_diss_thres = 0.25    # Threshold for merging similar clusters
)
```

### 3. Interpreting Results
The output object contains several key components:
- `results$MEs`: The aggregated dataset (Module Eigengenes). Columns named `ME[Module]_pc[N]`.
- `results$colors`: Numeric vector assigning each feature to a module (0 is background/unassigned).
- `results$names`: Feature names corresponding to the color assignments.
- `results$var_explained`: Matrix showing variance explained by each PC for each module.

To list features belonging to a specific module (e.g., Module 8):
```r
module_8_features <- results$names[results$colors == 8]
```

### 4. Visualization
Generate a dendrogram showing the hierarchical structure and module assignments.

```r
nb_plot_dendro(nb_summary = results, labels = FALSE, colorsrandom = TRUE)
```

### 5. Transferring Clusters
You can apply a clustering model derived from one dataset to a new, independent dataset.

```r
new_MEs <- nb_transfer(nb_summary = results, new_data = test_data, scale = TRUE)
```

## Advanced Options

### Non-parametric Analysis
For data that does not follow a normal distribution, use Spearman correlation and robust PCs:
```r
results <- netboost(
  datan = datan,
  filter_method = "spearman",
  method = "spearman",
  robust_PCs = TRUE,
  cores = 4L # Parallel execution
)
```

## Tips for Success
- **Background Noise**: Features not assigned to any module are placed in "Module 0". High percentages of features in Module 0 may suggest a need to lower `min_cluster_size` or increase `stepno`.
- **Scaling**: Always set `scale = TRUE` unless your data is already pre-processed and normalized for variance.
- **Memory/Speed**: For very large datasets, utilize the `cores` argument to enable parallel processing.

## Reference documentation
- [The Netboost users guide](./references/netboost.md)