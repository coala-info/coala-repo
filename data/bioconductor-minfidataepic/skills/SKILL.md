---
name: bioconductor-minfidataepic
description: This package provides example datasets from the Illumina Human Methylation EPIC array for testing and demonstrating methylation analysis workflows. Use when user asks to load example EPIC array data, test minfi-based preprocessing methods, or access technical replicates of the GM12878 cell line for methylation benchmarking.
homepage: https://bioconductor.org/packages/release/data/experiment/html/minfiDataEPIC.html
---

# bioconductor-minfidataepic

name: bioconductor-minfidataepic
description: Provides access to and guidance for using the minfiDataEPIC Bioconductor package. This skill should be used when a user needs example data from the Illumina Methylation EPIC array (850k) for testing methylation analysis workflows, specifically involving the GM12878 cell line. Use this to demonstrate minfi-based preprocessing, quality control, and normalization on EPIC array data.

# bioconductor-minfidataepic

## Overview
The `minfiDataEPIC` package is a data-only experiment package providing example datasets for the Illumina Human Methylation EPIC platform. It contains three technical replicates of the GM12878 cell line. This package is essential for testing and demonstrating the `minfi` package's capabilities on the newer EPIC array format, which features significantly more probes than the older 450k array.

## Loading the Data
The package provides two primary objects: a raw data object (`RGChannelSet`) and a preprocessed object (`MethylSet`).

```r
# Load the package
library(minfiDataEPIC)

# Load the raw data (RGChannelSet)
data(RGsetEPIC)

# Load the preprocessed data (MethylSet)
data(MsetEPIC)
```

## Key Objects and Workflows

### 1. Raw Data: RGsetEPIC
The `RGsetEPIC` object is an `RGChannelSet`. This is the starting point for most methylation analysis workflows.
- **Usage**: Use this to test preprocessing methods like `preprocessRaw`, `preprocessIllumina`, `preprocessSWAN`, or `preprocessNoob`.
- **Metadata**: Access sample information using `pData(RGsetEPIC)`.

### 2. Preprocessed Data: MsetEPIC
The `MsetEPIC` object is a `MethylSet` that has already been processed using `preprocessRaw`.
- **Usage**: Use this for downstream analysis testing, such as calculating Beta values or M-values.
- **Comparison**: Useful for comparing the results of different normalization techniques against a baseline raw preprocessing.

### 3. Accessing Underlying Files
The package includes the original IDAT files and the scripts used to generate the R objects.
- **IDAT files**: Located in the `extdata` directory of the package installation path.
- **Scripts**: Located in the `scripts` directory of the package.

```r
# Find the path to the IDAT files
path <- system.file("extdata", package = "minfiDataEPIC")
list.files(path)
```

## Typical Workflow Example
A common use case is loading the raw EPIC data and applying a normalization method from the `minfi` package:

```r
library(minfi)
library(minfiDataEPIC)

# Load raw data
data(RGsetEPIC)

# Perform Functional Normalization (or any other minfi method)
# Note: Requires IlluminaHumanMethylationEPICanno.ilm10b2.hg19
Mset.norm <- preprocessFunnorm(RGsetEPIC)

# Extract Beta values
beta_values <- getBeta(Mset.norm)
head(beta_values)
```

## Reference documentation
- [Package Reference Manual](./references/reference_manual.md)