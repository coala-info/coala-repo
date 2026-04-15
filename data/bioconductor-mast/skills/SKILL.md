---
name: bioconductor-mast
description: MAST is a Bioconductor package that performs differential expression analysis on single-cell RNA-seq data using a hurdle model to account for zero-inflation and bimodal distributions. Use when user asks to analyze single-cell expression data, fit hurdle models, perform differential expression analysis, or conduct gene set enrichment analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/MAST.html
---

# bioconductor-mast

## Overview

MAST is a Bioconductor package designed to handle the unique statistical properties of single-cell expression data, specifically zero-inflation (dropout) and bimodal expression distributions. It implements a "hurdle model"—a two-part generalized linear model that simultaneously accounts for the discrete (presence/absence of expression) and continuous (intensity of expression) components of the data.

## Core Workflow

### 1. Data Object Construction
MAST uses the `SingleCellAssay` (SCA) class, which extends `SingleCellExperiment`.

```R
library(MAST)

# From a matrix (genes x cells)
# MAST expects log-transformed data, e.g., log2(TPM + 1)
sca <- FromMatrix(exprsArray = expression_matrix, 
                  cData = cell_metadata, 
                  fData = feature_metadata)

# From a flattened data.frame
sca <- FromFlatDF(dataframe, idvars=c("Subject", "Well"), 
                  primerid='Gene', measurement='Et')

# Coerce from SingleCellExperiment
sca <- SceToSingleCellAssay(sce_object)
```

### 2. Quality Control and Filtering
A critical step is calculating the Cellular Detection Rate (CDR), which is the proportion of genes detected in a cell. This is often used as a covariate to control for technical variation.

```R
# Calculate CDR (ngeneson)
cdr2 <- colSums(assay(sca) > 0)
colData(sca)$cngeneson <- scale(cdr2)

# Filter genes based on frequency
# Keep genes expressed in at least 10% of cells
sca <- sca[freq(sca) > 0.1, ]

# Filter cells (e.g., based on CDR or other metrics)
sca <- subset(sca, nGeneOn > 4000)
```

### 3. Differential Expression with the Hurdle Model
The `zlm` function fits the hurdle model. You can include covariates like CDR to adjust for technical effects.

```R
# Fit the model
# ~ condition + CDR
zlmCond <- zlm(~ condition + cngeneson, sca)

# Perform Likelihood Ratio Test (LRT) for a specific coefficient
summaryCond <- summary(zlmCond, doLRT='conditionStim')
summaryDt <- summaryCond$datatable

# Extract results
# component 'H' is the Hurdle (combined) test
# component 'logFC' provides the effect size
fcHurdle <- merge(summaryDt[contrast=='conditionStim' & component=='H', .(primerid, `Pr(>Chisq)`)],
                  summaryDt[contrast=='conditionStim' & component=='logFC', .(primerid, coef, ci.hi, ci.lo)], 
                  by='primerid')
```

### 4. Gene Set Enrichment Analysis (GSEA)
MAST performs competitive GSEA using a bootstrapping approach to account for inter-gene correlation.

```R
# 1. Bootstrap to estimate variance-covariance
boots <- bootVcov1(zlmCond, R = 50)

# 2. Run GSEA
# sets_indices is a list of gene indices for each module
gsea <- gseaAfterBoot(zlmCond, boots, sets_indices, CoefficientHypothesis("conditionStim"))

# 3. Summarize results
z_stat_comb <- summary(gsea, testType='normal')
```

## Key Functions and Tips

- **`zlm()`**: The workhorse function. Supports `method='glm'` (standard), `method='glmer'` (mixed models via lme4), and Bayesian priors.
- **`thresholdSCRNACountMatrix()`**: Used for adaptive thresholding to distinguish signal from background noise.
- **`invlogit()`**: Useful for transforming the discrete component back to probability space.
- **Assay Names**: MAST looks for specific assay names for log-like data: `thresh`, `et`, `Et`, `lCount`, `logTPM`, `logcounts`.
- **Memory**: For very large datasets, MAST supports `Sparse` matrices and `HDF5Array` backends, though dense matrices are faster for the underlying linear algebra.

## Reference documentation

- [Using MAST with RNASeq: MAIT Analysis](./references/MAITAnalysis.md)
- [MAST Intro](./references/MAST-Intro.md)
- [Interoperability between MAST and SingleCellExperiment-derived packages](./references/MAST-interoperability.md)