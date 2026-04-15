---
name: bioconductor-lumibarnes
description: This package provides the Barnes benchmark Illumina titration dataset as a LumiBatch object for evaluating microarray processing algorithms. Use when user asks to load the Barnes dataset, benchmark Illumina normalization methods, or analyze blood and placenta tissue titration data.
homepage: https://bioconductor.org/packages/release/data/experiment/html/lumiBarnes.html
---

# bioconductor-lumibarnes

name: bioconductor-lumibarnes
description: Access and use the Barnes benchmark Illumina titration dataset. Use this skill when you need to load, analyze, or benchmark algorithms using the HumanRef-8 BeadChip dataset containing blood and placenta tissue mixtures (titration ratios 100:0 to 0:100).

# bioconductor-lumibarnes

## Overview

The `lumiBarnes` package provides a benchmark dataset for evaluating Illumina microarray processing algorithms. It contains a titration series of two human tissues (blood and placenta) mixed in specific ratios: 100:0, 95:5, 75:25, 50:50, 25:75, and 0:100. Each mixture was hybridized in duplicate on the Illumina HumanRef-8 BeadChip. The data is provided as a `LumiBatch` object, which is compatible with the `lumi` package for preprocessing and analysis.

## Data Loading and Inspection

To use the dataset, you must load the library and call the `data()` function.

```r
library(lumiBarnes)
library(lumi) # Required to handle the LumiBatch object

# Load the dataset
data(lumiBarnes)

# Inspect the object
lumiBarnes
summary(lumiBarnes)

# View sample information (titration ratios)
pData(lumiBarnes)
```

## Typical Workflows

### 1. Benchmarking Preprocessing
Because the titration ratios are known, this dataset is ideal for testing normalization or background correction methods.

```r
# Example: Compare raw vs. normalized data
lumi_norm <- lumiExpresso(lumiBarnes)

# Plotting to see the effect of normalization
plot(lumiBarnes, main="Raw Data")
plot(lumi_norm, main="Normalized Data")
```

### 2. Quality Control
Use standard `lumi` functions to assess the quality of the Barnes dataset.

```r
# Density plot of intensities
plotDensity(lumiBarnes)

# Pairwise sample correlation (MA plots)
plot(lumiBarnes, what='MA')
```

### 3. Accessing Expression and Annotation
The object behaves like an `ExpressionSet`.

```r
# Get expression matrix
exp_matrix <- exprs(lumiBarnes)

# Get probe IDs
probes <- featureNames(lumiBarnes)
```

## Usage Tips
- **Object Class**: The data is stored as a `LumiBatch` object. Ensure the `lumi` package is installed to access all metadata and specialized plotting functions.
- **Probe Filtering**: Note that some probes from the pre-released HumanRef-8 version 1 chip used in the original study were removed in this package to maintain consistency with the public release.
- **Titration Ratios**: The `sampleID` or `pData` typically contains the information regarding which samples correspond to which blood:placenta ratios (e.g., 100:0, 75:25).

## Reference documentation

- [lumiBarnes Reference Manual](./references/reference_manual.md)