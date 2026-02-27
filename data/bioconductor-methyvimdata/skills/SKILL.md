---
name: bioconductor-methyvimdata
description: This package provides example DNA methylation data in a GenomicRatioSet format for testing and demonstrating the methyvim analysis pipeline. Use when user asks to load example methylation data, access the grsExample dataset, or follow methyvim vignettes for variable importance analysis.
homepage: https://bioconductor.org/packages/3.8/data/experiment/html/methyvimData.html
---


# bioconductor-methyvimdata

name: bioconductor-methyvimdata
description: Provides access to and documentation for the methyvimData R package, which contains example DNA methylation data (GenomicRatioSet) used for demonstrating the methyvim analysis pipeline. Use this skill when a user needs to load example methylation data for testing variable importance methods or following methyvim vignettes.

# bioconductor-methyvimdata

## Overview

The `methyvimData` package is a data-only experiment package for Bioconductor. Its primary purpose is to provide a subset of DNA methylation data to support the `methyvim` package, which implements targeted learning-based variable importance measures for CpG sites. The data is stored in a `GenomicRatioSet` object, a standard container for methylomic data that extends the `SummarizedExperiment` class.

## Loading the Data

To use the example data, load the library and use the `data()` function to bring the `grsExample` object into the environment.

```r
# Load the package
library(methyvimData)

# Load the example GenomicRatioSet
data(grsExample)

# Inspect the object
grsExample
```

## Data Structure and Usage

The `grsExample` object contains:
- **Dimensions**: 400 CpG sites (rows) across 210 samples (columns).
- **Assays**: Contains both `Beta` values (proportions) and `M` values (log-ratios).
- **ColData**: Includes two variables: `exp` (exposure/treatment) and `outcome` (continuous or binary response).
- **Annotation**: Based on the `IlluminaHumanMethylationEPIC` array.

### Accessing Components

Since the data is a `GenomicRatioSet`, you can interact with it using standard `minfi` or `SummarizedExperiment` methods:

```r
# Access methylation values (Beta or M)
beta_values <- minfi::getBeta(grsExample)
m_values <- minfi::getM(grsExample)

# Access sample metadata
sample_info <- SummarizedExperiment::colData(grsExample)

# Access genomic coordinates
coords <- SummarizedExperiment::rowRanges(grsExample)
```

## Typical Workflow with methyvim

The data is specifically formatted to be passed into the `methyvim` function. A common workflow involves:

1. Loading `methyvimData`.
2. Identifying the exposure and outcome variables in `colData(grsExample)`.
3. Running the `methyvim` analysis to find differentially methylated positions (DMPs) using targeted maximum likelihood estimation (TMLE).

```r
# Example of preparing for methyvim analysis
library(methyvim)
library(methyvimData)
data(grsExample)

# Run methyvim (requires methyvim package installed)
# results <- methyvim(data_grs = grsExample, var_int = "exp", outcome = "outcome")
```

## Reference documentation

- [Anatomy of the methyvimData package](./references/data_methyvim.md)