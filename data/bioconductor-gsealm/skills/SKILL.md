---
name: bioconductor-gsealm
description: This tool performs linear-model-based Gene Set Enrichment Analysis to identify significant gene sets and analyze model diagnostics. Use when user asks to fit gene-wise linear models, calculate gene-set level statistics, perform permutation-based inference, or identify influential samples using Cook's Distance.
homepage: https://bioconductor.org/packages/release/bioc/html/GSEAlm.html
---


# bioconductor-gsealm

name: bioconductor-gsealm
description: Linear-model inference and diagnostics for Gene Set Enrichment Analysis (GSEA). Use this skill to fit gene-wise linear models, calculate gene-set level statistics and residuals, and perform permutation-based inference for differential expression in gene sets.

# bioconductor-gsealm

## Overview

The `GSEAlm` package implements a linear-model-based approach to Gene Set Enrichment Analysis (GSEA). It treats gene expression as a response variable in a linear model, allowing for complex experimental designs involving multiple factors (e.g., phenotype, sex, age). It provides tools for both inference (identifying significant gene sets) and diagnostics (identifying outlier samples or influential observations at the gene-set level).

## Core Workflow

### 1. Data Preparation

Ensure you have an `ExpressionSet` and a gene-set incidence matrix. An incidence matrix has gene sets as rows and genes as columns, with 1 indicating membership.

```r
library(GSEAlm)
# Example: eset is an ExpressionSet, Amat is an incidence matrix
```

### 2. Fitting Linear Models per Gene

Use `lmPerGene` to fit the same linear model to every gene in the dataset.

```r
# Simple one-factor model
lmPhen <- lmPerGene(eset, ~ phenotype)

# Multi-factor model
lmExpand <- lmPerGene(eset, ~ phenotype + sex + covariate)
```

### 3. Diagnostics and Residuals

Analyze residuals to identify technical artifacts or sample-specific biases.

```r
# Get externally Studentized residuals
lmResid <- getResidPerGene(lmPhen, type = "extStudent")

# Visualize residuals by sample
resplot(resmat = exprs(lmResid), fac = eset$phenotype, horiz = TRUE)
```

### 4. Gene-Set Aggregation

Aggregate gene-level statistics (t-statistics, residuals, or influence measures) to the gene-set level using `GSNormalize`. The default behavior calculates the Jiang and Gentleman (J-G) statistic.

```r
# Aggregate t-statistics to gene-set level
# lmPhen$tstat contains gene-level t-stats
gsStats <- GSNormalize(lmPhen$tstat, Amat)

# Aggregate residuals to gene-set level (GS residuals)
gsResid <- GSNormalize(exprs(lmResid), Amat)
```

### 5. Permutation-Based Inference

For robust p-values that account for gene-gene correlations, use `gsealmPerm`. This function permutes labels within subgroups defined by adjusting factors.

```r
# First factor in formula is the factor of interest
# removeShift=TRUE compares differential expression vs. the global median shift
pvals <- gsealmPerm(eset, ~ phenotype + sex, Amat, nperm = 1000, removeShift = TRUE)
```

### 6. Influence Analysis

Identify samples that disproportionately affect the model results using Cook's Distance.

```r
# Calculate Cook's D for every gene/sample
cookie <- CooksDPerGene(lmExpand)

# Aggregate to gene-set level (root-mean D)
gsCooks <- GSNormalize(cookie, Amat, fun2 = identity)

# Visualize influence via boxplot
boxplot(sqrt(gsCooks) ~ col(gsCooks), main = "Influence by Sample")
```

## Key Functions

- `lmPerGene`: Fits linear models to all genes simultaneously. Returns an object containing coefficients, t-statistics, and sigma.
- `getResidPerGene`: Extracts residuals. Types include "raw", "normalized", "intStudent" (internally Studentized), and "extStudent" (externally Studentized).
- `GSNormalize`: The workhorse for moving from gene-level to gene-set level. It divides the sum of gene statistics by the square root of the gene-set size.
- `gsealmPerm`: Performs permutation tests. It is critical for multiple regression models where you must permute the factor of interest within strata of other covariates.
- `CooksDPerGene` / `Leverage` / `dffitsPerGene`: Diagnostic tools to find influential samples or outliers.

## Reference documentation

- [GSEAlm](./references/GSEAlm.md)