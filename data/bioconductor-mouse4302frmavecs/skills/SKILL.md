---
name: bioconductor-mouse4302frmavecs
description: This package provides frozen parameter vectors for the Affymetrix Mouse Genome 430 2.0 Array. Use when user asks to perform frozen Robust Multi-array Analysis, estimate gene expression barcodes, or normalize mouse4302 microarray data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/mouse4302frmavecs.html
---


# bioconductor-mouse4302frmavecs

name: bioconductor-mouse4302frmavecs
description: Provides frozen parameter vectors for the Affymetrix Mouse Genome 430 2.0 Array (mouse4302). Use this skill when performing Frozen Robust Multi-array Analysis (fRMA) or Gene Expression Barcoding on mouse4302 microarray data to ensure consistent normalization and expression estimation across different datasets.

# bioconductor-mouse4302frmavecs

## Overview
The `mouse4302frmavecs` package is a Bioconductor data package containing frozen parameter vectors for the Mouse Genome 430 2.0 Array. These vectors are essential for using the `frma` (Frozen Robust Multi-array Analysis) and `barcode` functions. Unlike standard RMA, which requires all chips to be processed together, fRMA uses these pre-calculated vectors to allow arrays to be processed individually or in small batches while maintaining comparability with other datasets.

## Usage

This package is typically used in conjunction with the `frma` package. The data objects are loaded automatically when calling `frma()` on a compatible dataset, but they can also be loaded manually for inspection or specific workflows.

### Loading Data Objects
The package provides three primary data objects:
- `mouse4302frmavecs`: Vectors for the standard Affymetrix CDF.
- `mouse4302barcodevecs`: Vectors for the Gene Expression Barcode algorithm.
- `mouse4302mmentrezgfrmavecs`: Vectors for the Entrez Gene alternative CDF version.

```r
library(mouse4302frmavecs)

# Load fRMA vectors
data(mouse4302frmavecs)
str(mouse4302frmavecs)

# Load Barcode vectors
data(mouse4302barcodevecs)
str(mouse4302barcodevecs)
```

### Typical Workflow with frma
To analyze Mouse 430 2.0 arrays using fRMA:

```r
library(frma)
library(mouse4302frmavecs)
# Assuming 'affyBatch' is your loaded .CEL data
# fRMA will automatically detect and use the mouse4302 vectors
eset <- frma(affyBatch)
```

### Using the Barcode Function
The barcode function provides a way to estimate which genes are "expressed" vs "unexpressed" based on the background distribution parameters stored in this package.

```r
library(frma)
data(mouse4302barcodevecs)
# 'eset' is the output from frma()
bc <- barcode(eset)
```

## Key Components
- **normVec**: The frozen normalization vector used for quantile normalization.
- **probeVec**: The frozen probe effect vector.
- **probeVarWithin/Between**: Variance components used to calculate weights and standard errors.
- **mu/tau**: Background mean and standard deviation used by the barcode function to determine expression states.

## Tips
- Ensure the `AffyBatch` or `FeatureSet` object is specifically for the `mouse4302` platform.
- If you are using alternative CDFs (like Entrez Gene), ensure you load the corresponding `mmentrezg` version of the vectors.
- These vectors are based on version 3.0 of the Gene Expression Barcode database.

## Reference documentation
- [mouse4302frmavecs Reference Manual](./references/reference_manual.md)