---
name: bioconductor-genogam
description: GenoGAM performs statistical analysis of genome-wide data like ChIP-Seq using Generalized Additive Models to represent protein occupancy. Use when user asks to model protein occupancy, perform differential binding analysis, call peaks with confidence bands, or normalize and fit genomic data using GAMs.
homepage: https://bioconductor.org/packages/3.6/bioc/html/GenoGAM.html
---


# bioconductor-genogam

name: bioconductor-genogam
description: Statistical analysis of genome-wide data (ChIP-Seq) using Generalized Additive Models (GAMs). Use this skill to model protein occupancy, perform differential binding analysis, and call peaks with position-wise confidence bands using the GenoGAM Bioconductor package.

# bioconductor-genogam

## Overview
GenoGAM (Genome-wide Generalized Additive Model) is designed for the analysis of noisy genomic data, specifically ChIP-Seq. It models the expected fragment counts as a sum of smooth functions of genomic positions. This allows for a flexible representation of protein occupancy and provides a robust statistical framework for comparing conditions (differential occupancy) and identifying peaks.

## Core Workflow

### 1. Data Preparation
The package requires an experiment design file (tab-separated) with columns: `ID`, `file` (BAM path), and `paired` (TRUE/FALSE), plus any experimental factors (e.g., `genotype`).

```r
library(GenoGAM)
library(BiocParallel)

# Register parallel backend (SnowParam recommended for large genomes)
register(SnowParam(workers = 2))

# Define design and tiles
# x = genomic position; genotype = binary factor for differential analysis
design <- ~ s(x) + s(x, by = genotype)
chunkSize <- 50000
overhangSize <- 1000

# Create GenoGAMDataSet
ggd <- GenoGAMDataSet(
  expDesign = "experimentDesign.txt",
  directory = "path/to/bams",
  design = design,
  chunkSize = chunkSize,
  overhangSize = overhangSize,
  hdf5 = TRUE # Use HDF5 for large genomes to save memory
)
```

### 2. Normalization and Fitting
Size factors account for sequencing depth differences. Model fitting estimates the smoothing parameter ($\lambda$) and dispersion ($\theta$).

```r
# Compute size factors (natural log scale)
ggd <- computeSizeFactors(ggd)

# Fit the model
# If lambda and theta are unknown, genogam() will estimate them via cross-validation
result <- genogam(ggd, lambda = 4601, theta = 4.51)
```

### 3. Statistical Analysis
GenoGAM provides pointwise and region-wise significance testing.

```r
# Pointwise p-values
result <- computeSignificance(result)

# Region-wise significance (Differential Binding)
regions <- GRanges("chrI", IRanges(1000, 5000))
db_results <- computeRegionSignificance(result, regions = regions, smooth = "s(x):genotype")
```

### 4. Peak Calling
Identify narrow or broad peaks based on the fitted model.

```r
# Narrow peaks
peaks <- callPeaks(result, threshold = 1, smooth = "s(x):genotype")

# Broad peaks
broad_peaks <- callPeaks(result, threshold = 1, peakType = "broad", cutoff = 0.75)

# Export
writeToBEDFile(peaks, file = "my_peaks")
```

### 5. Visualization
Visualize fits and raw data for specific genomic ranges.

```r
plot_range <- GRanges("chrI", IRanges(45000, 55000))
plotGenoGAM(result, ranges = plot_range)
```

## Key Functions
- `GenoGAMDataSet()`: Constructor for the data object.
- `computeSizeFactors()`: Normalizes for library size.
- `genogam()`: Main fitting function.
- `computeSignificance()`: Calculates pointwise p-values.
- `computeRegionSignificance()`: Tests for differential binding in specific regions.
- `callPeaks()`: Performs peak calling.
- `view()`: Extracts data/fits into data frames for manual inspection.

## Tips for Large Genomes
- **HDF5**: Always set `hdf5 = TRUE` in `GenoGAMDataSet` for organisms larger than yeast to prevent memory crashes.
- **Parallelization**: Use `SnowParam` instead of `MulticoreParam` on large datasets to manage memory more efficiently across cores.
- **Knots**: The default knot spacing (`bpknots`) is 20bp. Increasing this (e.g., to 40bp) speeds up computation but reduces resolution.

## Reference documentation
- [Modeling ChIP-Seq data with GenoGAM 2.0: A Genome-wide generalized additive model](./references/GenoGAM.Rmd)
- [GenoGAM: Genome-wide generalized additive models](./references/GenoGAM.md)