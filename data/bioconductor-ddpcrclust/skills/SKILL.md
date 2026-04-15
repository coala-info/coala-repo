---
name: bioconductor-ddpcrclust
description: This tool automates the analysis, clustering, and visualization of multiplexed droplet digital PCR data. Use when user asks to analyze ddPCR experiments, perform automated droplet clustering, or calculate copies per droplet.
homepage: https://bioconductor.org/packages/release/bioc/html/ddPCRclust.html
---

# bioconductor-ddpcrclust

name: bioconductor-ddpcrclust
description: Automated analysis and visualization of multiplexed, non-orthogonal droplet digital PCR (ddPCR) data. Use this skill when analyzing ddPCR experiments with up to four targets per reaction, performing automated clustering (flowDensity, SamSPECTRAL, flowPeaks), and calculating Copies Per Droplet (CPD).

# bioconductor-ddpcrclust

## Overview
The `ddPCRclust` package automates the analysis of multiplexed ddPCR data, which typically requires time-consuming manual gating. It identifies cluster centroids, assigns genetic targets to clusters, allocates "rain" (droplets between clusters), and calculates the final Copies Per Droplet (CPD). It supports experiments with up to four targets per reaction using HEX and FAM fluorophores.

## Typical Workflow

1. **Load Data**: Import Bio-Rad CSV files and an optional experiment template.
2. **Run Clustering**: Use the main `ddPCRclust` function to automatically partition droplets.
3. **Calculate CPD**: Determine the abundance of each genetic target.
4. **Export**: Save results to Excel, CSV, or generate plots.

## Core Functions

### Data Input
```r
library(ddPCRclust)

# Load raw droplet data (Bio-Rad CSV format)
files <- readFiles("path/to/data.csv")

# Load experiment template (defines markers per well)
template <- readTemplate("path/to/template.csv")
```

### Main Analysis
The `ddPCRclust` function is the primary interface. It can handle multiple files and distribute tasks across CPU cores.

```r
# Run the automated analysis
result <- ddPCRclust(files, template)

# Access results for a specific well (e.g., B01)
well_data <- result$B01$data
well_stats <- result$B01$stats
```

### Manual Clustering Control
If the main wrapper requires fine-tuning, use specific clustering algorithms:
- `runDensity(files, ...)`: Uses `flowDensity` (fastest, density-based).
- `runSam(files, ...)`: Uses `SamSPECTRAL` (spectral clustering).
- `runPeaks(files, ...)`: Uses `flowPeaks` (k-means and density peak finding).

### Calculating CPD
Calculate the actual concentration (Copies Per Droplet) based on the clustering results.

```r
# Calculate CPDs, optionally normalizing against a constant control
cpd_results <- calculateCPDs(result, template, constantControl = "TargetName")
```

## Key Parameters

- `sensitivity`: (Default: 1) Adjusts cluster partitioning. Higher values create more clusters; lower values merge them.
- `similarityParam`: (Default: 0.95) Threshold for "rain" allocation. Droplets with similarity ratios above this value are not counted to maintain precision.
- `fast`: (Default: FALSE) If TRUE, uses only the `flowDensity` algorithm, providing a ~10x speed increase for clean data.
- `multithread`: (Default: FALSE) Enables parallel processing (not available on Windows).

## Visualization and Export

```r
# Export plots to a directory
exportPlots(result, directory = "plots")

# Export numerical data
exportToExcel(result, filename = "results.xlsx")
exportToCSV(result, directory = "csv_output")

# Basic ggplot2 visualization
library(ggplot2)
ggplot(result$B01$data, aes(x = Ch2.Amplitude, y = Ch1.Amplitude, color = factor(Cluster))) +
  geom_point(size = 0.5) +
  theme_bw()
```

## Reference documentation
- [ddPCRclust](./references/ddPCRclust.md)