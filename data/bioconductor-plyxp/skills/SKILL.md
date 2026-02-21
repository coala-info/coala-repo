---
name: bioconductor-plyxp
description: The package provides `rlang` data masks for the SummarizedExperiment class. The enables the evaluation of unquoted expression in different contexts of the SummarizedExperiment object with optional access to other contexts. The goal for `plyxp` is for evaluation to feel like a data.frame object without ever needing to unwind to a rectangular data.frame.
homepage: https://bioconductor.org/packages/release/bioc/html/plyxp.html
---

# bioconductor-plyxp

## Overview

Use the Bioconductor R package **plyxp** for: The package provides `rlang` data masks for the SummarizedExperiment class. The enables the evaluation of unquoted expression in different contexts of the SummarizedExperiment object with optional access to other contexts. The goal for `plyxp` is for evaluation to feel like a data.frame object without ever needing to unwind to a rectangular data.frame.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("plyxp")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.