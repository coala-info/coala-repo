---
name: r-cp4p
description: This tool validates p-value distributions and performs False Discovery Rate correction for proteomics data analysis. Use when user asks to generate calibration plots, estimate the proportion of true null hypotheses, or calculate adjusted p-values.
homepage: https://cran.r-project.org/web/packages/cp4p/index.html
---


# r-cp4p

name: r-cp4p
description: Statistical tool for proteomics data analysis to validate p-value distributions and perform False Discovery Rate (FDR) correction. Use when analyzing mass spectrometry or proteomics datasets to: (1) Generate calibration plots to check if p-values respect FDR control assumptions, (2) Estimate the proportion of true null hypotheses (pi0), and (3) Calculate adjusted p-values using various FDR procedures.

# r-cp4p

## Overview
The `cp4p` package provides functions to check whether a vector of p-values (typically from differential abundance tests in proteomics) respects the assumptions of False Discovery Rate (FDR) control procedures. It allows users to visualize p-value distributions via calibration plots and compute adjusted p-values by estimating the proportion of true null hypotheses ($\pi_0$).

## Installation
To install the package from CRAN:
```R
install.packages("cp4p")
```

## Main Functions

### 1. Calibration Plot
The `calibration.plot` function is used to visually assess if the p-values follow a uniform distribution under the null hypothesis.
```R
library(cp4p)
# p is a vector of p-values
calibration.plot(p, pi0method = "st.prop")
```
*   **Goal**: If the plot is below the diagonal, the FDR control might be too conservative. If it is above, it might be too liberal.

### 2. Adjusting P-values
The `adjust.p` function calculates adjusted p-values using several methods while accounting for the estimated $\pi_0$.
```R
# Perform p-value adjustment
results <- adjust.p(p, pi0method = "st.prop", alpha = 0.05)

# Access adjusted p-values
adj_p <- results$adjp
# Access estimated pi0
pi0_val <- results$pi0
```

### 3. Estimating pi0
The `estim.pi0` function provides various algorithms to estimate the proportion of true null hypotheses.
```R
pi0 <- estim.pi0(p, meth = "st.prop")
```

## Standard Workflow
1.  **Generate P-values**: Perform statistical tests (e.g., t-tests or Limma) on proteomics data to obtain a vector of raw p-values.
2.  **Check Assumptions**: Use `calibration.plot(p)` to ensure the p-values are well-behaved (uniform distribution for nulls).
3.  **Estimate $\pi_0$**: Determine the proportion of non-differentially abundant proteins.
4.  **FDR Correction**: Use `adjust.p` to obtain the list of significant proteins at a desired alpha level.

## Tips
*   **Proteomics Context**: This package is specifically designed to handle the "conservative" behavior often seen in proteomics p-value distributions due to missing values or specific normalization artifacts.
*   **Methods**: Supported methods for $\pi_0$ estimation include "st.prop", "st.boot", "smooth.spline", and "pc".
*   **Dependencies**: Ensure `multtest`, `qvalue`, and `limma` are installed from Bioconductor if using specific adjustment methods.

## Reference documentation
- [Home Page](./references/home_page.md)