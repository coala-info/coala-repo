---
name: bioconductor-seqplots
description: This tool visualizes average genomic track signals and sequence motif densities over specific genomic features using line plots and heatmaps. Use when user asks to generate average profile plots, create clustered heatmaps from BigWig or BED files, or calculate DNA motif densities around genomic anchors.
homepage: https://bioconductor.org/packages/3.8/bioc/html/seqplots.html
---

# bioconductor-seqplots

name: bioconductor-seqplots
description: Visualizing average genomic track signals and sequence motif densities over genomic features. Use when needing to generate average profile plots or heatmaps from BigWig/Wiggle tracks and BED/GFF features, perform k-means clustering on genomic signals, or calculate motif densities around genomic anchors.

# bioconductor-seqplots

## Overview
The `seqplots` package is a specialized tool for biological data visualization, specifically designed to plot average track signals (e.g., ChIP-seq read coverage) and sequence motif densities over user-specified genomic features. It supports linear plots with error estimates and heatmaps that can be sorted or clustered using algorithms like k-means or hierarchical clustering. The package utilizes a pre-calculation step to store binary result matrices ("plotsets"), enabling rapid plot generation and batch processing.

## Core Workflow

### 1. Starting the Interface
The primary way to interact with `seqplots` is through its graphical user interface (GUI), which is built on the Shiny framework.
```r
library(seqplots)
run()
```
This command launches the web interface in the default browser.

### 2. Data Preparation and Upload
The package requires two main types of input:
*   **Tracks:** Continuous signal data in BigWig (.bw), Wiggle (.wig), or BedGraph formats.
*   **Features:** Genomic intervals in BED, GFF, or GTF formats.
*   **Genomes:** Requires a corresponding `BSgenome` package installed in R for the reference organism.

### 3. Calculating Plot Sets
Before plotting, `seqplots` calculates a "plotset" matrix. Key parameters include:
*   **Bin track:** The resolution (e.g., 10bp). Higher values speed up calculation but reduce detail.
*   **Plot Type:** 
    *   `Point Features`: Anchored on the start of the feature (directional by strand).
    *   `Midpoint Features`: Centered on the feature's middle.
    *   `Endpoint Features`: Centered on the end of the feature.
    *   `Anchored Features`: Features are scaled to a pseudo-length, with upstream/downstream flanking regions.
*   **Distances:** Define the base pair range upstream and downstream of the anchor.

### 4. Visualization and Analysis
*   **Line Plots:** Display the mean signal across all features with optional shaded error estimates (Standard Error or 95% CI).
*   **Heatmaps:** Display signal intensity for every individual feature.
*   **Clustering:** Heatmaps can be clustered using k-means, hierarchical clustering, or Self-Organizing Maps (SupreSOM) to identify distinct biological patterns.
*   **Motif Density:** Calculate the frequency of specific DNA motifs (e.g., "GATA") using a sliding window approach.

## R Data Structure
Plotsets can be saved as `.Rdata` files and loaded directly into R for custom analysis. The structure is a nested list:
*   `plotset[[feature_name]][[track_name]]`
    *   `means`: Numeric vector of mean signals.
    *   `stderror`: Standard error values.
    *   `heatmap`: The raw signal matrix (rows = features, columns = bins).
    *   `all_ind`: Genomic positions in bp relative to the anchor.

## Troubleshooting Tips
*   **Chromosome Names:** Ensure chromosome naming conventions (e.g., "chr1" vs "1") match between the track, feature, and `BSgenome` package.
*   **Strand Awareness:** By default, `seqplots` is strand-aware. If features lack strand info, they are treated as positive strand unless "Ignore strand" is selected.
*   **Memory:** For very large datasets or high-resolution binning (1bp), ensure sufficient RAM is available for the matrix calculations.

## Reference documentation
- [SeqPlots Quick Start](./references/QuickStart.md)
- [SeqPlots GUI Guide](./references/SeqPlotsGUI.md)
- [QuickStart Source](./references/QuickStart.Rmd)
- [SeqPlotsGUI Source](./references/SeqPlotsGUI.Rmd)