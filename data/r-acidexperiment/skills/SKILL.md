---
name: r-acidexperiment
description: R package acidexperiment (documentation from project home).
homepage: https://cran.r-project.org/web/packages/acidexperiment/index.html
---

# r-acidexperiment

name: r-acidexperiment
description: Toolkit for extending the functionality of SummarizedExperiment objects in R. Use this skill when performing genomic data analysis that requires advanced manipulation, subsetting, or quality control of SummarizedExperiment-derived objects using the Acid Genomics ecosystem.

# r-acidexperiment

## Overview

`acidexperiment` is an R package designed as a toolkit to extend the functionality of the Bioconductor `SummarizedExperiment` class. It provides a suite of helper functions and methods to streamline the handling of genomic datasets, focusing on improved metadata management, data coercion, and common preprocessing tasks.

## Installation

To install the package from the Acid Genomics repository:

```r
if (!requireNamespace("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}
install.packages(
    pkgs = "AcidExperiment",
    repos = c(
        "https://r.acidgenomics.com",
        BiocManager::repositories()
    ),
    dependencies = TRUE
)
```

## Core Workflows

### Object Extension
The package is primarily used to enhance standard `SummarizedExperiment` objects. It introduces methods that make these objects more compatible with other "acid" suite packages (like `basejump` or `bcbioRNASeq`).

### Common Operations
While specific functions depend on the version, the toolkit typically provides:
- **Metadata Handling**: Simplified access and modification of `colData` and `rowData`.
- **Coercion**: Methods to convert between `SummarizedExperiment` and other common Bioconductor formats.
- **Filtering**: Utilities for removing low-quality samples or features based on experiment-wide metrics.
- **Aggregation**: Functions to aggregate counts or values by specific metadata columns (e.g., collapsing technical replicates).

### Integration with SummarizedExperiment
Since this package extends `SummarizedExperiment`, always ensure the base library is loaded:

```r
library(SummarizedExperiment)
library(AcidExperiment)

# Example: Accessing extended methods on a SummarizedExperiment object
# metrics(se)
# aggregateReplicates(se)
```

## Usage Tips
- **Namespace**: The R package name is `AcidExperiment` (case-sensitive), while the skill and system identifiers often use `r-acidexperiment`.
- **Dependencies**: This package relies heavily on Bioconductor. Ensure `BiocManager` is initialized before attempting operations.
- **Data Integrity**: Use the validation methods provided by the toolkit to ensure that `rowData` and `colData` remain synchronized after complex subsetting operations.

## Reference documentation
- [AcidExperiment Home Page](./references/home_page.md)