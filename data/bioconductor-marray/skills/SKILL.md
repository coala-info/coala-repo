---
name: bioconductor-marray
description: This package provides tools for the pre-processing, diagnostic visualization, and normalization of two-color spotted microarray data. Use when user asks to read image analysis output, perform exploratory data analysis with MA-plots or boxplots, and normalize cDNA microarray intensities using loess or scale adjustment.
homepage: https://bioconductor.org/packages/release/bioc/html/marray.html
---


# bioconductor-marray

name: bioconductor-marray
description: Expert guidance for the Bioconductor R package 'marray'. Use this skill when performing exploratory analysis, diagnostic plotting, and normalization of two-color cDNA microarray data. It covers reading image analysis output (Spot, GenePix), managing microarray object classes (marrayRaw, marrayNorm), and performing robust local regression (loess) normalization.

# bioconductor-marray

## Overview

The `marray` package is a comprehensive suite for the pre-processing of two-color spotted microarray data. It provides specialized data structures to coordinate probe annotation, target samples, and layout parameters with fluorescence intensities. The package is primarily used for:
1. **Data Input**: Reading output from image analysis software (e.g., `.spot`, `.gpr`).
2. **Diagnostic Visualization**: Identifying spatial, intensity, or print-tip biases via images, boxplots, and MA-plots.
3. **Normalization**: Correcting dye biases using robust local regression (loess) and scale adjustment (MAD).

## Typical Workflow

### 1. Data Loading and Object Creation
The package uses `marrayRaw` objects to store pre-normalization data.

```r
library(marray)

# Define directory containing data
datadir <- system.file("swirldata", package="marray")

# 1. Read target/sample information
targets <- read.marrayInfo(file.path(datadir, "SwirlSample.txt"))

# 2. Read probe/layout information (e.g., from a .gal file)
galinfo <- read.Galfile("fish.gal", path=datadir)

# 3. Read raw intensities (Spot, GenePix, or generic)
# read.Spot and read.GenePix are wrappers for read.marrayRaw
mraw <- read.Spot(targets = targets, path = datadir, 
                  layout = galinfo$layout, 
                  gnames = galinfo$gnames)
```

### 2. Quality Assessment (Diagnostic Plots)
Before normalization, visualize the data to identify artifacts.

```r
# Spatial image of background intensities
image(mraw[,1], xvar="maGb") 

# Boxplots of log-ratios (M) stratified by print-tip group
boxplot(mraw[,1], xvar="maPrintTip", yvar="maM")

# Standard MA-plot (M = log2(R/G) vs A = log2(sqrt(R*G)))
plot(mraw[,1])
```

### 3. Normalization
Convert `marrayRaw` to `marrayNorm` using `maNorm`.

```r
# Within-print-tip loess normalization (most common)
normdata <- maNorm(mraw, norm="printTipLoess")

# Global median normalization
norm_med <- maNorm(mraw, norm="median")

# Scale normalization (MAD)
norm_scale <- maNormScale(normdata, norm="printTipMAD")
```

### 4. Downstream Integration
Export data or convert to `ExpressionSet` for use in other Bioconductor packages like `limma`.

```r
# Export to file
write.marray(normdata, file="normalized_data.txt")

# Convert for limma/Biobase
library(convert)
eset <- as(normdata, "ExpressionSet")
```

## Key Classes and Accessors

- **marrayLayout**: Contains array geometry (`maNgr`, `maNgc`, `maNsr`, `maNsc`).
- **marrayInfo**: Contains metadata for probes or targets (`maLabels`, `maInfo`).
- **marrayRaw**: Raw intensities (`maRf`, `maGf`, `maRb`, `maGb`).
- **marrayNorm**: Normalized data (`maM` for log-ratios, `maA` for average intensities).

**Accessing Slots**: Use accessor functions rather than `@` for stability.
- `maLayout(mraw)`
- `maGnames(mraw)`
- `maM(normdata)`

## Tips for Success
- **Subsetting**: Use `mraw[spots, arrays]` syntax. For example, `mraw[1:100, 2]` selects the first 100 spots of the second array.
- **Color Palettes**: Use `maPalette(low="green", high="red", mid="yellow")` to create custom heatmaps for MA-plots or spatial images.
- **Control Spots**: Ensure control status is correctly assigned in the `maControls` slot of the layout to use them specifically during normalization via the `subset` argument in `maNorm`.

## Reference documentation

- [Quick start guide for marray](./references/marray.md)
- [Classes structure component](./references/marrayClasses.md)
- [Classes structure component (short)](./references/marrayClassesShort.md)
- [Input component](./references/marrayInput.md)
- [Normalization component](./references/marrayNorm.md)
- [Plotting component](./references/marrayPlots.md)