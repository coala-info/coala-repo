---
name: bioconductor-globalseq
description: This tool performs statistical testing for associations between RNA-Seq count data and high-dimensional covariate sets using a negative binomial framework. Use when user asks to perform global tests of association, decompose test statistics to identify influential covariates, or conduct genome-wide mapping of expression data to local molecular profiles.
homepage: https://bioconductor.org/packages/release/bioc/html/globalSeq.html
---


# bioconductor-globalseq

name: bioconductor-globalseq
description: Statistical testing for association between RNA-Seq data (overdispersed counts) and high-dimensional covariate sets. Use this skill when you need to perform global tests of association, decompose test statistics to identify influential samples or covariates, or conduct genome-wide analyses mapping expression data to local molecular profiles (e.g., DNA methylation or copy number).

# bioconductor-globalseq

## Overview

The `globalSeq` package provides a specialized framework for testing the association between a count-based response variable (typically RNA-Seq data) and a high-dimensional set of covariates. It is particularly useful when the number of covariates exceeds the sample size ($p > n$), making classical regression tests inapplicable. The package utilizes a negative binomial distribution to account for overdispersion in sequencing data and offers permutation-based p-values.

## Core Functions

### 1. Omnibus Test (`omnibus`)
The primary function for testing the joint significance of a covariate set against a count response.

```r
# Basic usage
# y: numeric vector (counts)
# X: matrix (covariates, samples in rows)
result <- omnibus(y, X)

# Handling multiple covariate sets (e.g., different molecular profiles)
result_multi <- omnibus(y, list(X1, X2))

# Parameters:
# offset: numeric vector to account for library size/sequencing depth
# group: factor for stratified permutations (confounding variables)
# phi: dispersion parameter (set phi=0 for Poisson distribution)
# kind: p-value type (1 = crude permutation, 0 = control variables, 0 < kind < 1 = interrupted)
```

### 2. Decomposition (`proprius`)
Used to visualize and identify which specific samples or covariates are driving the association.

```r
# Decompose by samples
proprius(y, X, type="samples")

# Decompose by covariates with significance threshold
proprius(y, X, type="covariates", alpha=0.05)
```

### 3. Genome-wide Analysis (`cursus`)
Automates the testing of multiple genes against local covariates (e.g., cis-regulatory elements) within a specified genomic window.

```r
# Y: matrix of gene expression (genes in rows, samples in columns)
# Yloc: genomic locations of genes
# V: matrix of molecular profiles (covariates)
# Vloc: genomic locations of covariates
# window: distance threshold for association
results <- cursus(Y, Yloc, V, Vloc, window=5)

# Supports multiple chromosomes via Ychr and Vchr arguments
```

## Typical Workflow

1.  **Initialization**: Load the package and prepare data. Ensure RNA-Seq counts are integers.
    ```r
    library(globalSeq)
    # Optional: attach(toydata) for practice
    ```
2.  **Global Testing**: Run `omnibus()` to check if there is any signal between the gene expression and the covariate block.
3.  **Adjustment**: If results are biased by library size or batch effects, provide the `offset` or `group` arguments.
4.  **Interpretation**: If the p-value is significant, use `proprius()` to plot contributions. Positive values indicate a contribution toward the association; negative values indicate evidence against it.
5.  **Scaling**: For whole-transcriptome studies, use `cursus()` to map expression to nearby genetic/epigenetic features.

## Tips for Success

*   **Library Sizes**: Always account for sequencing depth. You can calculate offsets using `colSums(Y)` or more advanced methods from `edgeR` (e.g., TMM normalization factors).
*   **Dispersion**: By default, the package estimates the dispersion parameter ($\phi$). If you have pre-calculated tagwise dispersions from `edgeR` or `DESeq2`, you can pass them to `phi` to improve accuracy.
*   **P-value Precision**: For high-speed screening, use `kind=0.05` in `omnibus` to interrupt permutations that are unlikely to reach significance. Use `kind=1` for final publication-quality p-values.

## Reference documentation

- [article.md](./references/article.md)
- [globalSeq.md](./references/globalSeq.md)
- [vignette.md](./references/vignette.md)