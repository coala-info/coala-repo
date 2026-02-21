---
name: bioconductor-ampaffyexample
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/experiment/html/AmpAffyExample.html
---

# bioconductor-ampaffyexample

name: bioconductor-ampaffyexample
description: A specialized skill for working with the Bioconductor experiment data package 'AmpAffyExample'. Use this skill when you need to load, inspect, or analyze the specific AffyBatch dataset containing amplified vs. typical RNA samples for Affymetrix GeneChip arrays.

# bioconductor-ampaffyexample

## Overview
The `AmpAffyExample` package provides a sample dataset (`AmpData`) consisting of six Affymetrix GeneChip arrays. This dataset was specifically designed to evaluate the performance of amplified RNA compared to the standard (typical) RNA labeling procedure. It is primarily used for benchmarking normalization methods, quality control, and differential expression analysis in the context of RNA amplification.

## Loading the Data
To use the dataset, you must load the library and then call the `data()` function.

```r
# Load the package
library(AmpAffyExample)

# Load the AffyBatch object
data(AmpData)

# Inspect the object
AmpData
```

## Dataset Structure
The `AmpData` object is an `AffyBatch` instance (from the `affy` package) containing:
- **6 Arrays**: 3 samples from amplified RNA and 3 samples from the typical procedure.
- **Platform**: Designed for use with `hgu133acdf` (suggested package).

## Typical Workflows

### 1. Quality Control
Since this package is often used to compare amplification protocols, initial QC is essential.
```r
library(affy)
# Simple boxplot of raw intensities
boxplot(AmpData, col=c(rep("blue", 3), rep("red", 3)), main="Amplified (Blue) vs Typical (Red)")

# RNA degradation plot
deg <- AffyRNAdeg(AmpData)
plotAffyRNAdeg(deg)
```

### 2. Normalization and Summarization
You can process the `AffyBatch` object using standard Bioconductor methods like RMA or MAS5.
```r
# Robust Multi-array Average (RMA)
eset <- rma(AmpData)

# Get expression matrix
exp_matrix <- exprs(eset)
```

### 3. Group Comparison
The primary utility of this dataset is comparing the two groups (Amplified vs. Typical).
```r
# Access sample information (if available in phenoData)
pData(AmpData)

# Example: Manual grouping if phenoData is sparse
group <- c(rep("Amplified", 3), rep("Typical", 3))
```

## Tips
- Ensure the `affy` package is installed, as `AmpData` is an `AffyBatch` object and requires `affy` methods for manipulation.
- The dataset is relatively small (6 arrays), making it ideal for quick demonstrations of microarray preprocessing pipelines.

## Reference documentation
- [AmpAffyExample Reference Manual](./references/reference_manual.md)