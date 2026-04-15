---
name: bioconductor-vsn
description: This tool performs normalization and variance stabilization for microarray and high-throughput intensity data using an additive-multiplicative error model. Use when user asks to calibrate data to remove systematic biases, apply the generalized log2 transformation to stabilize variance, or normalize Affymetrix and two-color microarray datasets.
homepage: https://bioconductor.org/packages/release/bioc/html/vsn.html
---

# bioconductor-vsn

name: bioconductor-vsn
description: Normalization and variance stabilization for microarray and high-throughput intensity data. Use this skill to calibrate data (remove systematic biases) and apply the generalized log2 (glog2) transformation to stabilize variance across the intensity range. This is applicable to single-color and two-color microarrays (cDNA, Affymetrix), and other technologies with similar intensity-based data structures.

# bioconductor-vsn

## Overview

The `vsn` package implements a method for the calibration and variance stabilization of microarray intensities. It uses an additive-multiplicative error model and a robust maximum-likelihood estimator to perform two tasks simultaneously:
1.  **Calibration**: An affine transformation to account for systematic effects like labeling efficiency or detector sensitivity.
2.  **Variance Stabilization**: A generalized logarithm transformation ($glog_2$) that ensures the variance of the data is approximately independent of the mean intensity.

The resulting values are analogous to log-ratios but remain stable at low intensities where standard log-ratios typically exhibit high variance.

## Core Workflows

### 1. Quick Start (justvsn)
For most users, `justvsn` is the simplest entry point. It performs the fit and returns the normalized data in one step. It supports `ExpressionSet`, `AffyBatch`, and `RGList` objects.

```r
library(vsn)
# For an ExpressionSet 'eset'
eset_norm = justvsn(eset)

# Access normalized values
norm_matrix = exprs(eset_norm)
```

### 2. Explicit Model Fitting (vsn2 and predict)
Use this two-step approach when you need to inspect the fit or apply a model trained on a subset (e.g., spike-ins) to the rest of the data.

```r
# 1. Fit the model
fit = vsn2(eset)

# 2. Apply the transformation
eset_norm = predict(fit, eset)

# Inspect coefficients (a = offset, b = scaling)
coef(fit)
```

### 3. Affymetrix Data (vsnrma)
For Affymetrix arrays, `vsnrma` combines VSN-based background correction and normalization with RMA summarization.

```r
library(affy)
# 'abatch' is an AffyBatch object
eset_vsn = vsnrma(abatch)
```

### 4. Two-Color Arrays (RGList)
When working with `limma` objects, `justvsn` can handle the red and green channels.

```r
# 'rg' is an RGList
ncs = justvsn(rg)
# Returns an NChannelSet; M values can be calculated by subtraction
M = assayData(ncs)$R - assayData(ncs)$G
```

## Advanced Features

### Stratification (Strata)
If different parts of an array (e.g., print-tip groups) have different systematic biases, use the `strata` argument.

```r
# 'pin_groups' is a vector indicating the stratum for each row
fit = vsn2(eset, strata = pin_groups)
```

### Normalization against a Reference
To normalize new arrays to an existing dataset without re-processing the original data:

```r
# 'ref_fit' is a vsn object from the training set
new_fit = vsn2(new_data, reference = ref_fit)
```

### Robustness (lts.quantile)
The `lts.quantile` parameter (default 0.9) determines the fraction of data used for the robust fit. If you expect more than 10% of genes to be differentially expressed or outliers, decrease this value (down to 0.5).

```r
fit = vsn2(eset, lts.quantile = 0.7)
```

## Quality Assessment

The `meanSdPlot` is the primary tool for verifying variance stabilization. After a successful VSN run, the red line (running median) should be approximately horizontal.

```r
# Check if variance is independent of the mean
meanSdPlot(eset_norm)
```

## Reference documentation

- [Introduction to vsn](./references/A-vsn.md)
- [Likelihood calculations for vsn](./references/C-likelihoodcomputations.md)
- [Verifying and assessing the performance with simulated data](./references/D-convergence.md)