---
name: bioconductor-metabcombiner
description: The package outputs a combined table of feature pair alignments, organized into groups of similar m/z, and ranked by a similarity score. Input tables are assumed to be acquired using similar (but not necessarily identical) analytical methods.
homepage: https://bioconductor.org/packages/release/bioc/html/metabCombiner.html
---

# bioconductor-metabcombiner

## Overview

Use the Bioconductor R package **metabCombiner** for: The package outputs a combined table of feature pair alignments, organized into groups of similar m/z, and ranked by a similarity score. Input tables are assumed to be acquired using similar (but not necessarily identical) analytical methods.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("metabCombiner")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.