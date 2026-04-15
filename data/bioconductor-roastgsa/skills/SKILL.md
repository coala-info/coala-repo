---
name: bioconductor-roastgsa
description: This package performs rotation-based gene set analysis using linear models to evaluate enrichment in complex experimental designs. Use when user asks to perform gene set enrichment analysis, run competitive or self-contained gene set tests, or calculate single-sample enrichment scores.
homepage: https://bioconductor.org/packages/release/bioc/html/roastgsa.html
---

# bioconductor-roastgsa

## Overview
The `roastgsa` package implements rotation-based methods for gene set analysis, extending the functionality of `limma::roast` and `limma::romer`. It allows for complex experimental designs by using linear models and provides a variety of statistics (maxmean, absmean, mean, mean.rank, and KS-based scores) to evaluate gene set enrichment. It is particularly robust for experiments with small sample sizes where traditional permutation-based methods (like GSEA) may lack power.

## Installation
```R
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("roastgsa")
library(roastgsa)
```

## Core Workflow

### 1. Data Preparation
Data must be approximately normally distributed.
- **Microarrays:** Use quantile normalization (e.g., `preprocessCore::normalize.quantiles`).
- **RNA-seq:** Use `vst` or `rlog` from `DESeq2`, or `voom` from `limma` before analysis.
- **Filtering:** Remove low-expressed genes to improve statistical power.

### 2. Model Specification
Define the experimental design using a formula and a contrast.
```R
# Example: Comparing Group 1 vs Group 0 while adjusting for Block
form <- as.formula("~ BLOCK + GROUP")
design <- model.matrix(form, data = covar_df)

# Contrast can be a column name, index, or numeric vector
contrast <- "GROUP1" 
```

### 3. Running roastgsa
The main function `roastgsa` performs the enrichment test.
```R
fit <- roastgsa(
    y = expression_matrix, 
    form = form, 
    covar = covar_df,
    contrast = contrast, 
    index = gene_sets_list,   # List of gene identifiers
    nrot = 500,               # Number of rotations
    set.statistic = "maxmean", # Options: "maxmean", "mean", "mean.rank", "absmean"
    self.contained = FALSE    # FALSE for competitive, TRUE for self-contained
)

# View results
head(fit$res)
```

### 4. Visualization
`roastgsa` provides specialized plotting functions for results.
- **Standard GSA Plots:** Show moderated t-statistics and barcode plots.
  ```R
  plot(fit, type = "stats", whplot = 1) # whplot is index or name of gene set
  plot(fit, type = "GSEA", whplot = 1)
  ```
- **Heatmaps:** Visualize gene-level variation across samples within a set.
  ```R
  heatmaprgsa_hm(fit, expression_matrix, intvar = "GROUP", whplot = 1)
  ```

### 5. Single Sample GSA (ssGSA)
Calculate per-sample enrichment scores.
```R
# method can be "GScor" (recommended for small N) or "GSadj" (N > 50)
ss_res <- ssGSA(expression_matrix, obj = fit, method = "GScor")
plot(ss_res, orderby = covar_df$GROUP, whplot = 1)
```

## Key Parameters and Tips
- **set.statistic:** 
  - `maxmean`: Recommended for maximizing power (directional).
  - `mean.rank`: Robust non-parametric alternative.
  - `mean`: Good for "democratic" sets where both up and down regulation are balanced.
- **Competitive vs Self-contained:** Use `self.contained = FALSE` (competitive) to compare a gene set against the background of all other genes. Use `TRUE` to test if the gene set is simply differentially expressed regardless of the rest of the genome.
- **Gene Identifiers:** Ensure the identifiers in your `index` (gene sets) match the rownames of your expression matrix (e.g., Symbols or Entrez IDs).

## Reference documentation
- [roastgsa vignette (RNAseq)](./references/roastgsaExample_RNAseq.md)
- [roastgsa vignette (gene set collections)](./references/roastgsaExample_genesetcollections.md)
- [roastgsa vignette (main)](./references/roastgsaExample_main.md)