---
name: bioconductor-corral
description: The package also includes additional options, including variations of CA to address overdispersion in count data (e.g., Freeman-Tukey chi-squared residual), as well as the option to apply CA-style processing to continuous data (e.g., proteomic TOF intensities) with the Hellinger distance adaptation of CA.
homepage: https://bioconductor.org/packages/release/bioc/html/corral.html
---

# bioconductor-corral

## Overview

Use the Bioconductor R package **corral** for: The package also includes additional options, including variations of CA to address overdispersion in count data (e.g., Freeman-Tukey chi-squared residual), as well as the option to apply CA-style processing to continuous data (e.g., proteomic TOF intensities) with the Hellinger distance adaptation of CA.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("corral")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.