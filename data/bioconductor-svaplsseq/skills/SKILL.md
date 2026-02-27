---
name: bioconductor-svaplsseq
description: This tool identifies and corrects for hidden sources of variability in RNA-seq data using partial least squares. Use when user asks to extract surrogate variables for latent heterogeneity, adjust for technical artifacts in differential expression analysis, or perform supervised and unsupervised hidden variable correction.
homepage: https://bioconductor.org/packages/3.6/bioc/html/SVAPLSseq.html
---


# bioconductor-svaplsseq

name: bioconductor-svaplsseq
description: Extract and correct for hidden sources of variability (latent heterogeneity) in RNAseq differential expression analysis using Partial Least Squares (PLS). Use this skill when you need to identify surrogate variables for technical artifacts or unknown biological variation and perform adjusted differential expression testing between two groups.

# bioconductor-svaplsseq

## Overview

The `SVAPLSseq` package provides a framework for identifying and adjusting for hidden biological and technical variables in RNAseq data. It uses a non-linear partial least squares (NPLS) algorithm to generate surrogate variables. These variables are then incorporated into a linear model to improve the power and accuracy of differential expression (DE) analysis between two biological groups.

The package supports two main workflows:
1.  **Unsupervised SVAPLSseq**: Regresses the primary signal-corrected residual matrix on the original data.
2.  **Supervised SVAPLSseq**: Uses a set of control features (e.g., housekeeping genes or spike-ins) known to have no differential expression to identify latent variation.

## Data Preparation

Input data must be a count matrix, a `SummarizedExperiment` object, or a `DGEList` object. You also need a factor variable defining the two groups.

```r
library(SVAPLSseq)
library(SummarizedExperiment)
library(edgeR)

# Example with a count matrix
data(sim.dat)
group <- as.factor(c(rep(1, 10), rep(-1, 10)))

# Optional: Convert to SummarizedExperiment
se_dat <- SummarizedExperiment(assays = SimpleList(counts = sim.dat))
```

## Extracting Surrogate Variables

The `svplsSurr` function identifies the hidden signatures.

### Unsupervised Approach
Use this when no specific control genes are known. Set `controls = NULL`.

```r
sv_unsupervised <- svplsSurr(dat = se_dat, 
                             group = group, 
                             max.surrs = 3, 
                             surr.select = "automatic", 
                             controls = NULL)

# Access results
surrogates <- sur(sv_unsupervised)
variance_explained <- prop.vars(sv_unsupervised)
```

### Supervised Approach
Use this when you have a set of control features (indices of genes/transcripts).

```r
# Assume genes 401-1000 are controls
control_indices <- 401:1000
sv_supervised <- svplsSurr(dat = se_dat, 
                           group = group, 
                           max.surrs = 3, 
                           surr.select = "automatic", 
                           controls = control_indices)
```

## Differential Expression Testing

The `svplsTest` function uses the extracted surrogate variables to perform adjusted DE testing.

### Testing Options
-   `test = "t-test"`: Based on regression coefficients (uses `limma`/`edgeR` logic).
-   `test = "lrt"`: Likelihood Ratio Test comparing models with and without the group effect.

```r
# Perform the test
fit <- svplsTest(dat = se_dat, 
                 group = group, 
                 surr = sur(sv_supervised), 
                 normalization = "TMM", 
                 test = "t-test")

# Extract results
significant_genes <- sig.features(fit)
raw_pvalues <- pvs.unadj(fit)
adjusted_pvalues <- pvs.adj(fit)
```

## Workflow Summary

1.  **Load Data**: Prepare count matrix and group factor.
2.  **Identify Surrogates**: Run `svplsSurr`. Choose `automatic` selection for statistical significance testing of components or `manual` if you know which components to keep.
3.  **Adjusted Test**: Run `svplsTest` passing the surrogate matrix to the `surr` argument.
4.  **Filter Results**: Use `sig.features` and `pvs.adj` to identify genes of interest.

## Reference documentation

- [SVAPLSseq](./references/SVAPLSseq.md)