---
name: bioconductor-ropls
description: The bioconductor-ropls package performs multivariate analysis including PCA, PLS, and OPLS for metabolomics data. Use when user asks to determine the optimal number of components, perform permutation testing, detect outliers, or conduct feature selection.
homepage: https://bioconductor.org/packages/release/bioc/html/ropls.html
---


# bioconductor-ropls

## Overview

Use the Bioconductor R package **ropls** for: the package provides metrics and graphics to determine the optimal number of components (e.g. with the R2 and Q2 coefficients), check the validity of the model by permutation testing, detect outliers, and perform feature selection (e.g. with Variable Importance in Projection or regression coefficients). The package can be accessed via a user interface on the Workflow4Metabolomics.org online resource for computational metabolomics (built upon the Galaxy environment).

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("ropls")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.