---
name: bioconductor-rmat
description: "the package MAT and contains functions to parse and merge Affymetrix BPMAP and CEL tiling array files (using C++ based Fusion SDK and Bioconductor package affxparser), normalize tiling arrays using sequence specific models, detect enriched regions from ChIP-chip experiments. Note: users should have GSL and GenomeGraphs installed. Windows users: 'consult the README file available in the inst directory of the source distribution for necessary configuration instructions'."
homepage: https://bioconductor.org/packages/3.5/bioc/html/rMAT.html
---

# bioconductor-rmat

## Overview

Use the Bioconductor R package **rMAT** for: the package MAT and contains functions to parse and merge Affymetrix BPMAP and CEL tiling array files (using C++ based Fusion SDK and Bioconductor package affxparser), normalize tiling arrays using sequence specific models, detect enriched regions from ChIP-chip experiments. Note: users should have GSL and GenomeGraphs installed. Windows users: 'consult the README file available in the inst directory of the source distribution for necessary configuration instructions'.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("rMAT")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.