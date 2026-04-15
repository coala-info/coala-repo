---
name: bioconductor-charmdata
description: This package provides a subsetted dataset of raw Nimblegen files and metadata for practicing DNA methylation microarray analysis with the charm package. Use when user asks to access example methylation microarray data, locate raw .xys files for testing, or follow the charm preprocessing pipeline.
homepage: https://bioconductor.org/packages/3.8/data/experiment/html/charmData.html
---

# bioconductor-charmdata

## Overview
The `charmData` package is a specialized ExperimentData package for Bioconductor. It serves as a companion to the `charm` (CHallenge-ratio Analysis of Methylation Microarrays) package. It provides a small, subsetted dataset including raw Nimblegen `.xys` files and a sample description file, allowing users to practice the full preprocessing and analysis pipeline for DNA methylation microarrays without needing to provide their own large raw data files.

## Usage and Workflows

### Locating the Data
The primary purpose of this package is to provide the file system path to its included raw data. This path is then passed to functions in the `charm` package.

```r
# Load the library
library(charmData)

# Find the directory containing the raw .xys and sample description files
dataDir <- system.file("data", package="charmData")

# List the files to verify (should see .xys files and a sample description file)
list.files(dataDir)
```

### Typical Integration with 'charm'
The data in `charmData` is typically used to initialize a `pdInfo` object or to read raw data into R for tiling array analysis.

```r
library(charm)
library(charmData)

# Set the working directory to the data location
dataDir <- system.file("data", package="charmData")
setwd(dataDir)

# Read the sample description file (usually named 'samples.txt' or similar)
# This is a prerequisite for the readNimblegen function in the charm package
pheno <- read.delim("samples.txt")

# Example of how this data is consumed by the charm package:
# rawData <- readNimblegen(files=pheno$FileName, pdName="pd.charm.hg18.example")
```

## Data Content
- **Raw Data**: 8 sample files in Nimblegen `.xys` format.
- **Metadata**: A sample description file mapping filenames to experimental conditions.
- **Platform**: Based on the `pd.charm.hg18.example` annotation package (Human genome build hg18).

## Tips
- This package does not contain R data objects (like `ExpressionSet`) that are loaded via `data()`. Instead, it contains raw files on disk. Always use `system.file("data", package="charmData")` to find them.
- Ensure the `pd.charm.hg18.example` package is also installed, as the `charm` package requires it to process the specific array geometry provided in `charmData`.

## Reference documentation
- [charmData Reference Manual](./references/reference_manual.md)