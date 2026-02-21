---
name: bioconductor-illuminadatatestfiles
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/experiment/html/IlluminaDataTestFiles.html
---

# bioconductor-illuminadatatestfiles

name: bioconductor-illuminadatatestfiles
description: Provides access to example Illumina microarray output files (IDAT) for testing and development. Use this skill when you need to locate, load, or test parsers (like illuminaio) with various IDAT file formats, including both encrypted and unencrypted versions.

# bioconductor-illuminadatatestfiles

## Overview
The `IlluminaDataTestFiles` package is a specialized data experiment package in Bioconductor. It does not contain complex analysis functions; instead, it serves as a repository of raw Illumina microarray data files (IDAT format). These files are primarily used by developers and researchers to test IDAT parsing utilities, such as those found in the `illuminaio` package, ensuring they can handle different versions and encryption states of Illumina data.

## Installation and Loading
To use the test files in an R session:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("IlluminaDataTestFiles")
library(IlluminaDataTestFiles)
```

## Locating Test Files
Since this package is a data container, the primary workflow involves locating the physical path of the IDAT files on your system to pass them to a reader function.

### Listing available files
Use `system.file` to find the directory where the data is stored:

```r
# Locate the extdata directory within the package
data_dir <- system.file("extdata", package = "IlluminaDataTestFiles")

# List all IDAT files available
idat_files <- list.files(data_dir, pattern = "\\.idat$", recursive = TRUE, full.names = TRUE)
print(idat_files)
```

### Identifying specific file types
The package contains files from different sources:
- **Encrypted IDATs**: Typically from newer Illumina platforms (e.g., HiSeq, newer BeadChips).
- **Unencrypted IDATs**: Typically from older platforms.

## Typical Workflow: Testing a Parser
The most common use case is testing the `illuminaio` package or similar parsers:

```r
library(illuminaio)
library(IlluminaDataTestFiles)

# Get the path to a specific test file
idat_path <- system.file("extdata", "idat", "example.idat", package = "IlluminaDataTestFiles")

# Read the file metadata and intensity data
idat_data <- readIDAT(idat_path)

# Inspect the structure
str(idat_data)
```

## Tips
- **File Paths**: Always use `system.file()` to ensure your code is portable across different machines where the R library might be installed in different locations.
- **Purpose**: Do not use this package for biological inference; the data is strictly for software testing and benchmarking.
- **Dependencies**: This package is often used in conjunction with `illuminaio`. If you are trying to process these files, ensure `illuminaio` is also installed.

## Reference documentation
- [IlluminaDataTestFiles Reference Manual](./references/reference_manual.md)