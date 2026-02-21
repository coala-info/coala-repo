---
name: bioconductor-sparsenetgls
description: The package provides methods of combining the graph structure learning and generalized least squares regression to improve the regression estimation. The main function sparsenetgls() provides solutions for multivariate regression with Gaussian distributed dependant variables and explanatory variables utlizing multiple well-known graph structure learning approaches to estimating the precision matrix, and uses a penalized variance covariance matrix with a distance tuning parameter of the graph structure in deriving the sandwich estimators in generalized least squares (gls) regression. This package also provides functions for assessing a Gaussian graphical model which uses the penalized approach. It uses Receiver Operative Characteristics curve as a visualization tool in the assessment.
homepage: https://bioconductor.org/packages/release/bioc/html/sparsenetgls.html
---

# bioconductor-sparsenetgls

## Overview

Use the Bioconductor R package **sparsenetgls** for: The package provides methods of combining the graph structure learning and generalized least squares regression to improve the regression estimation. The main function sparsenetgls() provides solutions for multivariate regression with Gaussian distributed dependant variables and explanatory variables utlizing multiple well-known graph structure learning approaches to estimating the precision matrix, and uses a penalized variance covariance matrix with a distance tuning parameter of the graph structure in deriving the sandwich estimators in generalized least squares (gls) regression. This package also provides functions for assessing a Gaussian graphical model which uses the penalized approach. It uses Receiver Operative Characteristics curve as a visualization tool in the assessment.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("sparsenetgls")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.