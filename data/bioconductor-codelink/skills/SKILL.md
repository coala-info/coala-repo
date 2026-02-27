---
name: bioconductor-codelink
description: The codelink package provides tools for the preprocessing, normalization, and quality control analysis of Codelink microarray data. Use when user asks to read Codelink text files into Bioconductor objects, perform background correction and normalization, or generate diagnostic plots for oligonucleotide platforms.
homepage: https://bioconductor.org/packages/release/bioc/html/codelink.html
---


# bioconductor-codelink

## Overview

The `codelink` package provides tools for the preprocessing and analysis of Codelink microarrays (30-base oligonucleotide platforms). It facilitates the transition from proprietary software exports to Bioconductor-compatible objects, specifically the `CodelinkSet` class (which inherits from `ExpressionSet`). This allows for seamless integration with downstream analysis tools like `limma`.

## Typical Workflow

### 1. Data Loading
The primary function for modern workflows is `readCodelinkSet()`. It requires plain text files exported from Codelink software.

```R
library(codelink)

# Read all TXT files in the current directory
f <- list.files(pattern = "TXT")
codset <- readCodelinkSet(filename = f)

# Recommended: Use a targets file for phenotypic data
pdata <- read.AnnotatedDataFrame("targets.txt")
codset <- readCodelinkSet(filename = pdata$FileName, phenoData = pdata)
```

### 2. Background Correction
Use `codCorrect()` to handle background noise. Methods include "none", "subtract", "half" (default), and "normexp".

```R
# 'normexp' is often recommended for better sensitivity
codset <- codCorrect(codset, method = "normexp", offset = 50)
```

### 3. Normalization
Use `codNormalize()` (or the alias `normalize()`) to make samples comparable. Supported methods include "quantile" (default), "median", and "loess".

```R
# Quantile normalization
codset <- codNormalize(codset, method = "quantile")

# Loess normalization using probe weights
codset <- codNormalize(codset, method = "loess", weights = getWeight(codset))
```

### 4. Diagnostic Plotting
The `codPlot()` function is a unified interface for quality control.

```R
# MA plot (default)
codPlot(codset, what = "ma")

# Density plot
codPlot(codset, what = "density")

# Spatial pseudo-image (requires Logical row/col columns in source files)
codPlot(codset, what = "image")
```

### 5. Differential Expression with limma
`CodelinkSet` objects are compatible with `limma`. You can utilize the weights generated during data reading to improve model fit.

```R
library(limma)

# Define design and fit model
design <- model.matrix(~ condition, data = pData(codset))
fit <- lmFit(codset, design = design, weights = getWeight(codset))
fit2 <- eBayes(fit)
topTable(fit2)
```

## Key Functions and Accessors

- `exprs(codset)`: Access signal intensities.
- `getBkg(codset)`: Access background intensities.
- `getSNR(codset)`: Access Signal-to-Noise Ratio values.
- `getFlag(codset)`: Access quality flags (G=Good, L=Limit, S=Saturated, I=Irregular, M=MSR).
- `getWeight(codset)`: Access calculated probe weights (0 to 1).
- `createWeights()`: Manually re-calculate weights based on flags and probe types.

## Tips and Best Practices

- **Export Requirements**: Ensure exported text files include "Spot mean", "Bkgd median", and "Bkgd stdev" to allow for full R-based preprocessing.
- **Flag Handling**: By default, only 'M' (MSR) flags are converted to NA. Other flags are handled via the weighting system (0 for poor quality, 1 for good).
- **Legacy Support**: If working with older `Codelink` class objects, use `Codelink2CodelinkSet()` to convert them to the modern `CodelinkSet` format.
- **Probe Types**: The package recognizes DISCOVERY, POSITIVE, NEGATIVE, FIDUCIAL, and OTHER probe types. Weights are automatically set to 0 for non-discovery probes by default.

## Reference documentation

- [Introduction to the Codelink package](./references/Codelink_Introduction.md)
- [Codelink Legacy: the old Codelink class](./references/Codelink_Legacy.md)