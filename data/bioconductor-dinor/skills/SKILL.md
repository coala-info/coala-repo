---
name: bioconductor-dinor
description: This tool analyzes NOMe-seq data to detect differences in nucleosome binding and accessibility patterns between experimental groups. Use when user asks to generate metaplots across regions of interest, classify and quantify chromatin footprints, or perform differential abundance testing of chromatin states between conditions.
homepage: https://bioconductor.org/packages/release/bioc/html/dinoR.html
---


# bioconductor-dinor

name: bioconductor-dinor
description: Analyze NOMe-seq data to detect differences in nucleosome binding and accessibility patterns between experimental groups. Use when working with RangedSummarizedExperiment objects containing GCH methylation data to: (1) Generate metaplots across regions of interest (ROIs), (2) Classify and quantify chromatin footprints (TF, open, nucleosome), and (3) Perform differential abundance testing between conditions (e.g., WT vs KO).

# bioconductor-dinor

## Overview

dinoR (Differential Nucleosome Occupancy in R) is a Bioconductor package for detecting differences in nucleosome binding and accessibility patterns between groups of NOMe-seq experiments. It is particularly optimized for "guided NOMe-seq" data targeting specific regions of interest (ROIs), such as transcription factor (TF) motifs. The package classifies individual DNA fragments into five chromatin states—TF-bound, open, upstream nucleosome, downstream nucleosome, and general nucleosome—and uses edgeR-based statistical frameworks to identify significant shifts in these populations across conditions.

## Workflow and Functions

### 1. Data Preparation and Loading
The package expects a `RangedSummarizedExperiment` object where ROIs are of equal length and centered on a motif. The `reads` assay should contain GPos objects with GCH methylation data (protection and methylation matrices).

```r
library(dinoR)
data(NomeData) # Example dataset
```

### 2. Visualizing Average Protection (Metaplots)
Use `metaPlots` to generate data for average protection profiles across ROIs, typically grouped by motif type.

```r
# nr = minimum read count threshold
avePlotData <- metaPlots(NomeData = NomeData, nr = 10, ROIgroup = "motif")

# Plot using ggplot2
ggplot(avePlotData, aes(x = position, y = protection)) +
    geom_line(aes(y = loess), col = "darkblue") +
    facet_grid(rows = vars(type), cols = vars(sample))
```

### 3. Fragment Classification and Quantification
Classify individual fragments based on protection patterns in three specific windows relative to the motif center (-50:-25, -8:8, 25:50).

*   `footprintCalc(NomeData)`: Assigns each fragment to a class (tf, open, upNuc, downNuc, or Nuc).
*   `footprintQuant(NomeData)`: Counts fragments per class for each sample-ROI combination.

```r
NomeData <- footprintCalc(NomeData)
NomeData <- footprintQuant(NomeData)
```

### 4. Differential Abundance Testing
Use `diNOMeTest` to identify ROIs with significant changes in footprint abundance. This function uses `edgeR` to compare specific footprint counts against the total fragment count.

```r
res <- diNOMeTest(NomeData,
    WTsamples = c("WT_1", "WT_2"),
    KOsamples = c("AdnpKO_1", "AdnpKO_2"),
    combineNucCounts = FALSE # Set TRUE to merge upNuc, downNuc, and Nuc
)
```

### 5. Percentage Analysis and Heatmaps
Calculate the relative percentage of each footprint type and visualize global patterns.

```r
# Calculate percentages
footprint_percentages <- footprintPerc(NomeData)

# Generate clustered heatmap
fpPercHeatmap(footprint_percentages)

# Combined visualization of percentages and significance
compareFootprints(footprint_percentages, res,
    WTsamples = c("WT_1", "WT_2"),
    KOsamples = c("AdnpKO_1", "AdnpKO_2"))
```

## Tips for Success

*   **ROI Centering**: Ensure ROIs are centered on the TF motif and the strand is correctly indicated in the genomic ranges. This is critical for observing asymmetric protection patterns.
*   **Fragment Filtering**: Fragments that lack methylation protection data in any of the three required classification windows are automatically excluded during `footprintQuant`.
*   **Nucleosome Grouping**: If specific positioning (upstream vs. downstream) is not relevant to your biological question, use `combineNucCounts = TRUE` in `diNOMeTest` and `footprintPerc` to increase statistical power for general nucleosome occupancy changes.
*   **Normalization**: `diNOMeTest` performs TMM normalization based on total fragment counts to ensure comparability between libraries.

## Reference documentation

- [dinoR-vignette](./references/dinoR-vignette.md)