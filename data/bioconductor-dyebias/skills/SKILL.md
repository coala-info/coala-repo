---
name: bioconductor-dyebias
description: This tool corrects gene-specific dye bias in two-color microarray data using the GASSCO method. Use when user asks to estimate intrinsic gene-specific dye bias, apply slide-specific bias correction, or visualize dye bias reduction in marray objects.
homepage: https://bioconductor.org/packages/release/bioc/html/dyebias.html
---


# bioconductor-dyebias

name: bioconductor-dyebias
description: Correct gene-specific dye bias in two-color microarray data using the GASSCO method. Use this skill when working with R marray objects to remove persistent dye artifacts that standard LOESS normalization cannot address.

# bioconductor-dyebias

## Overview

The `dyebias` package implements the GASSCO (Gene-specific dye bias correction) method to correct for gene-specific dye bias in two-channel microarray data. Unlike standard LOESS normalization which handles intensity-dependent bias, GASSCO addresses bias that varies per reporter (probe) and per hybridization.

The workflow consists of two main phases:
1. **Estimation**: Calculating the Intrinsic Gene Specific Dye Bias (iGSDB) using self-self or dye-swapped hybridizations.
2. **Correction**: Estimating the slide-specific bias and applying the correction to the data.

## Core Workflow

### 1. Data Preparation
The package primarily works with `marrayRaw` and `marrayNorm` objects. Ensure your data is properly normalized (e.g., LOESS) before applying GASSCO.

```r
library(marray)
library(dyebias)

# Note: For estimation, do NOT undo dye-swaps. 
# The orientation must reflect the actual physical dyes used.
```

### 2. Estimating iGSDB
The iGSDB represents the inherent bias of a specific probe sequence.

**Balanced Design (Dye-swaps or Self-Self):**
```r
iGSDBs <- dyebias.estimate.iGSDBs(data.norm, is.balanced=TRUE)
```

**Unbalanced Design:**
Uses `limma` to estimate biases.
```r
iGSDBs <- dyebias.estimate.iGSDBs(data.norm, 
                                  is.balanced=FALSE, 
                                  reference="input")
```

### 3. Defining Subsets
Identify which reporters should be used to estimate slide bias and which should be corrected.

```r
# Identify 'Experimental' probes to use as estimators
estimator.subset <- (maInfo(maGnames(data.norm))$reporter.group == "Experimental")

# Filter for quality (Signal-to-Noise Ratio and Intensity)
application.subset <- dyebias.application.subset(data.raw=data.raw,
                                                 min.SNR=1.5,
                                                 maxA=15,
                                                 use.background=TRUE)
```

### 4. Applying Correction
Apply the calculated iGSDB to the dataset.

```r
correction <- dyebias.apply.correction(data.norm=data.norm,
                                       iGSDBs=iGSDBs,
                                       estimator.subset=estimator.subset,
                                       application.subset=application.subset)

# Access corrected data
corrected.marray <- correction$data.corrected
# View variance reduction statistics
print(correction$summary)
```

## Visualization and Validation

Use these functions to compare data before and after correction. If the correction is successful, the red and green biased populations should converge.

### RG Plot
```r
layout(matrix(1:2, nrow=1))
dyebias.rgplot(data=data.norm, slide=1, iGSDBs=iGSDBs, main="Uncorrected")
dyebias.rgplot(data=correction$data.corrected, slide=1, iGSDBs=iGSDBs, main="Corrected")
```

### Boxplot (Slide Bias Overview)
```r
dyebias.boxplot(data=correction$data.corrected, 
                iGSDBs=iGSDBs, 
                application.subset=application.subset)
```

### Trend Plot
Visualizes the linearity of the dye bias across slides.
```r
dyebias.trendplot(data=correction$data.corrected, iGSDBs=iGSDBs)
```

## Implementation Tips

- **Normalization**: GASSCO is a "fine-tuning" normalization. Always perform standard normalization (like LOESS) first.
- **A-values**: If your data only contains M-values (log-ratios), you can "invent" A-values (average intensities) by sampling from a uniform distribution (e.g., 2 to 15) to allow the plotting routines to function.
- **Dye Swaps**: Ensure that the `maM` values reflect the actual Cy5/Cy3 ratio of the physical slide during the estimation phase.
- **Sample Size**: While 12+ hybridizations are ideal for estimating iGSDB, the method is robust enough to work with as few as 4.

## Reference documentation
- [Correcting gene specific dye bias](./references/dyebias-vignette.md)