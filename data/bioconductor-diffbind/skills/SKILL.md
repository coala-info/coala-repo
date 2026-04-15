---
name: bioconductor-diffbind
description: Bioconductor-diffbind identifies significant changes in protein-DNA binding or chromatin accessibility between experimental conditions using genomic intervals and sequencing reads. Use when user asks to perform differential binding analysis, identify differentially bound sites in ChIP-seq or ATAC-seq data, normalize binding affinity, or visualize differential occupancy results.
homepage: https://bioconductor.org/packages/release/bioc/html/DiffBind.html
---

# bioconductor-diffbind

## Overview

The `DiffBind` package is the standard Bioconductor tool for differential binding analysis. It processes genomic intervals (peaksets) and sequencing reads (BAM files) to identify sites where protein-DNA binding or chromatin accessibility changes significantly between conditions. It manages the complexity of overlapping peaks from different samples, calculates normalized read densities, and provides robust statistical testing.

## Core Workflow

### 1. Data Input and Sample Sheets
The most efficient way to load data is via a CSV sample sheet containing metadata (SampleID, Tissue, Factor, Condition, Treatment, Replicate) and file paths (bamReads, ControlID, bamControl, Peaks, PeakCaller).

```R
library(DiffBind)
# Load samples
tamoxifen <- dba(sampleSheet="samples.csv")
```

### 2. Occupancy Analysis
Before counting reads, you can analyze the overlap of peak calls (occupancy) to assess sample similarity.

```R
# View sample metadata and peak counts
tamoxifen
# Plot correlation heatmap based on peak overlaps
plot(tamoxifen)
# Overlap Venn diagram
dba.plotVenn(tamoxifen, tamoxifen$masks$Responsive)
```

### 3. Blacklisting and Greylisting
Remove problematic regions (e.g., ENCODE blacklists) or experiment-specific artifacts (greylists derived from controls) to reduce false positives.

```R
# Apply ENCODE blacklist for Hg19 and compute greylist from controls
tamoxifen <- dba.blacklist(tamoxifen, blacklist=DBA_BLACKLIST_HG19, greylist=TRUE)
```

### 4. Counting Reads
Calculate a binding affinity matrix by counting reads in the consensus peakset. By default, peaks are re-centered around summits to a width of 401bp.

```R
# Count reads in peaks
tamoxifen <- dba.count(tamoxifen, summits=200)
```

### 5. Normalization
Normalization is critical. While `DiffBind` defaults to library size normalization, background normalization is often more robust for ChIP/ATAC-seq to avoid assuming balanced binding changes.

```R
# Normalize using background bins (recommended for most assays)
tamoxifen <- dba.normalize(tamoxifen, background=TRUE)
```

### 6. Establishing Design and Contrast
Define the experimental design and the specific comparison (contrast) to be tested.

```R
# Simple design
tamoxifen <- dba.contrast(tamoxifen, design="~Condition")

# Multi-factor design to control for batch or tissue effects
tamoxifen <- dba.contrast(tamoxifen, design="~Tissue + Condition")
```

### 7. Differential Analysis
Run the statistical analysis (defaults to `DESeq2`).

```R
tamoxifen <- dba.analyze(tamoxifen, method=DBA_DESEQ2)
# Show results summary
dba.show(tamoxifen, bContrasts=TRUE)
```

### 8. Reporting and Visualization
Extract the results and generate diagnostic plots.

```R
# Get differentially bound sites as GRanges
res <- dba.report(tamoxifen)

# Visualization
dba.plotMA(tamoxifen)        # MA Plot
dba.plotVolcano(tamoxifen)   # Volcano Plot
dba.plotPCA(tamoxifen)       # PCA Plot
dba.plotHeatmap(tamoxifen, contrast=1, correlations=FALSE) # Affinity Heatmap
```

## Advanced Profiling
Use `dba.plotProfile` to generate read density profiles and heatmaps around peak centers. This requires the `profileplyr` package.

```R
profiles <- dba.plotProfile(tamoxifen)
dba.plotProfile(profiles)
```

## Key Functions Reference
- `dba()`: Initialize DBA object.
- `dba.count()`: Generate read counts for peaks.
- `dba.normalize()`: Configure normalization parameters.
- `dba.contrast()`: Set up experimental design.
- `dba.analyze()`: Run differential binding statistics.
- `dba.report()`: Extract results.
- `dba.plotVenn()` / `dba.plotPCA()` / `dba.plotMA()`: Visualization tools.

## Reference documentation
- [DiffBind: Differential binding analysis of ChIP-Seq peak data](./references/DiffBind.md)