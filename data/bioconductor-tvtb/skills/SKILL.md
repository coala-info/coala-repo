---
name: bioconductor-tvtb
description: TVTB provides S4 classes and methods to filter, summarize, and visualize genetic variation data stored in VCF files. Use when user asks to filter genetic variants, summarize VCF data, or visualize variation using the Shiny Variant Explorer.
homepage: https://bioconductor.org/packages/release/bioc/html/TVTB.html
---


# bioconductor-tvtb

## Overview

Use the Bioconductor R package **TVTB** for: The package provides S4 classes and methods to filter, summarise and visualise genetic variation data stored in VCF files. In particular, the package extends the FilterRules class (S4Vectors package) to define news classes of filter rules applicable to the various slots of VCF objects. Functionalities are integrated and demonstrated in a Shiny web-application, the Shiny Variant Explorer (tSVE).

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("TVTB")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.