---
name: bioconductor-cssp
description: This tool performs statistical power analysis for ChIP-seq data using a Bayesian framework to model bin-level read counts. Use when user asks to estimate ChIP-seq power, fit local Poisson models for background estimation, or determine required sequencing depths for specific false discovery rate and fold-change thresholds.
homepage: https://bioconductor.org/packages/3.8/bioc/html/CSSP.html
---


# bioconductor-cssp

name: bioconductor-cssp
description: Statistical power analysis for ChIP-seq data using the CSSP package. Use this skill to estimate ChIP-seq power, fit local Poisson models for bin-level read counts, and determine required sequencing depths for specific FDR and fold-change thresholds.

## Overview

CSSP (ChIP-Seq Statistical Power) provides a Bayesian framework for modeling bin-level read counts in ChIP-seq experiments. It accounts for genome sequence features like mappability and GC-content to estimate the local background and calculate the statistical power of the experiment under various sequencing depths and thresholds.

## Workflow

### 1. Data Preparation

CSSP requires bin-level data for ChIP, Input, Mappability (M), and GC-content (GC).

**Method A: Using `readBinFile`**
Load pre-computed text files into a data frame.
```r
library(CSSP)
dat <- readBinFile(type = c("chip", "input", "M", "GC"),
                   fileName = c("chip.txt", "input.txt", "map.txt", "gc.txt"))
```

**Method B: Using `tag2bin` and `createBinData`**
Convert read alignments (from packages like SPP) to bin-level counts.
```r
# Convert tags to bins
dat_chip <- tag2bin(tagdat_chip, binS = 100, fragL = 100)
dat_input <- tag2bin(tagdat_input, binS = 100, fragL = 100)

# Merge with M, GC, and N (optional) files into a BinData object
bindata <- createBinData(dat_chip, dat_input, 
                         mfile = "map_", gcfile = "gc_", nfile = "n_",
                         m.suffix = ".txt", gc.suffix = ".txt", n.suffix = ".txt")
```

### 2. Fitting the CSSP Model

Fit the model using Minimum Distance Estimation (MDE) to estimate parameters like `e0` (proportion of background reads).

```r
# Standard fit
sampleFit <- cssp.fit(bindata, ngc = 2)

# For large datasets, use gridding to speed up computation
sampleFit.grid <- cssp.fit(bindata, useGrid = TRUE, nsize = 5000)

# For low sequencing depth, consider zero-inflated models
sampleFit.zi <- cssp.fit(bindata, nonpa = TRUE, zeroinfl = TRUE)
```

### 3. Power Computation

Calculate power based on a specific sequencing depth (`x`), False Discovery Rate (`qval`), and minimum fold change (`fold`).

```r
# Calculate power at current sequencing depth
power <- cssp.power(fit = sampleFit, x = sampleFit@lambday, qval = 0.05, fold = 2)

# Estimate power across a range of sequencing depths (e.g., 20% to 100%)
depths <- seq(0.2, 1, by = 0.2) * sampleFit@lambday
power_curve <- sapply(depths, function(d) {
  cssp.power(fit = sampleFit, x = d, fold = 2, useC = TRUE)
})
```

### 4. Supplementary Analysis

**Estimating Thresholds from Peak Callers:**
If using results from another peak caller, use `bindcount` or `peakcount` to estimate the fold change and count thresholds used by that tool.

```r
# For peak intervals
counts <- peakcount(tagdat_chip, tagdat_input, peakpos = peak_intervals, fragL = 100)

# Calculate empirical thresholds
thr_fold <- min(counts$chip / counts$input) * (sampleFit@lambdax / sampleFit@lambday / sampleFit@e0)
thr_count <- min(counts$chip)
```

## Tips and Interpretation

- **Model Diagnostics:** Check the fit by plotting the p-value distribution. A good fit should show a uniform distribution for p-values in the range specified by `p1` and `p2`.
  `plot(sampleFit@pvalue, seq(0, 1, length = length(sampleFit@pvalue)))`
- **GC Content:** For deeply sequenced data, use `ngc=2`. For low depth, use `ngc=0` to avoid ill-defined model matrices.
- **Minimum Count:** Use `qBBT` to estimate appropriate `min.count` thresholds based on intensity percentiles of the Poisson processes.
  `fit.tail <- qBBT(fit = sampleFit, prob = 0.99, depth = sampleFit@lambday)`

## Reference documentation

- [CSSP: ChIP-Seq Statistical Power](./references/cssp.md)