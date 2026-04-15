---
name: r-mvr
description: This tool performs joint adaptive mean-variance regularization and variance stabilization for high-dimensional multivariate data. Use when user asks to normalize omics data, compute regularized t-statistics, or generate diagnostic plots for mean-variance relationships.
homepage: https://cran.r-project.org/web/packages/mvr/index.html
---

# r-mvr

name: r-mvr
description: Use for joint adaptive mean-variance regularization and variance stabilization of high-dimensional multivariate data (p >> n), such as omics data. This skill is applicable when the variance is a function of the mean, making standard variance estimators unreliable. Use it to normalize data, compute regularized t-statistics, and generate diagnostic plots.

# r-mvr

## Overview
The `MVR` package implements a non-parametric method for joint adaptive mean-variance regularization and variance stabilization. It is specifically designed for high-dimensional "omics" type data where the number of variables ($p$) greatly exceeds the number of samples ($n$). The method addresses issues where test statistics have low power due to a lack of degrees of freedom and where variance depends on the mean.

Key capabilities:
- Data normalization and variance stabilization.
- Computation of mean-variance-regularized t-statistics.
- Generation of diagnostic plots to assess regularization quality.
- Computationally efficient C/C++ implementation with parallel computing support.

## Installation
To install the stable version from CRAN:
```R
install.packages("MVR")
```

## Usage and Workflows

### Core Workflow
The typical workflow involves preparing a high-dimensional matrix, applying the regularization, and then performing downstream statistical testing or visualization.

1. **Load the library and data**:
   ```R
   library(MVR)
   # Load provided example datasets if needed
   data(synthetic_data) 
   ```

2. **Apply Mean-Variance Regularization**:
   Use the primary end-user functions to stabilize the variance of your dataset.
   ```R
   # Example of calling the main mvr function (refer to manual for specific parameters)
   # result <- mvr(data, ...)
   ```

3. **Compute Regularized Statistics**:
   The package allows for the calculation of t-statistics that benefit from the regularized variance estimators, providing more power than standard t-tests in $p >> n$ scenarios.

4. **Diagnostic Plotting**:
   The package provides 4 specific diagnostic functions to visualize the mean-variance relationship before and after regularization.
   ```R
   # Use diagnostic functions to check stabilization
   # plot(result) or specific MVR plotting functions
   ```

### Tips for High-Dimensional Data
- **Parallel Computing**: For very large datasets, ensure you enable the parallel computing options within the functions to reduce processing time.
- **Check for Updates**: Use `MVR.news()` to see the latest changes and feature additions (such as upcoming F-statistics support).
- **Citation**: If using this method in published research, use `citation("MVR")` to get the correct reference for Dazard and Rao (2012).

## Reference documentation
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)
- [wiki.md](./references/wiki.md)