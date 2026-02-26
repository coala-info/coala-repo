---
name: bioconductor-mwastools
description: MWASTools is an R package for performing metabolome-wide association studies and analyzing metabonomic data. Use when user asks to perform quality control of metabonomic data, conduct metabolome-wide association studies using various models, validate results with bootstrapping, or identify NMR metabolites using STOCSY.
homepage: https://bioconductor.org/packages/release/bioc/html/MWASTools.html
---


# bioconductor-mwastools

## Overview

Use the Bioconductor R package **MWASTools** for: the package include: quality control analysis of metabonomic data; MWAS using different association models (partial correlations; generalized linear models); model validation using non-parametric bootstrapping; visualization of MWAS results; NMR metabolite identification using STOCSY; and biological interpretation of MWAS results.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("MWASTools")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.