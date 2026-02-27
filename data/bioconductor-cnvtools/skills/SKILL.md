---
name: bioconductor-cnvtools
description: bioconductor-cnvtools performs robust case-control and quantitative trait association testing for Copy Number Variants using mixture model clustering. Use when user asks to perform signal normalization via PCA or LDF, fit mixture models to CNV data, or test for genetic associations between copy number variations and traits.
homepage: https://bioconductor.org/packages/3.6/bioc/html/CNVtools.html
---


# bioconductor-cnvtools

name: bioconductor-cnvtools
description: Robust case-control and quantitative trait association testing for Copy Number Variants (CNVs). Use this skill when analyzing CNV data to perform signal normalization (PCA/LDF), mixture model clustering, and genetic association testing with binary or quantitative traits.

## Overview

CNVtools is designed for the statistical analysis of CNV data, specifically focusing on robust association testing. It addresses technical artifacts and differential bias by fitting mixture models to one-dimensional signal summaries. The package provides tools to collapse multi-probe signal intensities into a single dimension using Principal Component Analysis (PCA) or Linear Discriminant Analysis (LDF) and then tests for association between these signals and a trait of interest.

## Core Workflow

### 1. Data Preparation and Dimensionality Reduction
CNVtools requires a one-dimensional signal per sample. If you have multiple probes for a single CNV, use PCA to summarize them.

```R
library(CNVtools)
# raw.signal: matrix where rows = samples, columns = probes
pca.signal <- apply.pca(raw.signal)
```

### 2. Model Selection (BIC)
Determine the optimal number of copy number components (clusters) using the Bayesian Information Criterion.

```R
# v.ncomp: vector of components to test (e.g., 1:5)
results <- CNVtest.select.model(signal = pca.signal, 
                                batch = batches, 
                                sample = samples, 
                                method = "BIC", 
                                v.ncomp = 1:5)
ncomp <- results$selected
plot(-results$BIC, type="b") # Minimize BIC
```

### 3. Initial Clustering (H0)
Cluster the data under the null hypothesis (no association) to obtain posterior probabilities.

```R
fit.pca <- CNVtest.binary(signal = pca.signal, 
                          sample = samples, 
                          batch = batches, 
                          ncomp = ncomp, 
                          n.H0 = 3, 
                          model.var = "~ strata(cn)")

# Check convergence: 'C' is the only acceptable status
print(fit.pca$status.H0)
```

### 4. Signal Improvement (LDF)
Refine the one-dimensional signal using the posterior probabilities from the PCA fit via Linear Discriminant Functions. This often provides better separation than PCA alone.

```R
pca.posterior <- as.matrix(fit.pca$posterior.H0[, grep("P", colnames(fit.pca$posterior.H0))])
ldf.signal <- apply.ldf(raw.signal, pca.posterior)
```

### 5. Association Testing
Perform the actual association test using the refined LDF signal.

**Binary Trait (Case-Control):**
```R
fit.ldf <- CNVtest.binary(signal = ldf.signal, 
                          sample = samples, 
                          batch = batches, 
                          disease.status = trait, 
                          ncomp = ncomp, 
                          model.var = "~cn")

# Likelihood Ratio Test
LR.stat <- -2 * (fit.ldf$model.H0$lnL - fit.ldf$model.H1$lnL)
# Distributed as Chi-squared (df=1 for linear trend, df=ncomp-1 for factor model)
```

**Quantitative Trait:**
```R
fit.qt <- CNVtest.qt(signal = ldf.signal, 
                     sample = samples, 
                     batch = batches, 
                     qt = quantitative_trait, 
                     ncomp = ncomp)
```

## Key Functions and Parameters

- `CNVtest.binary`: Main function for case-control studies.
- `CNVtest.qt`: Main function for quantitative traits.
- `cnv.plot`: Visualizes the clustering and posterior probabilities.
- `model.var`: Use `"~ strata(cn)"` for independent variances per copy number state (robust) or `"~ cn"` for proportional variance.
- `model.disease`: Default is `"~ cn"` (linear trend/allelic dosage). Use `"~ as.factor(cn)"` for a general model without linear constraints.

## Tips for Success
- **Convergence**: Always check `fit$status.H0` and `fit$status.H1`. If status is 'M' (max iterations) or 'F' (failed), try increasing `n.H0` to find a better global maximum.
- **Batches**: If data comes from different cohorts or plates, include the `batch` argument to account for technical variation.
- **One CNV at a time**: CNVtools is not designed for genome-wide data structures. Loop through your CNVs or use a wrapper to process multiple regions.

## Reference documentation
- [CNVtools Vignette](./references/CNVtools-vignette.md)