---
name: bioconductor-omicrexposome
description: This tool performs association and integration analyses between environmental exposure data and various omic data-sets. Use when user asks to perform association studies between exposures and molecular features, integrate multiple data layers using MCIA or MCCA, or visualize results through Manhattan and volcano plots.
homepage: https://bioconductor.org/packages/release/bioc/html/omicRexposome.html
---

# bioconductor-omicrexposome

name: bioconductor-omicrexposome
description: Integration and association analysis between exposome data and omic data-sets (transcriptomics, proteomics, methylomics). Use when Claude needs to perform association studies using limma-based pipelines or multi-omic integration using Multiple Co-inertia Analysis (MCIA) or Multi Canonical Correlation Analysis (MCCA).

# bioconductor-omicrexposome

## Overview
The `omicRexposome` package facilitates the study of relationships between environmental exposures (the exposome) and molecular signatures (omics). It provides two primary analytical frameworks:
1. **Association Studies**: Testing the relationship between a single exposure and a single omic feature (e.g., gene expression, protein level) using linear models.
2. **Integration Analysis**: Finding latent relationships across multiple data-sets simultaneously using multivariate techniques.

## Core Workflow

### 1. Data Preparation
All analyses require data encapsulated in a `MultiDataSet` object. This object must contain at least one `ExposomeSet` and one or more omic sets (e.g., `ExpressionSet`, `SummarizedExperiment`).

```r
library(omicRexposome)
library(MultiDataSet)

# Create MultiDataSet and add data
mds <- createMultiDataSet()
mds <- add_exp(mds, exposome_set)
mds <- add_genexp(mds, expression_set)
```

### 2. Association Analysis
Use the `association` function to perform screening. It uses `limma` internally.

```r
# Basic association adjusted for covariates
res <- association(
    object = mds,
    formula = ~Sex + Age,
    expset = "exposures",
    omicset = "expression",
    method = "ls",      # "ls" for least squares or "robust"
    sva = "fast"        # "fast" (SmartSVA), "slow" (sva), or "none"
)
```

### 3. Integration Analysis
Use `crossomics` to find common structures across multiple data layers.

```r
# Multiple Co-inertia Analysis (MCIA)
res_mcia <- crossomics(mds, method = "mcia")

# Multi Canonical Correlation Analysis (MCCA)
res_mcca <- crossomics(mds, method = "mcca", permute = c(4, 2))
```
*Note: Integration methods require data with no missing values. Use `rexposome::imputation()` on the ExposomeSet before integration.*

## Interpreting Results

### Summary Tables
Extract hits and genomic inflation factors (lambda) from `ResultSet` objects.

```r
# Count features below a p-value threshold
hits <- tableHits(res, th = 0.001)

# Calculate lambda scores to check for inflation/deflation
lambdas <- tableLambda(res)
```

### Visualization
`omicRexposome` provides specialized plotting functions for `ResultSet` objects.

*   **Association Plots**:
    *   `plotAssociation(res, rid = "ExposureName", type = "qq")`: Quantile-Quantile plot.
    *   `plotAssociation(res, rid = "ExposureName", type = "volcano")`: Volcano plot.
    *   `plotAssociation(res, rid = "ExposureName", type = "manhattan")`: Manhattan plot.
    *   `plotAssociation(res, rid = "ExposureName", type = "protein")`: Specific plot for proteomic data.

*   **Integration Plots**:
    *   `plotIntegration(res_mcia)`: Shows sample space, feature space, inertia, and data-set behavior.
    *   `plotIntegration(res_mcca)`: Generates a radar plot showing feature clustering across quadrants.

## Tips for Success
*   **Formula Syntax**: The `formula` argument in `association` should only contain covariates (e.g., `~Age + Sex`). The function automatically prepends the exposure variables.
*   **SVA**: If `tableLambda` shows values significantly different from 1, re-run `association` with `sva = "fast"` to account for hidden batch effects or surrogate variables.
*   **Sample Matching**: `MultiDataSet` automatically handles sample intersection. Ensure your sample IDs match across the exposome and omic data-sets.

## Reference documentation
- [Exposome Data Integration with Omic Data](./references/exposome_omic_integration.md)