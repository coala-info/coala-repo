---
name: bioconductor-metapone
description: This package conducts pathway testing from untargeted metabolomics data. Use when user asks to perform pathway analysis on untargeted metabolomics data, weight metabolic features based on potential matches, or combine positive and negative mode results in pathway tests.
homepage: https://bioconductor.org/packages/release/bioc/html/metapone.html
---


# bioconductor-metapone

## Overview

Use the Bioconductor R package **metapone** for: The package conducts pathway testing from untargetted metabolomics data. It requires the user to supply feature-level test results, from case-control testing, regression, or other suitable feature-level tests for the study design. Weights are given to metabolic features based on how many metabolites they could potentially match to. The package can combine positive and negative mode results in pathway tests.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("metapone")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.