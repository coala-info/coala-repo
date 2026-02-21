---
name: bioconductor-vsn
description: The package implements a method for normalising microarray intensities from single- and multiple-color arrays. It can also be used for data from other technologies, as long as they have similar format. The method uses a robust variant of the maximum-likelihood estimator for an additive-multiplicative error model and affine calibration. The model incorporates data calibration step (a.k.a. normalization), a model for the dependence of the variance on the mean intensity and a variance stabilizing data transformation. Differences between transformed intensities are analogous to "normalized log-ratios". However, in contrast to the latter, their variance is independent of the mean, and they are usually more sensitive and specific in detecting differential transcription.
homepage: https://bioconductor.org/packages/release/bioc/html/vsn.html
---

# bioconductor-vsn

## Overview

Use the Bioconductor R package **vsn** for: The package implements a method for normalising microarray intensities from single- and multiple-color arrays. It can also be used for data from other technologies, as long as they have similar format. The method uses a robust variant of the maximum-likelihood estimator for an additive-multiplicative error model and affine calibration. The model incorporates data calibration step (a.k.a. normalization), a model for the dependence of the variance on the mean intensity and a variance stabilizing data transformation. Differences between transformed intensities are analogous to "normalized log-ratios". However, in contrast to the latter, their variance is independent of the mean, and they are usually more sensitive and specific in detecting differential transcription.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("vsn")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.