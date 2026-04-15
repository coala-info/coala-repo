---
name: bioconductor-italics
description: The ITALICS package implements an iterative method to normalize Affymetrix SNP arrays by estimating biological signals and non-relevant variations. Use when user asks to normalize Affymetrix 100K or 500K SNP arrays, estimate copy number alterations, or perform iterative normalization and segmentation of genomic data.
homepage: https://bioconductor.org/packages/release/bioc/html/ITALICS.html
---

# bioconductor-italics

## Overview

The `ITALICS` package implements an iterative method to normalize Affymetrix SNP arrays (100K and 500K sets). It addresses the challenge where biological signals (copy number alterations) and non-relevant variations (biases) have similar amplitudes. The method alternatively estimates the biological signal using the `GLAD` algorithm and the non-relevant effects using multiple linear regression.

## Workflow: Normalizing a Chip

The standard workflow involves loading the CEL file, retrieving SNP/Quartet information, and running the iterative normalization.

### 1. Data Preparation
You must load the CEL file and associated quartet effect data (often provided by `ITALICSData`).

```r
library(ITALICS)
library(ITALICSData)

# Define paths
filename <- system.file("extdata/HF0844_Xba.CEL", package="ITALICSData")
quartetEffectFile <- system.file("extdata/Xba.QuartetEffect.csv", package="ITALICSData")

# Get chip type and metadata
headdetails <- readCelHeader(filename)
pkgname <- cleanPlatformName(headdetails[["chiptype"]])

# Load SNP and Quartet info
snpInfo <- getSnpInfo(pkgname)
quartet <- getQuartet(pkgname, snpInfo)
quartetEffect <- read.table(quartetEffectFile, sep=";", header=TRUE)

# Read intensities and merge info
tmpExprs <- readCelIntensities(filename, indices=quartet$fid)
quartet$quartetInfo$quartetLogRatio <- readQuartetCopyNb(tmpExprs)
quartet$quartetInfo <- addInfo(quartet, quartetEffect)
snpInfo <- fromQuartetToSnp(cIntensity="quartetLogRatio", 
                            quartetInfo=quartet$quartetInfo, 
                            snpInfo=snpInfo)
```

### 2. Running ITALICS
The `ITALICS` function performs the iterative normalization and segmentation.

```r
# Default run (2 iterations)
profilSNPXba <- ITALICS(quartet$quartetInfo, snpInfo)

# Custom formula (e.g., excluding fragment length effects)
profilSNPXba <- ITALICS(quartet$quartetInfo, snpInfo,
                        formule="Smoothing+QuartetEffect+GC+I(GC^2)+I(GC^3)")
```

### 3. Visualization
Results are stored in a `profileCGH` object and can be plotted using the `GLAD` package.

```r
library(GLAD)
data(cytoband)
plotProfile(profilSNPXba, Smoothing="Smoothing", cytoband=cytoband)
```

## Key Parameters

- `iteration`: Number of iterations (default: 2).
- `confidence`: Prediction interval (default: 0.95) used to flag and exclude outlier quartets.
- `formule`: The regression model for non-relevant effects. Components include `Smoothing` (biological signal), `QuartetEffect`, `FL` (fragment length), and `GC` (GC-content).
- `param`: Penalty term for `GLAD` segmentation. For arrays with low signal-to-noise ratios, use `param=c(d=2)` or `d=1` to detect smaller alterations.

## Data Structures

The output is a `profileCGH` object. The `profileValues` data frame contains:
- `LogRatio`: Normalized test/reference ratio.
- `PosOrder` / `PosBase`: Genomic coordinates.
- `Chromosome`: Chromosome identifier.
- `Smoothing`: The estimated biological copy number signal.

## Reference documentation
- [ITALICS](./references/ITALICS.md)