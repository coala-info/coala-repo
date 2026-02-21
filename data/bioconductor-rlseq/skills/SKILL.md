---
name: bioconductor-rlseq
description: The package is intended to provide a simple pipeline, called with the `RLSeq()` function, which performs all main analyses. Individual functions are also accessible and provide custom analysis capabilities. Finally an HTML report is generated with `report()`.
homepage: https://bioconductor.org/packages/3.14/bioc/html/RLSeq.html
---

# bioconductor-rlseq

## Overview

Use the Bioconductor R package **RLSeq** for: The package is intended to provide a simple pipeline, called with the `RLSeq()` function, which performs all main analyses. Individual functions are also accessible and provide custom analysis capabilities. Finally an HTML report is generated with `report()`.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("RLSeq")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.