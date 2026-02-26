---
name: bioconductor-scpdata
description: This package provides mass spectrometry-based single-cell proteomics datasets formatted for the scp data structure. Use when user asks to access single-cell proteomics datasets, retrieve published mass spectrometry data, or load quantitative protein information for single cells.
homepage: https://bioconductor.org/packages/release/data/experiment/html/scpdata.html
---


# bioconductor-scpdata

## Overview

Use the Bioconductor R package **scpdata** for: The package disseminates mass spectrometry (MS)-based single-cell proteomics (SCP) datasets. The data were collected from published work and formatted using the `scp` data structure. The data sets contain quantitative information at spectrum, peptide and/or protein level for single cells or minute sample amounts.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("scpdata")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.