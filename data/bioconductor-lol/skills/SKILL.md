---
name: bioconductor-lol
description: This tool performs stable network inference and genomic marker selection using various Lasso optimization methods. Use when user asks to perform integrative genomic analysis, identify copy number alterations that influence gene expression, or conduct robust variable selection in high-dimensional biological datasets.
homepage: https://bioconductor.org/packages/3.6/bioc/html/lol.html
---

# bioconductor-lol

name: bioconductor-lol
description: Stable network inference and genomic marker selection using various Lasso optimization methods (stability selection, multi-split, simultaneous, and cross-validation). Use this skill when performing integrative genomic analysis, specifically for identifying copy number alterations (CNA) that influence gene expression (e.g., eQTL-like studies) or when seeking robust variable selection in high-dimensional biological datasets.

## Overview

The `lol` (Lots Of Lasso) package provides a framework for robust Lasso-based inference in genomics. It addresses the instability and overfitting common in standard Lasso cross-validation by implementing four distinct optimization strategies. It is particularly suited for "integrative" analysis where one genomic data type (like Copy Number) is used to predict another (like Gene Expression).

## Core Workflow

### 1. Data Preparation
The package expects data in a list format with specific class assignments to determine the optimization method.

```r
library(lol)
data(chin07)

# Prepare data list
# y: response (e.g., gene expression)
# x: predictors (e.g., copy number, transposed so samples are rows)
Data <- list(y = chin07$ge[1,], x = t(chin07$cn))
```

### 2. Selecting an Optimizer
The behavior of the `lasso()` function is controlled by the `class` of the input list.

*   **Cross-validation (`cv`)**: Standard Lasso optimization.
    ```r
    class(Data) <- "cv"
    res <- lasso(Data)
    ```
*   **Stability Selection (`stability`)**: Uses sub-sampling to find stable predictors.
    ```r
    class(Data) <- "stability"
    res <- lasso(Data)
    ```
*   **Multi-split Lasso (`multiSplit`)**: Splits samples into disjoint sets for selection and OLS fitting to aggregate p-values.
    ```r
    class(Data) <- "multiSplit"
    res <- lasso(Data)
    ```
*   **Simultaneous Lasso (`simultaneous`)**: Selects coefficients that are simultaneously non-zero across two random sample splits.
    ```r
    class(Data) <- "simultaneous"
    res <- lasso(Data)
    ```

### 3. Matrix-wide Inference
For high-throughput analysis involving multiple responses (e.g., a whole gene expression matrix), use `matrixLasso`.

```r
DataMat <- list(y = t(chin07$ge), x = t(chin07$cn))
res_mat <- matrixLasso(DataMat, method = "stability")
```

### 4. Refitting and Visualization
Lasso coefficients are shrunk. It is recommended to refit the selected predictors using Ordinary Least Squares (OLS) to get unbiased estimates.

```r
# Refit using lmMatrixFit
res_lm <- lmMatrixFit(y = DataMat, mat = abs(res_mat$coefMat), th = 0.01)

# Visualize results across the genome
plotGW(data = res$beta, pos = attr(chin07$cn, "chrome"), file = "results_plot")
```

## Key Functions

*   `lasso(Data)`: Primary interface for single-response inference. Method depends on `class(Data)`.
*   `matrixLasso(Data, method)`: Wrapper for multiple responses. Methods: "cv", "stability", "multiSplit", "simultaneous".
*   `lmMatrixFit(y, mat, th)`: Refits selected variables using linear models to avoid Lasso shrinkage bias.
*   `plotGW(data, pos, ...)`: Visualizes genomic markers or Lasso coefficients across chromosomes.

## Tips for Success

*   **Seed Setting**: Because stability, multi-split, and simultaneous methods rely on random resampling, always use `set.seed()` for reproducibility.
*   **Significance Thresholds**: For `stability` and `simultaneous` methods, coefficients should typically pass a selection frequency threshold (e.g., > 0.6) to be considered significant.
*   **Data Orientation**: Ensure predictors (`x`) have samples as rows and features as columns (use `t()` if necessary).

## Reference documentation

- [lol](./references/lol.md)