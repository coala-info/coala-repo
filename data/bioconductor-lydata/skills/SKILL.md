---
name: bioconductor-lydata
description: This tool provides access to raw microarray datasets for the compound LY294002 from the Gene Expression Omnibus. Use when user asks to load example microarray data, locate raw data files for cross-platform meta-analysis, or demonstrate workflows using the crossmeta package.
homepage: https://bioconductor.org/packages/release/data/experiment/html/lydata.html
---

# bioconductor-lydata

name: bioconductor-lydata
description: Provides access to the 'lydata' Bioconductor experiment data package. Use this skill when you need to load or analyze the example microarray datasets for the compound LY294002, specifically for demonstrating cross-platform meta-analysis workflows using the 'crossmeta' package.

# bioconductor-lydata

## Overview
The `lydata` package is an ExperimentData package containing raw microarray data downloaded from the Gene Expression Omnibus (GEO) for the compound LY294002. It includes data from multiple platforms (Affymetrix and Illumina) and serves as the primary example dataset for illustrating cross-platform meta-analysis of microarray data using the `crossmeta` R package.

## Installation and Loading
To use the data in an R session, ensure the package is installed via BiocManager:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("lydata")
library(lydata)
```

## Typical Workflow
The primary purpose of this package is to provide a file path to the raw data so it can be processed by `crossmeta`.

### Locating Raw Data
The raw data files are stored within the package installation directory. You can locate the path to these files using `system.file`:

```r
# Get the path to the raw data directory
data_dir <- system.file("extdata", package = "lydata")

# List the contents to see available GEO series (e.g., GSEs)
list.files(data_dir)
```

### Integration with crossmeta
The typical next step is to use the identified directory as input for `crossmeta` functions like `get_raw` or `load_raw`:

```r
library(crossmeta)

# Example: Loading the raw data from the lydata directory
# (Assuming a crossmeta workflow)
# raw_data <- load_raw(data_dir)
```

## Data Contents
The package contains raw data for the PI3K inhibitor LY294002 across different platforms:
- Affymetrix platforms (e.g., HG-U133 Plus 2)
- Illumina platforms
- Multiple GEO series accessions representing different studies of the same compound.

## Tips
- This package does not contain processed `ExpressionSet` objects directly in `data()`; it provides the raw files (CEL files for Affymetrix, etc.) in the `inst/extdata` folder to simulate a real-world meta-analysis starting point.
- Always use `system.file("extdata", package = "lydata")` to ensure your scripts are portable across different R installations.

## Reference documentation
- [Reference Manual](./references/reference_manual.md)