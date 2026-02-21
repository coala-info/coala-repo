---
name: bioconductor-proda
description: The package implements a probabilistic dropout model that ensures that the information from observed and missing values are properly combined. It adds empirical Bayesian priors to increase power to detect differentially abundant proteins.
homepage: https://bioconductor.org/packages/release/bioc/html/proDA.html
---

# bioconductor-proda

## Overview

Use the Bioconductor R package **proDA** for: The package implements a probabilistic dropout model that ensures that the information from observed and missing values are properly combined. It adds empirical Bayesian priors to increase power to detect differentially abundant proteins.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("proDA")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.