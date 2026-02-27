---
name: bioconductor-copynumberplots
description: This package creates specialized visualizations for copy-number variation data by extending the karyoploteR framework. Use when user asks to plot B-allele frequency, visualize log R ratio, or display copy-number segments and summary frequency plots across the genome.
homepage: https://bioconductor.org/packages/release/bioc/html/CopyNumberPlots.html
---


# bioconductor-copynumberplots

## Overview

The `CopyNumberPlots` package extends `karyoploteR` to provide specialized visualizations for copy-number variation (CNV) data. It simplifies the process of loading raw data from various platforms (SNP-arrays, aCGH) and results from common CNV callers (DNAcopy, CNVkit, etc.), allowing users to create publication-quality genomic plots with minimal code.

## Core Workflow

### 1. Initialize the Plot
All plots begin with `karyoploteR::plotKaryotype()`.
```r
library(CopyNumberPlots)
kp <- plotKaryotype(genome="hg19", chromosomes="chr1")
```

### 2. Loading Data
The package provides smart loaders that automatically identify columns for chromosome, position, LRR, and BAF.

*   **Raw SNP/aCGH Data:** Use `loadSNPData()` for files or data frames.
    ```r
    snps <- loadSNPData("path/to/data.txt")
    # Returns a GRanges with 'lrr' and 'baf' metadata columns
    ```
*   **Copy-Number Calls:** Use `loadCopyNumberCalls()` for segments.
    ```r
    cn_calls <- loadCopyNumberCalls("path/to/segments.seg")
    # Returns a GRanges with 'cn', 'loh', or 'segment.value' columns
    ```
*   **Specialized Loaders:** Functions exist for specific tools: `loadASCAT()`, `loadDNAcopy()`, `loadCNVkit()`, `loadDECoN()`, etc.

### 3. Plotting Raw Data
*   **BAF (B-Allele Frequency):** Values between 0 and 1.
    ```r
    plotBAF(kp, snps=snps, r0=0.5, r1=1)
    ```
*   **LRR (Log R Ratio):** Intensity values.
    ```r
    plotLRR(kp, snps=snps, r0=0, r1=0.45, ymin=-2, ymax=2)
    ```
    *   *Tip:* Points outside `ymin`/`ymax` are plotted in red at the boundary by default. Use `out.of.range = "density"` for high-density data.

### 4. Plotting Calls and Segments
*   **Rectangular Segments:** `plotCopyNumberCalls(kp, cn.calls)` plots CN states as colored bars and LOH as a secondary track.
*   **Line Plots:** `plotCopyNumberCallsAsLines(kp, cn.calls)` plots CN state as a continuous line.
*   **Summary/Cohort View:** `plotCopyNumberSummary(kp, list_of_samples)` creates a frequency plot (coverage) of gains and losses across multiple samples.

## Customization and Positioning

*   **Vertical Tracks:** Use `r0` and `r1` (0 to 1) to define the vertical space for each track.
*   **Colors:** Use `getCopyNumberColors(colors = "red_blue")` to get standard color schemes for different integer copy states.
*   **Multi-sample:** Passing a list of GRanges to `plotBAF` or `plotLRR` will automatically stack samples vertically.

## Reference documentation

- [CopyNumberPlots: create copy-number specific plots using karyoploteR](./references/CopyNumberPlots.md)