---
name: bioconductor-narrowpeaks
description: "The package applies a functional version of principal component analysis (FPCA) to: (1) Postprocess data in wiggle track format, commonly produced by generic ChIP-seq peak callers, by applying FPCA over a set of read-enriched regions (ChIP-seq peaks). This is done to study variability of the the peaks, or to shorten their genomic locations accounting for a given proportion of variation among the enrichment-score profiles. (2) Analyse differential variation between multiple ChIP-seq samples with replicates. The function 'narrowpeaksDiff' quantifies differences between the shapes, and uses Hotelling's T2 tests on the functional principal component scores to identify significant differences across conditions. An application of the package for Arabidopsis datasets is described in Mateos, Madrigal, et al. (2015) Genome Biology: 16:31."
homepage: https://bioconductor.org/packages/3.8/bioc/html/NarrowPeaks.html
---

# bioconductor-narrowpeaks

## Overview

Use the Bioconductor R package **NarrowPeaks** for: The package applies a functional version of principal component analysis (FPCA) to: (1) Postprocess data in wiggle track format, commonly produced by generic ChIP-seq peak callers, by applying FPCA over a set of read-enriched regions (ChIP-seq peaks). This is done to study variability of the the peaks, or to shorten their genomic locations accounting for a given proportion of variation among the enrichment-score profiles. (2) Analyse differential variation between multiple ChIP-seq samples with replicates. The function 'narrowpeaksDiff' quantifies differences between the shapes, and uses Hotelling's T2 tests on the functional principal component scores to identify significant differences across conditions. An application of the package for Arabidopsis datasets is described in Mateos, Madrigal, et al. (2015) Genome Biology: 16:31.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("NarrowPeaks")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.