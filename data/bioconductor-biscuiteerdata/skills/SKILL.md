---
name: bioconductor-biscuiteerdata
description: This package provides essential genomic datasets and resources required for methylation analysis with the biscuiteer package. Use when user asks to retrieve PMD locations, access solo-WCGW CpG site subsets, or load reference data for methylation normalization.
homepage: https://bioconductor.org/packages/release/data/experiment/html/biscuiteerData.html
---

# bioconductor-biscuiteerdata

## Overview

`biscuiteerData` is a data-only Bioconductor package that provides essential resources for the `biscuiteer` package. It primarily serves as a wrapper for `ExperimentHub`, allowing users to retrieve genomic datasets such as PMD (Partially Methylated Domain) locations and specific CpG site subsets (solo-WCGW) used in methylation analysis.

## Installation

Install the package using `BiocManager`:

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("biscuiteerData")
```

## Data Retrieval Workflow

### 1. List Available Data
To see what datasets are currently available in the package:

```r
library(biscuiteerData)
biscuiteerDataList()
```
Typical output includes:
* `PMDs.hg19.rda` / `PMDs.hg38.rda`: PMD locations for human genome builds.
* `Zhou_solo_WCGW_inCommonPMDs.hg19.rda` / `hg38`: Specific CpG sites for background normalization.

### 2. Load Specific Data
Use `biscuiteerDataGet` to download (if not cached) and load a resource into the R environment:

```r
# Load PMDs for hg19
pmds <- biscuiteerDataGet("PMDs.hg19.rda")

# Load solo-WCGW sites for hg38
wcgw_sites <- biscuiteerDataGet("Zhou_solo_WCGW_inCommonPMDs.hg38.rda")
```

### 3. Versioning and Dates
Datasets are versioned by their upload date. You can check available dates and request specific versions:

```r
# List all upload dates
biscuiteerDataListDates()

# Get a specific version
old_data <- biscuiteerDataGet("PMDs.hg19.rda", dateAdded = "2019-09-25")
```

## Usage Tips
* **Caching**: The first time `library(biscuiteerData)` is called or data is requested, it will interface with `ExperimentHub` to cache files locally. Subsequent calls will be significantly faster.
* **Integration**: These datasets are typically passed into `biscuiteer` functions like `WGBSage` or used for calculating PMD-based methylation metrics.

## Reference documentation

- [biscuiteerData User Guide](./references/biscuiteerData.md)