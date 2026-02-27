---
name: bioconductor-mmdiff2
description: MMDiff2 is an R package for the statistical comparison of ChIP-seq datasets using kernel-based tests to identify differences in peak shape and read distribution. Use when user asks to perform differential peak analysis, compare protein binding patterns, calculate distances between ChIP-seq profiles, or visualize differences in chromatin states.
homepage: https://bioconductor.org/packages/release/bioc/html/MMDiff2.html
---


# bioconductor-mmdiff2

## Overview

MMDiff2 is an R package designed for the statistical comparison of ChIP-seq datasets. Unlike standard count-based tools, MMDiff2 uses kernel-based statistical tests to identify differences in peak shape and read distribution. This is particularly useful for detecting changes in protein binding patterns or chromatin states that do not necessarily result in a change in total read counts.

## Typical Workflow

### 1. Data Initialization
The workflow begins by defining metadata and loading BAM files. You need a sample sheet (CSV) and a set of regions (GRanges).

```r
library(MMDiff2)
library(BSgenome.Mmusculus.UCSC.mm9)

# Define experiment metadata
ExperimentData <- list(
  genome = 'BSgenome.Mmusculus.UCSC.mm9',
  dataDir = "path/to/bams",
  sampleSheet = "samples.csv"
)
MetaData <- list('ExpData' = ExperimentData)

# Initialize DBAmmd object
MMD <- DBAmmd(MetaData)

# Set regions of interest (e.g., MACS2 peaks)
# Peaks should be a GRanges object
MMD <- setRegions(MMD, Peaks)
```

### 2. Processing Reads and Fragment Centers
MMDiff2 works with fragment positions rather than simple coverage.

```r
# Extract reads from BAM files for the specified regions
MMD <- getPeakReads(MMD)

# Estimate fragment centers (improves resolution for single-end data)
MMD <- estimateFragmentCenters(MMD)

# Compute histograms for visualization and distance calculations
# bin.length: smoothing parameter (default 20)
MMD <- compHists(MMD, bin.length=20, whichPos="Center")
```

### 3. Distance Calculation and Differential Testing
The core of the package is calculating distances between profiles.

```r
# Compute per-region pair-wise distances between all samples
MMD <- compDists(MMD)

# Define the contrast (e.g., comparing conditions defined in sample sheet)
MMD <- setContrast(MMD, contrast='byCondition')

# Compute p-values using the Maximum Mean Discrepancy (MMD) method
MMD <- compPvals(MMD, dist.method='MMD')
```

### 4. Reporting and Visualization
Results can be extracted as a report or visualized individually.

```r
# Generate a report of results
res <- reportResults(MMD)

# Plot a specific peak to see the profile differences
plotPeak(MMD, Peak.id='241', plot.input = FALSE)

# Plot global distances to see significant peaks (highlighted in red)
plotDists(MMD, dist.method='MMD', diff.method='MMD.locfit', th=0.1)
```

## Advanced Features

### Motif and Gene Annotation
You can overlay motifs and gene tracks on peak plots to provide biological context.

```r
# Add motifs from MotifDb
library(MotifDb)
motifs <- query(MotifDb, 'Mmusculus')

# Plot peak with motifs and gene annotation (GR is a GRanges of genes)
plotPeak(MMD, Peak.id='241', Motifs=motifs, anno=GR)
```

### Interactive Exploration
MMDiff2 includes a Shiny app for interactive browsing of differential peaks.

```r
runShinyMMDiff2(MMD)
```

## Tips for Success
- **BAM Indexing**: Ensure all BAM files are position-sorted and indexed (.bai files present).
- **Control Samples**: While `plot.input = FALSE` is often used for clarity, including input/control samples in the initial `DBAmmd` object is recommended for robust analysis.
- **Fragment Estimation**: For paired-end data, `estimateFragmentCenters` computes exact centers; for single-end, it uses a strand-shift cross-correlation approach.

## Reference documentation
- [MMDiff2: Statistical Testing for ChIP-Seq Data Sets](./references/MMDiff2.md)