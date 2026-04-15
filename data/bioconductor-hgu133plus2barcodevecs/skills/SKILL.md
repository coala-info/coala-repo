---
name: bioconductor-hgu133plus2barcodevecs
description: This package provides pre-computed parameter estimates for the barcode R package to analyze Affymetrix Human Genome U133 Plus 2.0 microarrays. Use when user asks to perform gene expression barcoding, estimate the probability of expression for HGU133Plus2 probesets, or load the bcparams-GPL570 dataset for the barcode package.
homepage: https://bioconductor.org/packages/release/data/experiment/html/hgu133plus2barcodevecs.html
---

# bioconductor-hgu133plus2barcodevecs

name: bioconductor-hgu133plus2barcodevecs
description: Provides data and parameter estimates for the 'barcode' R package specifically for Affymetrix Human Genome U133 Plus 2.0 (hgu133plus2) microarrays. Use this skill when performing gene expression barcoding, estimating the probability of expression (on/off) for HGU133Plus2 probesets, or when the 'barcode' package requires the 'bcparams-GPL570' dataset.

# bioconductor-hgu133plus2barcodevecs

## Overview
The `hgu133plus2barcodevecs` package is an annotation/data package for Bioconductor. It contains the pre-computed parameter estimates (mu and tau) required by the `barcode` function in the `frma` or `barcode` packages to convert absolute expression values from Affymetrix Human Genome U133 Plus 2.0 arrays into binary "expressed" or "unexpressed" states.

## Usage Guidance

### Loading the Data
The package primarily serves as a data container. The main dataset is `bcparams-GPL570`, which corresponds to the GEO platform ID for the HGU133 Plus 2.0 array.

```r
# Load the package
library(hgu133plus2barcodevecs)

# Load the specific parameter matrix
data("bcparams-GPL570")

# View the structure of the parameters
head(`bcparams-GPL570`)
```

### Integration with the barcode Package
This package is rarely used in isolation. It is typically called internally or specified as an argument when using the `barcode` package to analyze HGU133 Plus 2.0 data.

```r
library(barcode)
library(hgu133plus2barcodevecs)

# Assuming 'expression_matrix' is a matrix of fRMA-processed expression values
# for HGU133 Plus 2.0 arrays
bc_results <- barcode(expression_matrix, platform="GPL570")
```

### Data Format
The `bcparams-GPL570` object is a matrix where:
- Rows represent probesets.
- Columns contain the estimated parameters used to define the distribution of "unexpressed" genes, allowing for the calculation of the probability that a gene is expressed.

## Workflow Tips
1. **Platform Matching**: Ensure your data is from the HGU133 Plus 2.0 array (GPL570). Using these vectors on other platforms (like HGU133A) will result in incorrect biological interpretations.
2. **Preprocessing**: The barcode method is designed to work with normalized data, typically processed via `frma` (Frozen Robust Multi-array Analysis).
3. **Automatic Loading**: In most modern Bioconductor workflows, if you specify the platform in the `barcode()` function, R will attempt to load this package automatically if it is installed.

## Reference documentation
- [hgu133plus2barcodevecs Reference Manual](./references/reference_manual.md)