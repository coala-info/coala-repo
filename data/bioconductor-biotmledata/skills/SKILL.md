---
name: bioconductor-biotmledata
description: This package provides example microarray and RNA-seq datasets for testing and demonstrating Targeted Minimum Loss-based Estimation workflows. Use when user asks to access sample data for the biotmle package, load the illuminaData SummarizedExperiment object, or explore pre-computed TMLE results for biomarker discovery.
homepage: https://bioconductor.org/packages/release/data/experiment/html/biotmleData.html
---


# bioconductor-biotmledata

name: bioconductor-biotmledata
description: Access and use the example microarray and RNA-seq datasets provided in the biotmleData package. Use this skill when you need sample data for testing Targeted Minimum Loss-based Estimation (TMLE) in the context of biomarker discovery, specifically for the biotmle R package.

# bioconductor-biotmledata

## Overview

The `biotmleData` package is a data-only experiment package for Bioconductor. It provides real-world and simulated datasets specifically formatted for use with the `biotmle` R package. Its primary purpose is to facilitate examples, vignettes, and testing for TMLE-based differential expression and biomarker discovery workflows.

The package includes:
- **illuminaData**: A `SummarizedExperiment` object containing microarray data (Illumina Ref-8 BeadChips) and associated phenotype/covariate data.
- **biomarkerTMLEout**: Pre-computed results from running the `biomarkertmle` procedure on the Illumina data.
- **rnaseqTMLEout**: Pre-computed results from running the `biomarkertmle` procedure on simulated RNA-seq (count) data.

## Loading Data

To use the datasets, load the package and use the `data()` function:

```r
library(biotmleData)

# Load the SummarizedExperiment object
data(illuminaData)

# Load pre-computed results to save time during analysis
data(biomarkerTMLEout)
data(rnaseqTMLEout)
```

## Typical Workflows

### Exploring the Microarray Data
The `illuminaData` object is a `SummarizedExperiment`. You can interact with it using standard Bioconductor methods:

```r
library(SummarizedExperiment)

# View expression values
assay(illuminaData)[1:5, 1:5]

# View phenotype/covariate data
colData(illuminaData)

# Check dimensions
dim(illuminaData)
```

### Using Pre-computed Results
The `biomarkerTMLEout` and `rnaseqTMLEout` objects are of class `biotmle`. These are useful for demonstrating visualization or table-generation functions in the `biotmle` package without re-running the computationally intensive TMLE estimation.

```r
# Example: If using with the 'biotmle' package
# library(biotmle)
# plot(biomarkerTMLEout)
# summary(biomarkerTMLEout)
```

## Tips
- **Data Source**: The `illuminaData` comes from a 2007 epidemiological study on benzene exposure.
- **Object Class**: Ensure you have the `SummarizedExperiment` package loaded to properly manipulate the `illuminaData` object.
- **Purpose**: These datasets are primarily for demonstration. For actual analysis of your own data, you should follow the workflow outlined in the `biotmle` package documentation using these datasets as a template.

## Reference documentation

- [biotmleData Reference Manual](./references/reference_manual.md)