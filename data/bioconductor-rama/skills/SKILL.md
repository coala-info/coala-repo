---
name: bioconductor-rama
description: The rama package provides tools for the robust estimation of gene expression levels in two-color microarray experiments using a Bayesian hierarchical model. Use when user asks to estimate gene expression from microarray data, handle outliers with t-distributions, or perform robust normalization of two-color intensity data.
homepage: https://bioconductor.org/packages/3.5/bioc/html/rama.html
---


# bioconductor-rama

## Overview

The `rama` package provides tools for the robust estimation of gene expression levels in two-color microarray experiments. It employs a Bayesian hierarchical model that explicitly accounts for outliers using a t-distribution and addresses common microarray issues such as design effects, normalization, and nonconstant variance. It is particularly effective for datasets with replicates where traditional linear models might be sensitive to technical artifacts.

## Data Preparation

The package requires raw (untransformed) intensity data. You must organize your data into two separate matrices or data frames: one for the control sample and one for the treatment sample.

- **Rows**: Genes
- **Columns**: Replicates
- **Dye-swap**: If using a dye-swap design, group replicates with the same dye together.

```r
# Example: Loading the built-in HIV dataset
library(rama)
data(hiv)

# hiv contains 640 genes. 
# Columns 1:4 = Treatment (HIV infected)
# Columns 5:8 = Control
# Columns 9:10 = Row/Col positions on array
```

## Typical Workflow

### 1. Estimating the Shift (Optional)
The model uses a log-transformation with a shifted origin: `log2(intensity + kappa)`. You can estimate `kappa` (the shift) separately or let the main fitting function handle it.

```r
# Manual estimation of the shift
mcmc.shift <- est.shift(hiv[, 1:4], hiv[, 5:8], B=2000, min.iter=1000, dye.swap=TRUE, nb.col1=2)
# The posterior mean of the shift is used in the next step
```

### 2. Fitting the Robust Model
The `fit.model` function performs the MCMC sampling.

```r
# Fit the model (B = total iterations, min.iter = burn-in)
# If shift=NULL, it is estimated automatically
mcmc.hiv <- fit.model(hiv[, 1:4], 
                      hiv[, 5:8], 
                      B=5000, 
                      min.iter=4000, 
                      shift=30, 
                      dye.swap=TRUE, 
                      nb.col1=2)
```

### 3. Extracting Results
Point estimates for gene effects (log intensities) can be extracted using `mat.mean`.

```r
# Extract posterior means for gene effects in both samples
gamma1 <- mat.mean(mcmc.hiv$gamma1)[, 1]
gamma2 <- mat.mean(mcmc.hiv$gamma2)[, 1]

# Calculate log ratios
log_ratio <- gamma1 - gamma2
```

## Visualization and Diagnostics

### Ratio Plots
Visualize the log ratios against overall intensity.
```r
ratio.plot(mcmc.hiv, col=1, pch=1)
```

### Outlier Detection (Weights)
The model assigns weights to each replicate. Lower weights indicate potential outliers.
```r
# Plot weights spatially to identify array artifacts
# Requires gene coordinates (e.g., columns 9 and 10 of the hiv data)
weight.plot(mcmc.hiv, hiv[, 9:10], array=3)
```

### Degrees of Freedom
Check the posterior distribution of the degrees of freedom for the t-distribution. Low values suggest the presence of many outliers in that specific array.
```r
hist(mcmc.hiv$df[3,], main="Posterior df, array 3", xlab="df")
```

## Performance Tips

- **MCMC Convergence**: 50,000 iterations are generally recommended for final results, though 5,000 may suffice for exploratory analysis.
- **Batch Mode**: For large datasets (many genes), use `R CMD BATCH` as the computational cost is high.
- **Memory**: Save the resulting MCMC object to disk using `save(mcmc.hiv, file="results.RData")` to avoid re-running long simulations.

## Reference documentation

- [Robust Analysis of MicroArray](./references/rama.md)