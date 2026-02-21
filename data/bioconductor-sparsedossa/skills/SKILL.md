---
name: bioconductor-sparsedossa
description: The package is to provide a model based Bayesian method to characterize and simulate microbiome data. sparseDOSSA's model captures the marginal distribution of each microbial feature as a truncated, zero-inflated log-normal distribution, with parameters distributed as a parent log-normal distribution. The model can be effectively fit to reference microbial datasets in order to parameterize their microbes and communities, or to simulate synthetic datasets of similar population structure. Most importantly, it allows users to include both known feature-feature and feature-metadata correlation structures and thus provides a gold standard to enable benchmarking of statistical methods for metagenomic data analysis.
homepage: https://bioconductor.org/packages/3.8/bioc/html/sparseDOSSA.html
---

# bioconductor-sparsedossa

## Overview

Use the Bioconductor R package **sparseDOSSA** for: The package is to provide a model based Bayesian method to characterize and simulate microbiome data. sparseDOSSA's model captures the marginal distribution of each microbial feature as a truncated, zero-inflated log-normal distribution, with parameters distributed as a parent log-normal distribution. The model can be effectively fit to reference microbial datasets in order to parameterize their microbes and communities, or to simulate synthetic datasets of similar population structure. Most importantly, it allows users to include both known feature-feature and feature-metadata correlation structures and thus provides a gold standard to enable benchmarking of statistical methods for metagenomic data analysis.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("sparseDOSSA")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.