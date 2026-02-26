---
name: bioconductor-arraytv
description: "ArrayTV corrects GC content bias and wave artifacts in microarray signal intensity data. Use when user asks to remove GC-related waves from genomic data, perform GC correction on microarray intensities, or calculate total variance scores for optimal window selection."
homepage: https://bioconductor.org/packages/3.8/bioc/html/ArrayTV.html
---


# bioconductor-arraytv

## Overview

ArrayTV is a tool for correcting GC content bias in microarray data, which often manifests as "waves" across the genome. It works by evaluating the dependence of signal intensity on local GC content using various genomic window sizes. The optimal window is selected based on a Total Variance (TV) score. The package is compatible with simple matrices as well as `oligoClasses` structures.

## Core Workflow

### 1. Data Preparation
Input data should consist of preprocessed signal intensities (M values) and their corresponding genomic positions (UCSC build hg18/hg19).

```r
library(ArrayTV)
# Example: matrix with 'position' and 'M' columns
# Ensure positions represent the start of the probe
agilent[, "M"] <- agilent[, "M"] / 1000 
```

### 2. Defining Search Windows
You must specify the range of genomic windows to evaluate for GC calculation. This is done using `maxwins` and `increms`.

```r
# Search three series of windows
# 1. 20, 40, 60, 80, 100 bp
# 2. 2000, 4000, 6000, 8000, 10000 bp
# 3. 200k, 400k, 600k, 800k, 1M bp
max.window <- c(100, 10e3, 1e6)
increms <- c(20, 2000, 200e3)
```

### 3. Performing GC Correction
The `gcCorrect` function is the primary interface. It requires a BSgenome object (e.g., `BSgenome.Hsapiens.UCSC.hg18`) to calculate GC content.

```r
correctedList <- gcCorrect(
  object = nimblegen[, "M", drop=FALSE],
  chr = rep("chr15", nrow(nimblegen)),
  starts = nimblegen[, "position"],
  increms = increms,
  maxwins = max.window,
  build = "hg18"
)
```

### 4. Extracting Results
The output is a list containing the corrected values and the TV scores for each window.

```r
# Get corrected M values
corrected_M <- correctedList$correctedVals

# Get TV scores to identify the optimal window
tv_scores <- correctedList$tvScore
```

## Parallelization
For large datasets or many window sizes, use `doParallel` to speed up GC calculation.

```r
library(doParallel)
cl <- makeCluster(4)
registerDoParallel(cl)

# Run gcCorrect...

stopCluster(cl)
```

## Tips and Best Practices
- **Window Selection**: The optimal window size varies by platform. Affymetrix often performs best with small windows (~8kb), while Agilent and NimbleGen may require larger windows (~1.2Mb).
- **Multiple Iterations**: If waves persist at both small and large scales, run `gcCorrect` a second time on the already-corrected values using a different window range.
- **Whole Genome**: While examples often show single chromosomes, it is recommended to run the correction on all autosomes simultaneously for better variance estimation.
- **Probe Starts**: Ensure the `starts` argument refers to the physical start of the probe/marker, not just the SNP location.

## Reference documentation
- [ArrayTV](./references/ArrayTV.md)