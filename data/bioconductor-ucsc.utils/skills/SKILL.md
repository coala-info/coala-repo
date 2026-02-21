---
name: bioconductor-ucsc.utils
description: the package access the data via the UCSC REST API but some of them query the UCSC MySQL server directly. Note that the primary purpose of the package is to support higher-level functionalities implemented in downstream packages like GenomeInfoDb or txdbmaker.
homepage: https://bioconductor.org/packages/release/bioc/html/UCSC.utils.html
---

# bioconductor-ucsc.utils

## Overview

Use the Bioconductor R package **UCSC.utils** for: the package access the data via the UCSC REST API but some of them query the UCSC MySQL server directly. Note that the primary purpose of the package is to support higher-level functionalities implemented in downstream packages like GenomeInfoDb or txdbmaker.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("UCSC.utils")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.