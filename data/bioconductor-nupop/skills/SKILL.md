---
name: bioconductor-nupop
description: NuPoP predicts nucleosome positioning and occupancy using duration hidden Markov models. Use when user asks to predict nucleosome positioning, calculate nucleosome occupancy, or model nucleosome organization for various species.
homepage: https://bioconductor.org/packages/release/bioc/html/NuPoP.html
---


# bioconductor-nupop

## Overview

Use the Bioconductor R package **NuPoP** for: the package was written in Fotran. In addition to the R package, a stand-alone Fortran software tool is also available at https://github.com/jipingw. The Fortran codes have complete functonality as the R package.  Note: NuPoP has two separate functions for prediction of nucleosome positioning, one for MNase-map trained models and the other for chemical map-trained models. The latter was implemented for four species including yeast, S.pombe, mouse and human, trained based on our recent publications. We noticed there is another package nuCpos by another group for prediction of nucleosome positioning trained with chemicals. A report to compare recent versions of NuPoP with nuCpos can be found at https://github.com/jiping/NuPoP_doc. Some more information can be found and will be posted at https://github.com/jipingw/NuPoP.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("NuPoP")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.