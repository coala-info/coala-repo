---
name: bioconductor-combi
description: This tool performs sample-wise data integration of multiple omics datasets using compositional model-based ordination. Use when user asks to integrate microbiome and metabolomics data, perform unconstrained or constrained ordination, or visualize shared variability across different data views.
homepage: https://bioconductor.org/packages/release/bioc/html/combi.html
---

# bioconductor-combi

name: bioconductor-combi
description: Perform sample-wise data integration of different omics views (e.g., microbiome and metabolomics) using the combi R package. Use this skill to integrate compositional sequence count data with other continuous data types, perform unconstrained or constrained ordination, and visualize shared variability across datasets.

# bioconductor-combi

## Overview
The `combi` package (Compositional Omics Model-Based Integration) provides a framework for integrating multiple data "views" (datasets) measured on the same samples. It is specifically designed to handle the compositional nature of microbiome data (using quasi-likelihood) alongside other data types like metabolomics (using Gaussian models). It allows for both explorative (unconstrained) and hypothesis-driven (constrained) integration.

## Core Workflow

### 1. Data Preparation
Input data can be raw matrices (features in columns), `phyloseq`, `SummarizedExperiment`, or `ExpressionSet` objects.

```r
library(combi)
data(Zhang) # Example data: zhangMicrobio, zhangMetabo, zhangMetavars

# Prepare a named list of views
data_list <- list(
  microbiome = zhangMicrobio, 
  metabolomics = zhangMetabo
)
```

### 2. Unconstrained Integration
Use `combi()` to find the main axes of variation shared across views without using external covariates.

```r
# distributions: "quasi" for counts, "gaussian" for continuous
# compositional: TRUE for relative abundance data
fit_unconstr <- combi(
  data_list,
  distributions = c("quasi", "gaussian"),
  compositional = c(TRUE, FALSE),
  logTransformGaussian = FALSE
)

# View summary
print(fit_unconstr)
```

### 3. Constrained Integration
Integrate data while constraining the ordination axes to be linear combinations of sample-level covariates.

```r
fit_constr <- combi(
  data_list,
  distributions = c("quasi", "gaussian"),
  compositional = c(TRUE, FALSE),
  covariates = zhangMetavars # Data frame of sample variables
)
```

### 4. Visualization and Extraction
The package provides specialized plotting functions for samples and features.

```r
# Standard biplot
plot(fit_unconstr, samDf = zhangMetavars, samCol = "ABX")

# Feature plots: "labels" (default), "points", or "density"
plot(fit_unconstr, featurePlot = "density")

# Extract coordinates for custom plotting
coords <- extractCoords(fit_unconstr, Dim = c(1, 2))
```

### 5. Diagnostics and Refinement
*   **Convergence**: Check if the iterative algorithm converged using `convPlot(fit)`.
*   **Influence**: Use `inflPlot(fit)` to see how much each view contributes to the sample scores.
*   **Stability**: If the function crashes (Newton-Raphson instability), try:
    *   Increasing `prevCutOff` or `minFraction` to filter sparse features.
    *   Changing `initPower` (e.g., to 1.5) to provide different starting values.

## Reference documentation
- [Manual for the combi package](./references/combi.md)
- [combi Vignette Source](./references/combi.Rmd)