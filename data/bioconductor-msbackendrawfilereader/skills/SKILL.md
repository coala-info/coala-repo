---
name: bioconductor-msbackendrawfilereader
description: This package provides a backend for the Spectra framework to read and process raw mass spectrometry data files. Use when user asks to read raw mass spectrometry data, import Thermo Fisher raw files, or integrate raw data into the Spectra Bioconductor package.
homepage: https://bioconductor.org/packages/release/bioc/html/MsBackendRawFileReader.html
---


# bioconductor-msbackendrawfilereader

## Overview

Use the Bioconductor R package **MsBackendRawFileReader** for: The package is generalizing the functionality introduced by the rawrr package Methods defined in this package are supposed to extend the Spectra Bioconductor package.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("MsBackendRawFileReader")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.