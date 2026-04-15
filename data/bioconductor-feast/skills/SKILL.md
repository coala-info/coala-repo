---
name: bioconductor-feast
description: FEAST selects the most informative genes for single-cell RNA-seq data to improve the accuracy of downstream cell clustering. Use when user asks to perform feature selection for scRNA-seq, rank genes by their ability to distinguish cell populations, or optimize gene sets for clustering algorithms like SC3 and TSCAN.
homepage: https://bioconductor.org/packages/release/bioc/html/FEAST.html
---

# bioconductor-feast

## Overview
FEAST (FEAture SelecTion) is a Bioconductor package designed to improve scRNA-seq clustering by selecting the most informative genes before the clustering process. Unlike unsupervised methods based solely on statistical moments, FEAST uses a consensus clustering approach followed by F-statistics to rank genes by their ability to distinguish cell populations. It integrates well with established clustering algorithms like SC3 and TSCAN.

## Installation
```r
if(!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("FEAST")
library(FEAST)
```

## Core Workflow

### 1. Data Preparation
FEAST requires a count matrix (genes as rows, cells as columns) and the expected number of clusters `k`.
```r
# Preprocess to filter genes based on dropout rates
# Y is a count matrix; thre is the zero-expression threshold
Y_processed = process_Y(Y, thre = 2)
```

### 2. Feature Selection (The FEAST Algorithm)
The simplest way to get gene rankings is using the wrapper functions.
```r
# Standard version for small/medium datasets
ixs = FEAST(Y_processed, k = k)

# Fast version for large datasets (> 2000 cells)
# Use dim_reduce = "irlba" for efficiency
ixs = FEAST_fast(Y_processed, k = k, dim_reduce = "irlba")

# For extremely large datasets (> 5000 cells), use split mode
ixs = FEAST_fast(Y_processed, k = k, split = TRUE, batch_size = 1000)
```

### 3. Step-by-Step Manual Analysis
For more control, you can run the underlying steps individually:
```r
# Step A: Consensus clustering to get initial labels
con_res = Consensus(Y_processed, k = k)

# Step B: Calculate gene-level significance using F-statistics
F_res = cal_F2(Y_processed, con_res$cluster)

# Step C: Rank genes (decreasing F-score)
ixs = order(F_res$F_scores, decreasing = TRUE)
```

### 4. Validation and Model Selection
FEAST provides tools to determine the optimal number of top features (e.g., top 500 vs 1000) by calculating the Mean Squared Error (MSE).
```r
# Automated model selection using TSCAN or SC3
mod_res = Select_Model_short_TSCAN(Y_processed, cluster = con_res$cluster, top = c(500, 1000, 2000))

# Visualize the MSE vs Accuracy trend
library(ggpubr)
res_plot = Visual_Rslt(model_cv_res = mod_res, trueclass = trueclass)
print(res_plot$ggobj)
```

## Key Functions
- `FEAST()` / `FEAST_fast()`: Main wrappers to return ranked gene indices.
- `process_Y()`: Filters genes based on dropout/zero-expression rates.
- `Consensus()`: Performs initial clustering to provide labels for F-statistics.
- `cal_MSE()`: Evaluates the quality of a feature set based on the average distance between cells and cluster centers.
- `SC3_Clust()` / `TSCAN_Clust()`: Embedded wrappers for running these specific clustering algorithms within the FEAST workflow.

## Tips
- **Input Matrix**: While FEAST can take normalized matrices, it is optimized for count matrices where it can perform its own dropout-based filtering via `process_Y`.
- **Choosing K**: The number of clusters `k` is a required input. If unknown, estimate it using prior biological knowledge or tools like `SC3`'s estimation function.
- **Memory Management**: For datasets with more than 2,000 cells, always prefer `FEAST_fast` with `irlba` to avoid memory bottlenecks during dimension reduction.

## Reference documentation
- [The FEAST User's Guide](./references/FEAST.md)
- [FEAST Vignette Source](./references/FEAST.Rmd)