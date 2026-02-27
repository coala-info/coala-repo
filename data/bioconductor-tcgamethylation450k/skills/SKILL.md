---
name: bioconductor-tcgamethylation450k
description: This package provides access to example Illumina HumanMethylation450 BeadChip data from The Cancer Genome Atlas for testing methylation analysis workflows. Use when user asks to load example TCGA .idat files, demonstrate methylation data processing with methylumi or minfi, or access sample methylation datasets for R-based experiments.
homepage: https://bioconductor.org/packages/release/data/experiment/html/TCGAMethylation450k.html
---


# bioconductor-tcgamethylation450k

name: bioconductor-tcgamethylation450k
description: Access and use The Cancer Genome Atlas (TCGA) Illumina 450k methylation example data. Use this skill when a user needs to load, inspect, or process example .idat files from the TCGA 450k array platform for methylation analysis workflows in R.

# bioconductor-tcgamethylation450k

## Overview
The `TCGAMethylation450k` package is a Bioconductor data experiment package providing a subset of Illumina HumanMethylation450 BeadChip data from The Cancer Genome Atlas (TCGA). It contains raw `.idat` files intended for demonstrating methylation analysis workflows, particularly those involving the `methylumi` or `minfi` packages.

## Loading the Data
The package does not contain a pre-loaded R object. Instead, it provides the file paths to raw IDAT files.

```r
# Load the library
library(TCGAMethylation450k)

# Locate the directory containing the idat files
idat_dir <- system.file("extdata", "idat", package = "TCGAMethylation450k")

# List the files to verify
list.files(idat_dir)
```

## Typical Workflow: Reading with methylumi
The primary intended use for this data is to be read into a `MethyLumiSet` object using the `methylumi` package.

```r
library(methylumi)

# Get the path to the idat directory
idat_dir <- system.file("extdata", "idat", package = "TCGAMethylation450k")

# Read the IDAT files
# Note: This typically requires a sample sheet or specific barcodes
# For this example package, you can find the barcodes from the filenames
mdata <- methylumIDAT(getBarcodes(idat_dir), idatPath = idat_dir)

# Inspect the object
print(mdata)
```

## Typical Workflow: Reading with minfi
Alternatively, the data can be processed using the `minfi` package.

```r
library(minfi)

# Get the path
idat_dir <- system.file("extdata", "idat", package = "TCGAMethylation450k")

# Read the raw intensity data
targets <- read.metharray.exp(base = idat_dir)

# Preprocess the data (e.g., raw preprocessing)
mset <- preprocessRaw(targets)
```

## Usage Tips
- **Data Scope**: This package is for demonstration and testing. It contains only a small subset of the full TCGA methylation dataset.
- **Dependencies**: To do anything meaningful with this data, you must have `methylumi` or `minfi` installed.
- **File Structure**: The data is stored in `inst/extdata/idat`. Use `system.file` to ensure your code is portable across different R installations.

## Reference documentation
- [TCGAMethylation450k Reference Manual](./references/reference_manual.md)