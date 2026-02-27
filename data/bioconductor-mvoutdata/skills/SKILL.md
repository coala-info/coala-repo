---
name: bioconductor-mvoutdata
description: This package provides curated Affymetrix and Illumina microarray datasets specifically designed for benchmarking outlier detection algorithms. Use when user asks to access raw expression data for evaluating outlier detection performance, load the s12c AffyBatch dataset with known contamination, or use the ILM1 LumiBatch dataset for quality control testing.
homepage: https://bioconductor.org/packages/release/data/experiment/html/mvoutData.html
---


# bioconductor-mvoutdata

name: bioconductor-mvoutdata
description: Access and use the mvoutData experiment data package for evaluating outlier detection algorithms in microarray data. Use this skill when you need raw Affymetrix (AffyBatch) or Illumina (LumiBatch) expression data specifically curated for benchmarking outlier detection performance, including known contaminated samples.

# bioconductor-mvoutdata

## Overview
The `mvoutData` package provides curated raw microarray datasets designed for assessing the performance of outlier detection algorithms. It includes two primary datasets: `s12c` (Affymetrix SpikeIn U133a data with intentional contamination) and `ILM1` (Illumina MAQC study data). These datasets serve as gold standards for testing whether a statistical method can correctly identify technical artifacts or outliers in high-dimensional expression data.

## Installation
To use this data, ensure the package is installed via BiocManager:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("mvoutData")
```

## Loading and Using Data
The package contains two main datasets that can be loaded using the `data()` function.

### Affymetrix Outlier Data (s12c)
The `s12c` object is an `AffyBatch` object. It is derived from the SpikeIn U133a dataset.
- **Contamination**: The first two samples in this dataset are known to be contaminated.
- **Usage**: Use this to test if an outlier detection function (like those in `affyPLM` or `outliers`) flags the first two arrays.

```r
library(mvoutData)
data(s12c)

# View object summary
print(s12c)

# Example: Simple visualization to look for outliers
library(affy)
boxplot(s12c, main="Boxplot of s12c AffyBatch")
```

### Illumina Outlier Data (ILM1)
The `ILM1` object is a `LumiBatch` object (created via `lumi::lumiR`). It contains data from 19 arrays supplied by Illumina Inc. for the MAQC (MicroArray Quality Control) study.

```r
library(mvoutData)
data(ILM1)

# View object summary
print(ILM1)

# Access expression matrix
exprs_data <- Biobase::exprs(ILM1)
```

## Typical Workflow
1. **Load the library**: `library(mvoutData)`
2. **Load the target dataset**: `data(s12c)` or `data(ILM1)`
3. **Apply outlier detection**: Run your specific algorithm (e.g., PCA-based detection, arrayQualityMetrics, or robust MD) on the loaded object.
4. **Validate**: Check if the algorithm identifies the first two samples of `s12c` as outliers.

## Reference documentation
- [mvoutData Reference Manual](./references/reference_manual.md)