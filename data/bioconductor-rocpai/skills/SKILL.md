---
name: bioconductor-rocpai
description: "ROCpAI analyzes ROC curves, identifies their types, and calculates the area under the curve and partial area under the curve. Use when user asks to analyze ROC curves, identify ROC curve types, calculate AUC, or standardize proper and improper pAUC."
homepage: https://bioconductor.org/packages/release/bioc/html/ROCpAI.html
---


# bioconductor-rocpai

## Overview

Use the Bioconductor R package **ROCpAI** for: The package analyzes the Curve ROC, identificates it among different types of Curve ROC and calculates the area under de curve through the method that is most accuracy. This package is able to standarizate proper and improper pAUC.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("ROCpAI")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.