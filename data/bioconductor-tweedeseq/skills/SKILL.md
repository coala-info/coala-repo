---
name: bioconductor-tweedeseq
description: The tweeDEseq package performs differential expression analysis of RNA-seq data by modeling count distributions using the Poisson-Tweedie family. Use when user asks to normalize and filter count data, test for goodness of fit to the negative binomial distribution, or perform differential expression testing using score-based tests and generalized linear models.
homepage: https://bioconductor.org/packages/release/bioc/html/tweeDEseq.html
---


# bioconductor-tweedeseq

## Overview
The `tweeDEseq` package provides a flexible framework for differential expression (DE) analysis by modeling count data with the Poisson-Tweedie (PT) family of distributions. This family unifies several distributions (Poisson, Negative Binomial, Poisson-Inverse Gaussian) and is particularly effective for extensively replicated RNA-seq experiments where biological variability leads to heavy-tailed distributions that the standard Negative Binomial model cannot capture.

## Typical Workflow

### 1. Data Preparation and Normalization
The package relies on `edgeR` for TMM normalization and library size adjustment.

```r
library(tweeDEseq)

# counts: matrix of raw counts (genes in rows, samples in columns)
# group: factor defining experimental conditions
countsNorm <- normalizeCounts(counts, group)

# Filter low-expression genes (default: < 5 CPM in all but one sample)
countsFiltered <- filterCounts(countsNorm)
```

### 2. Goodness of Fit Testing
Before performing DE, check if the Negative Binomial (NB) assumption holds (where shape parameter $a=0$).

```r
# Test a subset of genes for fit to NB (a=0)
chi2gof <- gofTest(countsFiltered[1:100, ], a = 0)

# Visualize fit using Chi-square Q-Q plot
qqchisq(chi2gof, main = "NB Goodness-of-fit")
```

### 3. Differential Expression Analysis
Use `tweeDE()` for a score-based test between two conditions.

```r
# Perform DE test
resPT <- tweeDE(countsFiltered, group = group)

# View top results
print(resPT)

# Extract significant genes (e.g., FDR < 0.05 and Fold Change > 1.5)
deGenes <- print(resPT, n = Inf, log2fc = log2(1.5), pval.adjust = 0.05, print = FALSE)
```

### 4. Generalized Linear Models (GLM)
For complex designs or incorporating offsets (like CQN), use the GLM interface.

```r
# Fit PT GLM for a single gene
mod <- glmPT(countsFiltered[1, ] ~ group + batch)
summary(mod)

# Fit PT GLM for all genes
resPTglm <- tweeDEglm(~ group, counts = countsFiltered)

# Incorporating CQN offsets
resPTglm_off <- tweeDEglm(~ group, counts = countsFiltered, offset = my_cqn_offsets)
```

## Visualization
The package provides standard plots to interpret DE results.

```r
# MA-plot
MAplot(resPT, log2fc.cutoff = log2(1.5))

# Volcano plot
Vplot(resPT, log2fc.cutoff = log2(1.5), pval.adjust.cutoff = 0.05)

# Compare empirical distribution of a gene vs Poisson, NB, and PT
compareCountDist(countsFiltered["GENE_ID", ], main = "Distribution Comparison")
```

## Key Functions
- `normalizeCounts()`: Wrapper for edgeR-based TMM normalization.
- `filterCounts()`: Removes low-count features.
- `tweeDE()`: Main function for two-group differential expression testing.
- `tweeDEglm()`: Fits Poisson-Tweedie GLMs across a count matrix.
- `gofTest()`: Evaluates if genes follow a specific distribution (e.g., Negative Binomial).
- `mlePoissonTweedie()`: Maximum likelihood estimation of PT parameters ($\mu, \phi, a$).

## Reference documentation
- [tweeDEseq: analysis of RNA-seq data using the Poisson-Tweedie family of distributions](./references/tweeDEseq.md)