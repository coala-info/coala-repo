---
name: bioconductor-saturn
description: The package consists of three main functions. The first function, fitDTU, fits quasi-binomial generalized linear models that model transcript usage in different groups of interest. The second function, testDTU, tests for differential usage of transcripts between groups of interest. Finally, plotDTU visualizes the usage profiles of transcripts in groups of interest.
homepage: https://bioconductor.org/packages/release/bioc/html/satuRn.html
---

# bioconductor-saturn

## Overview

Use the Bioconductor R package **satuRn** for: The package consists of three main functions. The first function, fitDTU, fits quasi-binomial generalized linear models that model transcript usage in different groups of interest. The second function, testDTU, tests for differential usage of transcripts between groups of interest. Finally, plotDTU visualizes the usage profiles of transcripts in groups of interest.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("satuRn")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.