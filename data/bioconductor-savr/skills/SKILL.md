---
name: bioconductor-savr
description: This tool parses and visualizes Illumina sequencing run diagnostic metrics from binary InterOp files. Use when user asks to analyze sequencing run quality, extract metadata from RunInfo.xml, or generate quality control plots like cluster density boxplots and intensity profiles.
homepage: https://bioconductor.org/packages/3.5/bioc/html/savR.html
---


# bioconductor-savr

name: bioconductor-savr
description: Analysis and visualization of Illumina sequencing run diagnostic metrics (SAV). Use this skill to parse binary InterOp files from HiSeq or MiSeq platforms, extract run metadata (RunInfo.xml), and generate quality control plots such as intensity profiles, quality score heatmaps, and cluster density boxplots.

# bioconductor-savr

## Overview

The `savR` package is designed to parse and analyze Illumina Sequence Analysis Viewer (SAV) binary data. It allows R users to perform automated quality assessment of sequencing runs by accessing corrected intensities, quality metrics, tile metrics, and extraction metrics that were previously only accessible via Illumina's Windows-based SAV software.

## Core Workflow

### 1. Loading Data
The primary entry point is the `savR()` function, which requires the path to the Illumina run folder (containing the `InterOp` folder and `RunInfo.xml`).

```r
library(savR)
# Replace with the path to your Illumina run directory
fc <- savR("/path/to/run/folder")

# For demonstration using built-in MiSeq data:
fc <- savR(system.file("extdata", "MiSeq", package="savR"))
```

### 2. Inspecting Run Metadata
The `savProject` object stores metadata parsed from `RunInfo.xml`.

*   `directions(fc)`: Number of sequencing directions (1 for single-end, 2 for paired-end).
*   `reads(fc)`: List of read objects detailing cycles and whether they are index reads.
*   `cycles(fc)`: Total number of cycles.
*   `flowcellLayout(fc)`: Details on lanes, surfaces, swaths, and tiles.

### 3. Accessing Metrics
Data is returned as standard R data frames for custom analysis.

*   **Corrected Intensities**: `correctedIntensities(fc)`
    *   Includes average intensity, cross-talk corrected values, and signal-to-noise ratios per lane/tile/cycle.
*   **Quality Metrics**: `qualityMetrics(fc)`
    *   Contains cluster counts for PHRED quality scores (Q1-Q50).
*   **Tile Metrics**: `tileMetrics(fc)`
    *   Contains cluster density, pass-filter (PF) clusters, and phasing/pre-phasing data.
*   **Extraction Metrics**: `extractionMetrics(fc)`
    *   Contains FWHM (Full Width at Half Maximum) and 90th percentile intensities.

### 4. Visualization
`savR` provides several high-level plotting functions to assess run quality:

*   **Cluster Density**: `pfBoxplot(fc)`
    *   Visualizes Total vs. Pass-Filter (PF) clusters.
*   **Intensity Profile**: `plotIntensity(fc)`
    *   Plots signal intensity for each channel (A, C, G, T) across cycles.
*   **Quality Heatmap**: `qualityHeatmap(fc, lane=1, read=1)`
    *   Generates a heatmap of quality scores by cycle.

### 5. Automated Reporting
To reconstruct a legacy-style Illumina reports folder:
```r
buildReports(fc, destination="~/my_run_reports")
```

## Tips and Best Practices
*   **Memory Management**: For very large flowcells (e.g., NovaSeq), ensure sufficient RAM is available as `savR` loads binary metrics into memory.
*   **Data Integrity**: Ensure the `RunInfo.xml` file is present in the root of the directory passed to `savR()`, as it is required to define the flowcell geometry.
*   **Indexing**: Use `reads(fc)` to identify which cycles correspond to index reads versus template reads before interpreting quality heatmaps.

## Reference documentation
- [Using savR](./references/savR.md)