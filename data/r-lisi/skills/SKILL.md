---
name: r-lisi
description: The r-lisi package computes the Local Inverse Simpson's Index to quantify the mixing of categorical labels in high-dimensional biological data. Use when user asks to evaluate data integration success, calculate neighborhood mixing scores, or assess batch effect correction in single-cell datasets.
homepage: https://cran.r-project.org/web/packages/lisi/index.html
---

# r-lisi

## Overview
The `lisi` package provides tools to quantify the mixing of categorical labels in a local neighborhood around each cell in high-dimensional space. It is widely used in single-cell genomics to evaluate the success of data integration (e.g., after using Harmony). A high LISI score (approaching the number of categories) indicates good mixing, while a score near 1 indicates that a neighborhood is dominated by a single category.

## Installation
Install the package from GitHub using `devtools`:

```R
# install.packages("devtools")
devtools::install_github("immunogenomics/lisi")
```

## Core Workflow

### 1. Prepare Input Data
LISI requires two primary inputs:
- **Coordinates Matrix (`X`)**: A matrix where rows are cells and columns are coordinates (e.g., PCA scores, UMAP, or tSNE embeddings).
- **Metadata (`meta_data`)**: A data frame where rows are cells and columns are categorical variables to evaluate.

### 2. Compute LISI Scores
Use the `compute_lisi` function to calculate scores for specific categorical columns.

```R
library(lisi)

# X: Matrix of PCA coordinates
# meta_data: Data frame with columns 'batch' and 'technology'
res <- compute_lisi(X, meta_data, c('batch', 'technology'))

# The result is a data frame with the same number of rows as X
head(res)
```

### 3. Interpret Results
- **Score Range**: 1 to $N$, where $N$ is the number of categories in the variable.
- **Interpretation**: A score of 2 for a "batch" variable with 2 batches means the local neighborhood of that cell is perfectly mixed between both batches. A score of 1 means the neighborhood contains only one batch.

## Parameters and Tuning
- `perplexity`: Controls the effective neighborhood size (default is 30). Similar to t-SNE, this affects how many neighbors influence the local index.
- `label_colnames`: A character vector specifying which columns in `meta_data` to compute LISI for.

## Tips for Single-Cell Analysis
- **Integration Evaluation**: Run LISI before and after integration. An increase in LISI scores for "batch" or "dataset" labels suggests improved integration.
- **Biological Preservation**: You can also compute LISI for "cell_type" labels. In this case, you generally want LISI scores to remain low (near 1), indicating that cell types remain distinct and are not over-mixed during integration.

## Reference documentation
- [README.Rmd](./references/README.Rmd.md)
- [README.md](./references/README.md)
- [Articles](./references/articles.md)
- [Home Page](./references/home_page.md)