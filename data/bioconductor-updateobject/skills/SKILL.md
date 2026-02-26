---
name: bioconductor-updateobject
description: The bioconductor-updateobject package updates serialized S4 instances within R packages. Use when user asks to update serialized S4 objects or maintain Bioconductor package instances.
homepage: https://bioconductor.org/packages/release/bioc/html/updateObject.html
---


# bioconductor-updateobject

## Overview

Use the Bioconductor R package **updateObject** for: The package is primarily useful to package maintainers who want to update the serialized S4 instances included in their package. This is still work-in-progress.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("updateObject")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.