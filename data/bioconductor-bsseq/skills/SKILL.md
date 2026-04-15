---
name: bioconductor-bsseq
description: This tool analyzes whole-genome bisulfite sequencing data using the BSmooth algorithm to estimate methylation profiles. Use when user asks to create BSseq objects, perform smoothing, compute t-statistics, identify differentially methylated regions, or visualize methylation data.
homepage: https://bioconductor.org/packages/release/bioc/html/bsseq.html
---

# bioconductor-bsseq

name: bioconductor-bsseq
description: Analysis of whole-genome bisulfite sequencing (WGBS) data using the BSmooth algorithm. Use this skill to create BSseq objects, perform smoothing, compute t-statistics, identify differentially methylated regions (DMRs), and visualize methylation profiles.

## Overview

The `bsseq` package is the reference implementation of the BSmooth algorithm for analyzing WGBS data. It is designed to handle large-scale methylation data by using smoothing to obtain reliable methylation estimates from low-coverage sequencing. The package supports in-memory processing and HDF5-backed objects for large datasets, allowing for the identification of differentially methylated regions (DMRs) across biological replicates.

## Core Workflow

### 1. Data Import and Object Creation
The primary data structure is the `BSseq` object, which contains genomic positions, M-values (methylated reads), and Cov-values (total coverage).

```r
library(bsseq)

# Manual construction
M <- matrix(c(17, 20, 4, 20), ncol = 2)
Cov <- matrix(c(18, 23, 11, 28), ncol = 2)
bs_obj <- BSseq(chr = c("chr22", "chr22"), pos = c(14430632, 14430677),
                M = M, Cov = Cov, sampleNames = c("r1", "r2"))

# Reading from Bismark (HDF5 recommended for large files)
# bismark_files <- c("sample1.txt", "sample2.txt")
# bs_obj <- read.bismark(bismark_files, BACKEND = "HDF5Array")
```

### 2. Data Manipulation
- **Subsetting**: Use `bs_obj[i, j]` for loci (i) and samples (j), or `subsetByOverlaps(bs_obj, granges)`.
- **Combining**: Use `combine(obj1, obj2)` to merge samples or loci.
- **Collapsing**: Use `collapseBSseq(bs_obj, group)` to sum coverage across technical replicates.
- **Accessors**: `getCoverage(bs_obj, type = "M")`, `getMeth(bs_obj, type = "raw")`.

### 3. Smoothing with BSmooth
Smoothing estimates the underlying methylation profile. This is computationally intensive and supports parallelization.

```r
# Smoothing a single sample or small object
bs_fit <- BSmooth(bs_obj, verbose = TRUE)

# Parallel smoothing (not supported on Windows)
# bs_fit <- BSmooth(bs_obj, mc.cores = 4, parallelBy = "sample")
```

### 4. Differential Methylation Analysis
After smoothing, filter low-coverage loci before computing t-statistics to reduce false positives.

```r
# Filter: keep loci with >= 2x coverage in at least 2 samples per group
keepLoci <- which(rowSums(getCoverage(bs_fit)[, group1] >= 2) >= 2 &
                  rowSums(getCoverage(bs_fit)[, group2] >= 2) >= 2)
bs_filt <- bs_fit[keepLoci,]

# Compute t-statistics
# local.correct = TRUE is recommended for cancer data (large-scale changes)
bs_tstat <- BSmooth.tstat(bs_filt, 
                          group1 = c("C1", "C2"), 
                          group2 = c("N1", "N2"),
                          estimate.var = "group2", 
                          local.correct = TRUE)

# Find DMRs
dmrs <- dmrFinder(bs_tstat, cutoff = c(-4.6, 4.6))
# Filter DMRs by number of CpGs and mean difference
dmrs_final <- subset(dmrs, n >= 3 & abs(meanDiff) >= 0.1)
```

### 5. Visualization
Visualize specific regions or DMRs to validate results.

```r
# Add colors to phenoData for plotting
pData(bs_fit)$col <- c("red", "red", "blue", "blue")

# Plot a single region
plotRegion(bs_fit, dmrs_final[1,], extend = 5000, addRegions = dmrs_final)

# Plot many regions to a PDF
# plotManyRegions(bs_fit, dmrs_final[1:50,], extend = 5000)
```

## Handling Large Datasets (HDF5)
For datasets exceeding available RAM, use HDF5-backed objects.

```r
library(HDF5Array)
# Convert in-memory object to HDF5
saveHDF5SummarizedExperiment(bs_obj, dir = "my_bsseq_h5")

# Load HDF5 object
bs_h5 <- loadHDF5SummarizedExperiment(dir = "my_bsseq_h5")
```

## Reference documentation
- [The bsseq User's Guide](./references/bsseq.md)
- [Analyzing WGBS with the bsseq package](./references/bsseq_analysis.md)