---
name: bioconductor-compounddb
description: The package provides also a backend for Bioconductor's Spectra package and allows thus to match experimetal MS/MS spectra against MS/MS spectra in the database. Databases can be stored in SQLite format and are thus portable.
homepage: https://bioconductor.org/packages/release/bioc/html/CompoundDb.html
---

# bioconductor-compounddb

## Overview

Use the Bioconductor R package **CompoundDb** for: The package provides also a backend for Bioconductor's Spectra package and allows thus to match experimetal MS/MS spectra against MS/MS spectra in the database. Databases can be stored in SQLite format and are thus portable.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("CompoundDb")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.