---
name: bioconductor-sights
description: The bioconductor-sights package provides statistical tools and diagnostic visualizations to identify active constructs in high-throughput screening assays by correcting plate and spatial biases. Use when user asks to normalize HTS data, correct spatial bias in plate assays, perform Random Variance Model t-tests, or generate diagnostic heatmaps and boxplots for screening data.
homepage: https://bioconductor.org/packages/release/bioc/html/sights.html
---


# bioconductor-sights

## Overview

The `sights` (Statistics and dIagnostic Graphs for High Throughput Screening) package is designed to identify active constructs in HTS assays by correcting common biases. It addresses three specific types of bias: overall plate bias, within-plate spatial bias, and across-plate bias. The package is particularly powerful for screens with few replicates, offering the Random Variance Model (RVM) t-test to increase statistical power.

## Data Preparation

SIGHTS requires a specific data arrangement:
- **Format**: Each plate is a column; each row is a well.
- **Ordering**: Wells within a plate must be arranged by-row first (e.g., A01, A02, A03...), then by-column.
- **Input**: Use `read.csv` or `xlsx::read.xlsx`.

```r
library(sights)
data("inglese") # Example dataset
# Required: plateRows and plateCols must match the physical plate layout (e.g., 32x40 for 1536-well)
```

## Normalization Workflow

Normalization is typically performed using the wrapper `normSights` or individual functions.

### Common Methods
- **Z / Robust Z**: Corrects plate-level bias only.
- **SPAWN**: (Spatial Polish Along With Normalization) Recommended for correcting all three bias types.
- **Loess / Median Filter / R**: Alternative spatial correction methods.

### Example: SPAWN Normalization
```r
# dataCols: indices of plates to normalize
# biasCols: indices of plates used to estimate the spatial bias template (usually null/low-conc plates)
spawn_results <- normSights(normMethod = "SPAWN", 
                            dataMatrix = inglese, 
                            plateRows = 32, 
                            plateCols = 40, 
                            dataCols = 3:44, 
                            wellCorrection = TRUE, 
                            biasCols = 1:18)
```

## Statistical Testing

SIGHTS provides tools to identify "hits" while controlling for False Discovery Rate (FDR).

### 1. Statistical Tests
- **T**: Standard one-sample t-test.
- **RVM**: Random Variance Model t-test (Recommended for small N).

```r
# repIndex: defines which columns are replicates of the same sample
rvm_results <- statSights(statMethod = "RVM", 
                          normMatrix = spawn_results, 
                          repIndex = c(1,1,1, 2,2,2), 
                          testSide = "two.sided")
```

### 2. FDR Correction
Apply Storey's q-value method to the output of statistical tests.
```r
fdr_results <- statFDR(rvm_results, ctrlMethod = "smoother")
# Hits are typically defined by q-value < 0.05 or 0.20 depending on stringency
```

## Diagnostic Visualization

Use plots to identify bias in raw data and verify its removal after normalization.

- **Plate Bias**: `plotSights(plotMethod = "Box", ...)` - Look for shifting medians.
- **Spatial Bias**: 
    - `plotSights(plotMethod = "Heatmap", ...)` - Look for row/column patterns.
    - `plotSights(plotMethod = "3d", ...)` - 3D representation of plate surface.
    - `plotSights(plotMethod = "Autoco", ...)` - Autocorrelation plots; cyclical patterns indicate spatial bias.
- **Across-Plate Bias**: `plotSights(plotMethod = "Scatter", ...)` - High correlation in non-hits indicates bias.
- **RVM Assumptions**: `plotSights(plotMethod = "IGFit", ...)` - Checks Inverse Gamma fit for RVM validity.

### Customizing Plots
Most plots are `ggplot2` objects. You can add layers or themes:
```r
p <- plotSights(plotMethod = "Box", plotMatrix = spawn_results, plotCols = 1:3)
p + ggplot2::theme_bw() + ggplot2::labs(title = "Normalized Data")
```

## Reference documentation
- [Using SIGHTS R-package](./references/sights.Rmd)
- [Using SIGHTS R-package (Markdown)](./references/sights.md)