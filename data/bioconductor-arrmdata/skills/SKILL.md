---
name: bioconductor-arrmdata
description: This package provides example datasets, including raw Beta values and negative control probe intensities, for Illumina 450k Methylation arrays. Use when user asks to load sample methylation data, access negative control probe matrices, or test normalization algorithms for Infinium HumanMethylation450k arrays.
homepage: https://bioconductor.org/packages/release/data/experiment/html/ARRmData.html
---

# bioconductor-arrmdata

name: bioconductor-arrmdata
description: Access and use the ARRmData Bioconductor package, which provides example datasets for the normalization of Illumina 450k Methylation arrays. Use this skill when a user needs raw Beta values or negative control probe data (green and red channels) for testing methylation normalization algorithms, specifically those related to the ARRm (Adaptive Robust Regression method) normalization.

# bioconductor-arrmdata

## Overview
The `ARRmData` package is an ExperimentData package providing a subset of Illumina Infinium HumanMethylation450k array data. It contains raw Beta values and negative control probe intensities for 36 samples. This dataset is primarily intended for use with normalization methods like those found in the `ARRmNormalization` package.

## Data Loading and Usage
The package contains four primary datasets that can be loaded using the standard R `data()` function.

### Loading the Beta Matrix
The `betaMatrix` contains the Beta values (ranging from 0 to 1) for 485,577 probes across 36 samples.
```r
library(ARRmData)
data(betaMatrix)
# View dimensions: 485577 rows, 36 columns
dim(betaMatrix)
# Column names are sample IDs (e.g., 5621146025_R06C02)
head(colnames(betaMatrix))
```

### Loading Control Probes
Negative control probes are essential for background correction and calculating detection p-values. These are split into green and red channels.
```r
# Green channel negative controls (600 probes)
data(greenControlMatrix)

# Red channel negative controls (600 probes)
data(redControlMatrix)

# Both are data frames with 600 rows and 36 columns
dim(greenControlMatrix)
dim(redControlMatrix)
```

### Sample Names
A character vector of the 36 sample identifiers used across all matrices.
```r
data(sampleNames)
print(sampleNames)
```

## Typical Workflow
This data is typically used as input for the `ARRmNormalization` package or for benchmarking other 450k normalization pipelines.

1. **Load Data**: Load the beta values and the control matrices.
2. **Background Information**: Use the control matrices with functions like `getBackground` (from associated normalization packages) to estimate noise.
3. **Normalization**: Apply `normalizeARRm` or similar functions to the `betaMatrix` using the control data as a reference for technical variation.

## Tips
- **Sample Consistency**: The column names in `betaMatrix`, `greenControlMatrix`, and `redControlMatrix` are identical and correspond to the entries in `sampleNames`.
- **Memory Management**: The `betaMatrix` is large (nearly 500k rows). Ensure your R environment has sufficient RAM when performing operations on this object.
- **Associated Packages**: This package is a data-only package. For the actual normalization functions, you should use the `ARRmNormalization` package.

## Reference documentation
- [ARRmData Reference Manual](./references/reference_manual.md)