---
name: bioconductor-toast
description: "TOAST analyzes high-throughput genomic data from heterogeneous tissue samples to identify cell-type specific signals. Use when user asks to estimate cell type proportions, perform cell-type specific differential expression or methylation analysis, and conduct cross-cell type differential analysis."
homepage: https://bioconductor.org/packages/release/bioc/html/TOAST.html
---


# bioconductor-toast

name: bioconductor-toast
description: Analysis of high-throughput data from heterogeneous samples (mixtures of cell types). Use this skill to perform cell-type specific differential expression (csDE) or differential methylation (csDM) analysis, estimate cell type proportions (deconvolution), and conduct cross-cell type differential analysis.

## Overview

TOAST (TOols for the Analysis of heterogeneouS Tissues) provides a statistical framework for analyzing genomic data where samples are mixtures of different cell types (e.g., blood, tumor, or brain tissue). It allows researchers to uncover cell-type specific signals that are often masked in bulk analysis. The package supports reference-based, reference-free, and partial reference-free deconvolution, followed by rigorous testing for differential signals.

## Core Workflow

### 1. Data Preparation
TOAST requires three main inputs:
- **Y_raw**: A matrix of expression or methylation data (features by samples) or a `SummarizedExperiment` object.
- **design**: A data frame containing sample metadata (e.g., age, gender, disease status). Categorical variables must be factors.
- **Prop**: A matrix of cell type proportions (samples by cell types).

### 2. Estimating Cell Proportions (Deconvolution)
If proportions are unknown, use one of these methods:

**Reference-Based (RB):**
Requires a reference panel (e.g., `Blood_ref`).
```r
# 1. Select markers
refinx <- findRefinx(Y_raw, nmarker = 1000, sortBy = "var")
# 2. Estimate using EpiDISH (RPC method)
library(EpiDISH)
outT <- epidish(beta.m = Y_raw[refinx,], ref.m = Blood_ref[refinx,], method = "RPC")
Prop <- outT$estF
```

**Reference-Free (RF) with Improvement:**
TOAST improves RF deconvolution via iterative feature selection.
```r
# K is the number of cell types
outRF <- csDeconv(Y_raw, K = 6, TotalIter = 30, bound_negative = TRUE)
Prop <- outRF$estProp
```

**Partial Reference-Free (PRF):**
Requires cell-type specific markers but no full reference panel.
```r
# Get markers from pure profiles or prior knowledge
myMarker <- ChooseMarker(LM_5, CellType_list)
# Deconvolve with optional prior (e.g., "human pbmc")
res <- MDeconv(Y_raw, myMarker, alpha = "human pbmc")
Prop <- t(res$H)
```

### 3. Cell-Type Specific Testing (csDE/csDM)
Once proportions are available, follow this three-step testing pipeline:

```r
# 1. Create the design matrix
Design_out <- makeDesign(design, Prop)

# 2. Fit the linear model
fitted_model <- fitModel(Design_out, Y_raw)

# 3. Test for differential signals
# Test 'disease' effect in 'Gran' cells
res_table <- csTest(fitted_model, coef = "disease", cell_type = "Gran")

# Test joint effect across all cell types
res_joint <- csTest(fitted_model, coef = "disease", cell_type = "joint")
```

### 4. Advanced Testing: CEDAR
To improve power in low-abundance cell types, use `cedar` to incorporate correlation of DE/DM states between cell types.
```r
res_cedar <- cedar(Y_raw = Y_raw, prop = Prop, design.1 = design, factor.to.test = 'disease')
# Access posterior probabilities
head(res_cedar$tree_res$full$pp)
```

### 5. Cross-Cell Type Analysis
Compare signals between different cell types within the same sample.
```r
# Compare CD8T vs Bcell in the 'disease' group (level 1)
test_cross <- csTest(fitted_model, 
                     coef = c("disease", 1), 
                     cell_type = c("CD8T", "Bcell"))
```

## Key Functions
- `findRefinx()`: Selects informative features for deconvolution based on variance or CV.
- `makeDesign()`: Combines phenotype metadata and cell proportions into a model matrix.
- `fitModel()`: Fits the TOAST linear model to the data.
- `csTest()`: Performs the statistical tests for csDE/csDM or cross-cell type differences.
- `MDeconv()`: Performs partial reference-free deconvolution.
- `Tsisal()`: Complete deconvolution using a geometric approach for DNA methylation.

## Tips for Success
- **Factor Conversion**: Ensure all categorical variables in your design data frame are converted to factors using `as.factor()`.
- **Variance Shrinkage**: Keep `var_shrinkage = TRUE` (default) in `csTest()` to prevent unstable statistics from extremely small variance estimates.
- **Feature Selection**: For RNA-seq counts, use `sortBy = "cv"` in `findRefinx()`. For DNA methylation or log-counts, `sortBy = "var"` is generally preferred.
- **Validation**: Because F-tests can sometimes show inflated Type I errors in this context, consider permutation tests for highly significant results.

## Reference documentation
- [The TOAST User's Guide](./references/TOAST.md)
- [Analyses of high-throughput data from heterogeneous samples with TOAST](./references/TOAST.Rmd)