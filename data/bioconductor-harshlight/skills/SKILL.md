---
name: bioconductor-harshlight
description: This tool detects and corrects spatial artifacts such as extended, diffuse, and compact blemishes in Affymetrix microarray data. Use when user asks to identify spatial defects in AffyBatch objects, mask microarray blemishes, or perform quality control on Affymetrix chips before normalization.
homepage: https://bioconductor.org/packages/release/bioc/html/Harshlight.html
---


# bioconductor-harshlight

name: bioconductor-harshlight
description: Detects and corrects spatial artifacts (blemishes) in Affymetrix microarray data. Use this skill when analyzing AffyBatch objects to identify and mask extended, diffuse, or compact defects before performing normalization and downstream analysis.

# bioconductor-harshlight

## Overview
Harshlight is a quality control tool for Affymetrix microarrays. It automatically detects three types of spatial artifacts:
1.  **Extended blemishes**: Large areas of the chip affected by physical defects.
2.  **Diffuse blemishes**: Low-intensity clouds or halos.
3.  **Compact blemishes**: Small, localized clusters of outliers.

The package identifies these defects and returns a corrected `AffyBatch` object where the affected probe intensities are replaced either by `NA` or by the median value of the same probe across other chips in the batch.

## Installation
```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("Harshlight")
```

## Core Workflow

### 1. Load Data
Harshlight operates on `AffyBatch` objects, typically created using the `affy` package.
```r
library(affy)
library(Harshlight)

# Load CEL files
raw_data <- ReadAffy()
```

### 2. Run Blemish Detection
The primary function is `Harshlight()`. It processes the entire `AffyBatch`.

```r
# Basic usage: Replace defects with the median value of other chips
corrected_data <- Harshlight(raw_data, report = TRUE)

# Alternative: Replace defects with NA
corrected_data_na <- Harshlight(raw_data, na = TRUE)
```

### 3. Parameters and Customization
- `affybatch`: The input `AffyBatch` object.
- `report`: If `TRUE`, prints a summary of detected blemishes for each chip.
- `compact`, `diffuse`, `extended`: Boolean flags (default `TRUE`) to toggle detection of specific blemish types.
- `na`: If `TRUE`, outliers are set to `NA`. If `FALSE` (default), outliers are substituted with the median value of the same probe across all other chips in the `AffyBatch`.

### 4. Downstream Analysis
After running Harshlight, you can proceed with standard normalization methods like RMA or MAS5. Note that if you used `na = TRUE`, ensure your normalization function handles `NA` values.

```r
# Example: RMA normalization on corrected data
eset <- rma(corrected_data)
```

## Usage Tips
- **Memory Management**: Harshlight processes chips sequentially. For very large batches, ensure sufficient RAM is available as it creates a modified copy of the `AffyBatch`.
- **Batch Size**: When using `na = FALSE` (median substitution), the quality of the replacement depends on having a sufficient number of chips in the `AffyBatch` to calculate a reliable median.
- **Visual Inspection**: It is often helpful to use the `image()` function from the `affy` package before and after Harshlight to visualize the impact of the correction.

## Reference documentation
- [Harshlight Bioconductor Page](https://bioconductor.org/packages/release/bioc/html/Harshlight.html)