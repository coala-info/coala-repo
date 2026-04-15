---
name: bioconductor-informeasure
description: This tool quantifies nonlinear dependence between variables in biological regulatory networks using information theory. Use when user asks to calculate mutual information, infer bivariate or trivariate relationships in regulatory networks, or perform partial information decomposition on biological datasets.
homepage: https://bioconductor.org/packages/release/bioc/html/Informeasure.html
---

# bioconductor-informeasure

name: bioconductor-informeasure
description: Quantify nonlinear dependence between variables in biological regulatory networks using information theory. Use when Claude needs to calculate Mutual Information (MI), Conditional Mutual Information (CMI), Interaction Information (II), Partial Information Decomposition (PID), or Part Mutual Information (PMI) from gene expression or other biological datasets.

# bioconductor-informeasure

## Overview

The `Informeasure` package provides tools to quantify nonlinear associations in biological networks. It implements several information-theoretic measures to infer bivariate and trivariate relationships, which are particularly useful for analyzing transcriptome regulatory networks (e.g., protein-protein interactions, ceRNA networks, or miRNA-target regulation).

## Core Workflow

The general process for using any measure in this package involves three steps:
1.  **Data Preparation**: Extract numeric vectors from data frames or `SummarizedExperiment` objects.
2.  **Discretization**: Convert continuous data into discrete count tables using `discretize2D()` or `discretize3D()`.
3.  **Measurement**: Apply the specific `.measure()` function to the discretized table.

## Key Functions

### Bivariate Analysis (2 variables)
*   `MI.measure(XY)`: Calculates Mutual Information to measure mutual dependence between two variables.

### Trivariate Analysis (3 variables)
*   `CMI.measure(XYZ)`: Calculates Conditional Mutual Information (X and Y conditioned on Z).
*   `II.measure(XYZ)`: Calculates Interaction Information (co-information) to explore cooperative or competitive mechanisms.
*   `PID.measure(XYZ)`: Performs Partial Information Decomposition into Synergy, Unique information (X and Y), and Redundancy.
*   `PMI.measure(XYZ)`: Calculates Part Mutual Information to measure direct dependencies, especially when variables are strongly correlated with the third.

## Data Discretization

Before calculating measures, continuous data must be discretized.

```r
# For 2 variables
XY <- discretize2D(x, y, num_bins = NULL, method = "uniform_width")

# For 3 variables
XYZ <- discretize3D(x, y, z, num_bins = NULL, method = "uniform_width")
```

**Parameters:**
*   `num_bins`: Default is the square root of the data size.
*   `method`: "uniform_width" (equal width bins) or "uniform_frequency" (equal count bins).

## Probability Estimators

All measure functions support a `method` argument to specify the probability estimator (referencing the `entropy` package):

*   `"ML"`: Empirical/Maximum Likelihood estimator (default).
*   `"shrink"`: Shrinkage estimator.
*   `"Jeffreys"`, `"Laplace"`, `"SG"`, `"minimax"`: Dirichlet distribution estimators with different prior values.

## Usage Examples

### Using Data Frames
```r
library(Informeasure)
# Assuming x, y, z are numeric vectors from a data frame
XYZ <- discretize3D(x, y, z)
results <- PID.measure(XYZ, method = "ML")
```

### Using SummarizedExperiment
```r
library(SummarizedExperiment)
# Extract assays and log-transform if necessary
x <- assays(se["Gene1", ])$log2
y <- assays(se["Gene2", ])$log2
z <- assays(se["Gene3", ])$log2

XYZ <- discretize3D(x, y, z)
cmi_val <- CMI.measure(XYZ)
```

## Reference documentation
- [Informeasure-vignette](./references/Informeasure-vignette.Rmd)
- [Informeasure](./references/Informeasure.md)