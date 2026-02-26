---
name: bioconductor-arrmnormalization
description: This tool performs adaptive robust regression normalization for Illumina Infinium HumanMethylation450 BeadChip data to correct for background intensity, dye bias, and spatial effects. Use when user asks to normalize DNA methylation Beta values, correct for technical variation in 450k arrays without assuming identical distributions, or perform robust regression-based normalization for tumor-normal comparisons.
homepage: https://bioconductor.org/packages/release/bioc/html/ARRmNormalization.html
---


# bioconductor-arrmnormalization

name: bioconductor-arrmnormalization
description: Adaptive Robust Regression method (ARRm) for normalization of Illumina Infinium HumanMethylation450 BeadChip data. Use this skill to correct for background intensity, dye bias, and spatial effects in methylation Beta values without assuming identical distributions across samples.

# bioconductor-arrmnormalization

## Overview

The `ARRmNormalization` package provides a robust regression-based approach to normalize DNA methylation data from the Illumina 450k platform. Unlike quantile normalization, ARRm does not force distributions to be identical across samples, making it suitable for studies where global methylation differences are expected (e.g., tumor vs. normal comparisons or aging studies). It treats Infinium I and II probes separately and explicitly corrects for background intensity, dye bias, and spatial (on-chip position) effects.

## Typical Workflow

### 1. Data Preparation
The package requires four primary inputs:
- `betaMatrix`: A matrix of Beta values (rows = probes, columns = samples).
- `greenControlMatrix`: Intensities of negative control probes in the green channel.
- `redControlMatrix`: Intensities of negative control probes in the red channel.
- `sampleNames`: A vector of sample identifiers.

```r
library(ARRmNormalization)
library(ARRmData) # For example data

# Load your data or example data
data(betaMatrix)
data(greenControlMatrix)
data(redControlMatrix)
data(sampleNames)
```

### 2. Pre-normalization Information Extraction
Before normalization, you must extract background and design information.

```r
# Extract background medians for green and red channels
backgroundInfo <- getBackground(greenControlMatrix, redControlMatrix)

# Extract chip and position info (requires sample names in Illumina format: 'Barcode_RxxCxx')
designInfo <- getDesignInfo(sampleNames)

# Alternatively, provide manual vectors if names are not in Illumina format
# designInfo <- getDesignInfo(sampleNames=NULL, positionVector=posVec, chipVector=chipVec)
```

### 3. Normalization
The `normalizeARRm` function performs the core normalization.

```r
normMatrix <- normalizeARRm(
  betaMatrix = betaMatrix,
  designInfo = designInfo,
  backgroundInfo = backgroundInfo,
  outliers.perc = 0.02,      # Percentage of outliers to trim (default 2%)
  chipCorrection = TRUE,     # Set to FALSE if chips are confounded with biology
  goodProbes = NULL          # Optional: vector of probe names to include
)
```

## Visualization and Quality Control

To investigate the effects of normalization or identify biases, use the quantile-based plotting tools.

### Extract Quantiles
```r
# Compute percentiles for green, red, and Type II probes
quantiles <- getQuantiles(betaMatrix)
```

### Generate Diagnostic Plots
These functions generate PDF files in the working directory.
- `quantilePlots(quantiles, backgroundInfo, designInfo)`: Visualizes background and dye bias effects.
- `positionPlots(quantiles, designInfo, percentiles=c(25, 50, 75))`: Visualizes spatial/positional deviations.

### Inspect Regression Coefficients
```r
# Extract the actual bias estimates used for correction
coefficients <- getCoefficients(quantiles, designInfo, backgroundInfo)
# Access specific effects, e.g., dye bias for Type II probes:
# coefficients$II$dyebias.vector
```

## Tips and Best Practices
- **Confounding**: If samples were assigned to chips based on biological groups (e.g., all cases on Chip 1, all controls on Chip 2), set `chipCorrection = FALSE` to avoid removing biological signal.
- **Probe Filtering**: Use the `goodProbes` parameter to exclude probes with SNPs, probes on sex chromosomes, or probes that failed QC before running the normalization.
- **Memory**: For very large datasets, ensure you have sufficient RAM as the package processes the full 450k probe set.

## Reference documentation
- [ARRmNormalization](./references/ARRmNormalization.md)