---
name: bioconductor-plsdabatch
description: Bioconductor-plsdabatch performs multivariate batch-effect correction and visualization for microbiome data using PLS-DA frameworks. Use when user asks to detect batch effects, visualize data using PCA with density overlays, or correct batch effects in compositional data using PLSDA-batch or sPLSDA-batch.
homepage: https://bioconductor.org/packages/release/bioc/html/PLSDAbatch.html
---

# bioconductor-plsdabatch

name: bioconductor-plsdabatch
description: Multivariate batch-effect correction for microbiome data using PLSDA-batch, sPLSDA-batch, and weighted PLSDA-batch. Use this skill when performing batch-effect detection, visualization, and correction in R, particularly for compositional data (e.g., OTU counts) requiring CLR transformation.

## Overview
The `PLSDAbatch` package provides a framework for correcting batch effects based on Projection to Latent Structures Discriminant Analysis (PLS-DA). It is specifically designed for microbiome data, handling non-parametric distributions and compositionality. It allows users to estimate and remove variation associated with batch effects while preserving treatment-related variation.

## Core Workflow

### 1. Data Pre-processing
Before correction, data should be filtered and transformed to handle the characteristics of microbiome count data.

```r
library(PLSDAbatch)
library(mixOmics)

# Pre-filtering: Remove low-abundance OTUs
# data: raw count matrix (samples as rows, OTUs as columns)
filter.res <- PreFL(data = raw_counts)
data.filter <- filter.res$data.filter

# Transformation: Centered Log-Ratio (CLR)
# Use offset = 1 for raw counts
data.clr <- logratio.transfo(X = data.filter, logratio = "CLR", offset = 1)
data.clr <- as.matrix(data.clr)
```

### 2. Batch Effect Detection
Visualize the data to confirm the presence of batch effects using PCA and density plots.

```r
# PCA with density overlays
pca.before <- mixOmics::pca(data.clr, ncomp = 3, scale = TRUE)
Scatter_Density(
    components = pca.before$variates$X, 
    batch = batch_factor, 
    trt = treatment_factor,
    title = "PCA Before Correction"
)

# Statistical check for specific variables
# type = "linear model" or "linear mixed model"
otu.lm <- linear_regres(data = data.clr[, "OTU_ID"], trt = treatment_factor, batch.fix = batch_factor)
summary(otu.lm$model$data)
```

### 3. Batch Effect Correction (PLSDA-batch)
The primary function `PLSDA_batch()` requires specifying the number of components for treatment and batch.

**Component Selection Rule:** Generally, `nlevels(factor) - 1`.

```r
# Standard PLSDA-batch (Regression mode recommended for version > 1.6.0)
res.plsda <- PLSDA_batch(
    X = data.clr,
    Y.trt = treatment_factor,
    Y.bat = batch_factor,
    ncomp.trt = nlevels(treatment_factor) - 1,
    ncomp.bat = nlevels(batch_factor) - 1,
    mode = "regression"
)
data.corrected <- res.plsda$X.nobatch

# sPLSDA-batch (with variable selection to reduce overfitting)
# keepX.trt: number of variables to keep for treatment components
res.splsda <- PLSDA_batch(
    X = data.clr,
    Y.trt = treatment_factor,
    Y.bat = batch_factor,
    ncomp.trt = 1,
    keepX.trt = 100, 
    ncomp.bat = 4,
    mode = "regression"
)
```

**Special Cases:**
- **Unbalanced Designs:** Set `balance = FALSE` to use weighted PLSDA-batch.
- **Legacy Support:** Set `mode = "canonical"` to reproduce results from `PLSDAbatch` versions ≤ 1.6.0.

### 4. Post-Correction Evaluation
Assess the success of the correction using Alignment Scores or pRDA.

```r
# Alignment Score: Higher score = better mixing (less batch effect)
score <- alignment_score(
    data = data.corrected,
    batch = batch_factor,
    var = 0.95, # variance to explain
    k = 8       # nearest neighbors
)

# pRDA: Partitioning variance
library(vegan)
rda.res <- varpart(data.corrected, ~treatment_factor, ~batch_factor, scale = TRUE)
# Plotting the proportions
partVar_plot(prop.df = as.data.frame(rda.res$part$indfract))
```

## Tips for Success
- **Component Tuning:** Use `mixOmics::tune.splsda` to find the optimal `keepX.trt` for the sparse version.
- **Scaling:** When calculating $R^2$ or creating heatmaps for evaluation, ensure the corrected data is scaled (`scale(data.corrected)`).
- **Input Format:** Ensure the input `X` is a matrix and `Y.trt`/`Y.bat` are factors.

## Reference documentation
- [PLSDA-batch Vignette](./references/brief_vignette.md)