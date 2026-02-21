---
name: bioconductor-shortread
description: The package includes functions for filtering and trimming reads, and for generating a quality assessment report. Data are represented as DNAStringSet-derived objects, and easily manipulated for a diversity of purposes.  The package also contains legacy support for early single-end, ungapped alignment formats.
homepage: https://bioconductor.org/packages/release/bioc/html/ShortRead.html
---

# bioconductor-shortread

## Overview

Use the Bioconductor R package **ShortRead** for: The package includes functions for filtering and trimming reads, and for generating a quality assessment report. Data are represented as DNAStringSet-derived objects, and easily manipulated for a diversity of purposes.  The package also contains legacy support for early single-end, ungapped alignment formats.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("ShortRead")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.