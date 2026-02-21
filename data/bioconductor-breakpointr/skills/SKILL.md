---
name: bioconductor-breakpointr
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/breakpointR.html
---

# bioconductor-breakpointr

name: bioconductor-breakpointr
description: Analyze Strand-seq data to detect template strand inheritance states (WW, CC, WC) and identify genomic breakpoints (Sister Chromatid Exchanges). Use this skill when processing single-cell BAM files to track strand directionality changes, calling breakpoint hotspots, or visualizing strand states across the genome.

## Overview
The `breakpointR` package implements a bi-directional read-based binning algorithm specifically designed for Strand-seq data. It tracks changes in the proportion of reads mapped to the Watson (negative) and Crick (positive) strands to identify where template strand states change. It is robust against mappability biases in sparse single-cell data by using dynamically scaled bins.

## Core Workflow

### 1. Basic Breakpoint Detection
The primary function `breakpointr()` automates the pipeline from BAM files to breakpoint calls.

```r
library(breakpointR)

# Run with default parameters
breakpointr(inputfolder='path/to/bams', outputfolder='path/to/output')

# Recommended settings for quality control
breakpointr(inputfolder='path/to/bams', 
            outputfolder='path/to/output',
            min.mapq = 10,       # Filter low quality mappings
            filtAlt = TRUE,      # Filter alternative alignments
            pairedEndReads = FALSE) 
```

### 2. Binning Strategies
The sensitivity of detection depends on the `windowsize` and `binMethod`.
- **By Size**: `binMethod='size'`. Recommended `windowsize=1e6` (1Mb) for reliable SCE detection.
- **By Reads**: `binMethod='reads'`. Recommended `windowsize=100` for higher resolution.

### 3. Fine-tuning Detection
If data is noisy, adjust the peak detection threshold (`peakTh`) and trimming:
- `peakTh`: Higher values (e.g., 1/2 of max deltaW instead of default 1/3) reduce false positives in uneven coverage.
- `trim`: Fraction of extreme deltaW values to exclude from standard deviation calculations.
- `maskRegions`: Path to a BED file containing regions to exclude (e.g., centromeres, segmental duplications).

### 4. Calling Hotspots
To identify recurrent breakpoints across multiple libraries (requires ~50+ cells):

```r
# Option A: Within the main function
breakpointr(..., callHotSpots=TRUE)

# Option B: From existing results
exampleFiles <- list.files("path/to/RData", full.names=TRUE)
breakpoint.objects <- loadFromFiles(exampleFiles)
breaks <- lapply(breakpoint.objects, '[[', 'breaks')
hotspots <- hotspotter(breaks, bw=1e6)
```

## Visualization and Results

### Loading and Plotting
Results are stored as RData objects in the `data` subfolder of the output directory.

```r
# Plot a single library (genome-wide)
plotBreakpoints(file="path/to/cell.RData")

# Plot specific chromosomes across multiple libraries
plotBreakpointsPerChr(files=c("cell1.RData", "cell2.RData"), chromosomes='chr7')
```

### Output Directory Structure
- `breakpointR.config`: Parameters used for the run (can be reused via `configfile` argument).
- `breakpoints`: BED files of localized breakpoints and hotspots.
- `browserfiles`: UCSC-compatible files for visualizing reads and deltaW values.
- `plots`: PDF visualizations including genome-wide heatmaps and chromosome-specific distributions.

## Reference documentation
- [How to use breakpointR](./references/breakpointR.md)