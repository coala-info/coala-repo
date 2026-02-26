---
name: bioconductor-cllmethylation
description: This Bioconductor package provides DNA methylation data for primary Chronic Lymphocytic Leukemia samples from the PACE project. Use when user asks to access CLL methylation data, analyze PACE project DNA methylation arrays, or retrieve data from the EGAS0000100174 accession.
homepage: https://bioconductor.org/packages/release/data/experiment/html/CLLmethylation.html
---


# bioconductor-cllmethylation

## Overview

Use the Bioconductor R package **CLLmethylation** for: The package includes DNA methylation data for the primary Chronic Lymphocytic Leukemia samples included in the Primary Blood Cancer Encyclopedia (PACE) project. Raw data from the 450k DNA methylation arrays is stored in the European Genome-Phenome Archive (EGA) under accession number EGAS0000100174. For more information concerning the project please refer to the paper "Drug-perturbation-based stratification of blood cancer" by Dietrich S, Oles M, Lu J et al., J. Clin. Invest. (2018) and R/Bioconductor package BloodCancerMultiOmics2017.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("CLLmethylation")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.