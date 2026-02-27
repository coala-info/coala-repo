---
name: bioconductor-nbamseq
description: NBAMSeq performs differential expression analysis of RNA-Seq data using Negative Binomial Additive Models to capture non-linear relationships. Use when user asks to model non-linear associations between gene expression and continuous covariates, perform differential expression analysis with smooth functions, or visualize non-linear gene expression trends.
homepage: https://bioconductor.org/packages/release/bioc/html/NBAMSeq.html
---


# bioconductor-nbamseq

name: bioconductor-nbamseq
description: Differential expression analysis of RNA-Seq data using Negative Binomial Additive Models (NBAM). Use this skill when you need to model non-linear associations between gene expression and continuous covariates, or when standard linear models (like DESeq2 or edgeR) are insufficient for capturing complex biological trends.

## Overview

NBAMSeq is a Bioconductor package designed for differential expression (DE) analysis of RNA-Seq count data. Its primary strength is the integration of Generalized Additive Models (GAMs) with the Negative Binomial distribution. This allows researchers to model covariates using smooth functions (splines), which is particularly useful for time-series data, developmental trajectories, or any continuous phenotype where the relationship with gene expression is not strictly linear. It employs a Bayesian shrinkage approach for variance estimation to share information across genes.

## Core Workflow

### 1. Data Preparation
You must provide three components: a count matrix, sample metadata (colData), and a design formula.

```r
library(NBAMSeq)

# countData: matrix with genes as rows, samples as columns
# colData: data.frame with sample covariates
# design: formula using s() for non-linear terms

# Example: Modeling 'age' as non-linear and 'treatment' as linear
design <- ~ s(age) + treatment

gsd <- NBAMSeqDataSet(countData = countData, 
                      colData = colData, 
                      design = design)
```

### 2. Running the Analysis
The `NBAMSeq()` function performs the model fitting and dispersion estimation.

```r
# Standard execution
gsd <- NBAMSeq(gsd)

# Parallel execution for large datasets
library(BiocParallel)
gsd <- NBAMSeq(gsd, parallel = TRUE)
```

### 3. Extracting Results
Use the `results()` function. The arguments differ based on the type of covariate.

*   **Non-linear Continuous Covariates:** Specify the `name`. Returns Effective Degrees of Freedom (edf) instead of log2FoldChange.
    ```r
    res_age <- results(gsd, name = "age")
    ```
*   **Linear Continuous Covariates:** Specify the `name`. Returns coefficients and standard errors.
    ```r
    res_var <- results(gsd, name = "variable1")
    ```
*   **Discrete/Factor Covariates:** Use the `contrast` argument.
    ```r
    # Compare treatment level 'A' vs 'B'
    res_treat <- results(gsd, contrast = c("treatment", "A", "B"))
    ```

## Visualization

NBAMSeq provides a specific function to visualize the fitted smooth curves for individual genes.

```r
# Visualize the non-linear trend for a specific gene and phenotype
makeplot(gsd, phenoname = "age", genename = "ENSG000001", main = "Gene Trend")
```

## Key Considerations

*   **Design Formula Requirements:** At least one non-linear covariate (wrapped in `s()`) must be provided. If all relationships are linear, use DESeq2 or edgeR instead.
*   **Discrete Variables:** Factors or discrete variables cannot be wrapped in `s()`.
*   **Smoothing Control:** The `gamma` parameter in `NBAMSeq()` (default 2.5) controls the wiggliness of the fit. Higher values result in smoother (simpler) curves.
*   **Size Factors:** You can retrieve estimated size factors using `getsf(gsd)`.

## Reference documentation

- [NBAMSeq: Negative Binomial Additive Model for RNA-Seq Data](./references/NBAMSeq-vignette.md)
- [NBAMSeq Source Vignette (Rmd)](./references/NBAMSeq-vignette.Rmd)