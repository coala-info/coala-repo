---
name: bioconductor-dmcfb
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/DMCFB.html
---

# bioconductor-dmcfb

name: bioconductor-dmcfb
description: Identifying differentially methylated cytosines (DMCs) in bisulfite sequencing (BS-Seq) data using Bayesian functional regression models. Use this skill when analyzing DNA methylation data to capture position-specific and group-specific patterns while accounting for spatial correlation and missing values.

# bioconductor-dmcfb

## Overview

The `DMCFB` package provides a pipeline for identifying differentially methylated cytosines (DMCs) in bisulfite sequencing data. It utilizes a Bayesian functional regression approach that is robust to missing values and captures spatial correlations between genomic positions. The workflow typically involves reading Bismark-style files or matrices into a `BSDMC` object, identifying DMCs using MCMC-based estimation, and visualizing the results.

## Core Workflow

### 1. Data Preparation

Data can be imported from Bismark output files or created from R matrices.

**From Bismark Files:**
Files should have six columns: Chromosome, Start, End, Methylation Level, Methylated Reads (m), and Un-methylated Reads (u).

```r
library(DMCFB)
# Get file paths
files <- c("path/to/sample1.txt", "path/to/sample2.txt")
names <- c("Sample1", "Sample2")

# Read into BSDMC object
OBJ <- readBismark(files, names, mc.cores = 2)

# Add sample metadata
colData(OBJ) <- DataFrame(Group = factor(c("Control", "Treatment")), 
                          row.names = names)
```

**From Matrices:**
If data is already in R, use `cBSDMC`.

```r
# metht: total reads matrix, methc: methylated reads matrix
# r1: GRanges object for positions
OBJ <- cBSDMC(rowRanges = r1, methReads = methc, totalReads = metht, 
              methLevels = methc/metht, colData = sample_metadata)
```

### 2. Identifying DMCs

The `findDMCFB` function performs the Bayesian functional regression.

```r
# bwa, bwb: bandwidth parameters
# nBurn, nMC: MCMC iterations
# alpha: significance level for DMC identification
DMC_results <- findDMCFB(object = OBJ, 
                         bwa = 30, bwb = 30, 
                         nBurn = 300, nMC = 300, 
                         alpha = 5e-5, 
                         pSize = 500, 
                         sfiles = FALSE)
```

### 3. Visualization

Use `plotDMCFB` to visualize methylation patterns and identified DMCs across specific genomic regions.

```r
# region: vector of start and end indices
plotDMCFB(DMC_results, region = c(1, 500), nSplit = 2)
```

## Key Functions and Parameters

- `readBismark()`: Imports Bismark-formatted files.
- `cBSDMC()`: Constructor for `BSDMC` objects from matrices.
- `findDMCFB()`: The main analysis engine. 
    - `pSize`: Size of genomic blocks for processing.
    - `nMC`: Number of MCMC iterations after burn-in.
    - `alpha`: The threshold for the posterior probability to declare a site as a DMC.
- `plotDMCFB()`: Generates plots showing group-specific methylation trends.

## Tips for Success

- **Memory Management**: For large datasets, use the `pSize` parameter in `findDMCFB` to process the genome in manageable chunks.
- **Parallelization**: Use the `mc.cores` argument in `readBismark` to speed up data ingestion.
- **Sorting**: It is often beneficial to `sort(OBJ)` your `BSDMC` object before analysis to ensure genomic coordinates are in order.
- **MCMC Convergence**: For publication-quality results, increase `nBurn` and `nMC` (e.g., to 1000 or more) to ensure stable posterior estimates.

## Reference documentation

- [Identifying DMCs using Bayesian functional regressions in BS-Seq data](./references/DMCFB.md)
- [DMCFB Vignette Source](./references/DMCFB.Rmd)