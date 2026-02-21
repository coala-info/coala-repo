---
name: bioconductor-mqmetrics
description: The package MQmetrics (MaxQuant metrics) provides a workflow to analyze the quality and reproducibility of your proteomics mass spectrometry analysis from MaxQuant.Input data are extracted from several MaxQuant output tables, and produces a pdf report. It includes several visualization tools to check numerous parameters regarding the quality of the runs.It also includes two functions to visualize the iRT peptides from Biognosysin case they were spiked in the samples.
homepage: https://bioconductor.org/packages/3.13/bioc/html/MQmetrics.html
---

# bioconductor-mqmetrics

## Overview

Use the Bioconductor R package **MQmetrics** for: The package MQmetrics (MaxQuant metrics) provides a workflow to analyze the quality and reproducibility of your proteomics mass spectrometry analysis from MaxQuant.Input data are extracted from several MaxQuant output tables, and produces a pdf report. It includes several visualization tools to check numerous parameters regarding the quality of the runs.It also includes two functions to visualize the iRT peptides from Biognosysin case they were spiked in the samples.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("MQmetrics")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.