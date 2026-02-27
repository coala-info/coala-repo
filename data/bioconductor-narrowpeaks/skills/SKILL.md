---
name: bioconductor-narrowpeaks
description: This package applies functional principal component analysis to ChIP-seq data to refine peak boundaries and analyze differential binding shapes. Use when user asks to shorten genomic peak locations, refine candidate peaks using FPCA, or quantify differences in peak shapes across conditions.
homepage: https://bioconductor.org/packages/3.8/bioc/html/NarrowPeaks.html
---


# bioconductor-narrowpeaks

## Overview

The `NarrowPeaks` package applies Functional Principal Component Analysis (FPCA) to ChIP-seq data. It is primarily used for two purposes:
1. **Peak Refinement**: Post-processing candidate peaks (from callers like MACS or CSAR) to shorten genomic locations while preserving a specific proportion of variation in enrichment profiles.
2. **Differential Binding**: Quantifying differences in peak shapes across multiple conditions or replicates using Hotelling’s T2 tests on functional principal component scores.

## Core Workflow

### 1. Data Preparation
The package works with enrichment scores. You must first convert WIG files into the binary format used by the `CSAR` package.

```R
library(NarrowPeaks)
# Convert WIG to CSAR binary format
# nbchr: number of chromosomes; chrle: vector of chromosome lengths
wigScores <- wig2CSARScore(wigfilename="data.wig", nbchr = 1, chrle=c(30427671))
```

### 2. Defining Candidate Regions
You need a `GRanges` object of candidate peaks. These can be generated via `CSAR` or imported from BED files.

```R
library(CSAR)
# Generate candidates using CSAR
candidates <- sigWin(experiment=wigScores$infoscores, t=1.0, g=30)

# OR import from BED (ensure a 'score' metadata column exists)
# library(rtracklayer)
# candidates <- import("peaks.bed")
```

### 3. Narrowing Peaks
The `narrowpeaks` function is the primary tool for trimming regions based on FPCA.

```R
# nbf: number of B-spline basis functions
# pv: percentage of variance to capture
# pmaxscor: narrowing threshold (0 = no trimming, 100 = punctate source)
res <- narrowpeaks(inputReg=candidates, 
                   scoresInfo=wigScores$infoscores, 
                   nbf=25, 
                   pv=80, 
                   pmaxscor=3.0)

# Access results
broad <- res$broadPeaks   # Original peaks with FPCA scores
narrow <- res$narrowPeaks # Trimmed/shortened peaks
```

### 4. Differential Variation Analysis
To compare shapes across conditions, use `narrowpeaksDiff`. This requires a consensus list of peaks and multiple samples.

```R
# Hotelling's T2 test is used to identify significant differences in shapes
# across conditions (requires replicates > number of PCs)
# result <- narrowpeaksDiff(bedFile="consensus_peaks.bed", 
#                           samples=list(cond1_reps, cond2_reps), ...)
```

## Key Parameters

- `nbf`: Number of B-spline basis functions. Increase for complex peak shapes; 25 is a standard starting point.
- `pv`: Minimum percentage of variance to be explained by the principal components.
- `pmaxscor`: The "Narrowing Threshold". 
    - `0.0`: No trimming; useful for ranking peaks by `fpcaScore` without changing coordinates.
    - `1.0-10.0`: Typical range for refining peak boundaries.
    - `100.0`: Returns only the single point of maximum variation.
- `ms`: Merge distance. If sub-peaks are within `ms` bp after trimming, they are merged.

## Exporting Results
Results are standard `GRanges` objects and can be exported using `rtracklayer`.

```R
library(rtracklayer)
export.bed(res$narrowPeaks, con="refined_peaks.bed")
```

## Reference documentation

- [Analysis of Transcription Factor Binding ChIP-seq Data using Functional PCA](./references/NarrowPeaks.md)