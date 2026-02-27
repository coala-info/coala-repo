---
name: bioconductor-synlet
description: The bioconductor-synlet package provides a pipeline for analyzing synthetic lethal RNAi screen data and identifying gene hits. Use when user asks to analyze synthetic lethal RNAi screens, calculate Z-factors, visualize plate heatmaps, or perform hit selection using algorithms like B-scores and RSA.
homepage: https://bioconductor.org/packages/release/bioc/html/synlet.html
---


# bioconductor-synlet

## Overview

The `synlet` package is designed for the analysis of synthetic lethal RNAi screens. It provides a comprehensive pipeline for processing high-throughput screen data, starting from raw readout values to hit selection. The package is particularly useful for identifying genes that cause differential mortality between treatment and control conditions. It implements several robust statistical algorithms to minimize off-target effects and handle cell heterogeneity.

## Data Requirements

The package operates on a `data.table` (typically named `example_dt` in documentation) with specific mandatory columns:

*   **PLATE**: Individual plate name (character).
*   **MASTER_PLATE**: Grouping for plate replicates.
*   **WELL_CONTENT_NAME**: siRNA name (e.g., "GeneName si1").
*   **EXPERIMENT_TYPE**: "sample", "control_negative", or "control_positive".
*   **EXPERIMENT_MODIFICATION**: "treatment" or "control".
*   **ROW_NAME** / **COL_NAME**: Well coordinates.
*   **READOUT**: Numeric screen output.

## Quality Control and Visualization

### 1. Z and Z' Factors
Calculate quality metrics to assess assay optimization (Z') and screen performance (Z). Values >= 0.5 indicate excellent assays.

```r
library(synlet)
# Calculate using mean (default) or median (useMean = FALSE)
res <- zFactor(example_dt, negativeCon = "scrambled control si1", positiveCon = "PLK1 si1")
```

### 2. Visualization
*   **Plate Heatmaps**: View spatial bias or patterns across all plates.
    ```r
    plateHeatmap(example_dt)
    ```
*   **Scatter Plots**: Examine the distribution of controls vs. samples.
    ```r
    scatterPlot(example_dt, controlOnly = FALSE, control_name = c("PLK1 si1", "scrambled control si1"))
    ```
*   **siRNA Plots**: Detailed view of a specific gene's performance across replicates.
    ```r
    siRNAPlot("AAK1", example_dt, controlsiRNA = c("lipid only"), treatment = "treatment", control = "control")
    ```

## Hit Selection Methods

`synlet` supports four primary algorithms for identifying synthetic lethal hits:

### 1. Student's t-test (on B-scores)
Calculates B-scores to account for plate effects, then applies t-tests with BH correction.
```r
# Calculate B-scores for a master plate
bscore_res <- bScore(masterPlateName, example_dt, treatment = "treatment", control = "control")
# Apply t-test (assuming 3 treatment and 3 control replicates)
t_res <- tTest(bscore_res, 3, 3)
```

### 2. Median ± k*MAD
A robust non-parametric method for hit selection.
```r
mad_res <- madSelect(example_dt, control = "control", treatment = "treatment", k = 3)
```

### 3. Rank Products
A non-parametric method effective for finding consistently regulated genes across replicates.
```r
rp_res <- rankProdHits(example_dt, control = "control", treatment = "treatment")
```

### 4. Redundant siRNA Activity (RSA)
Systemically uses information from multiple siRNAs targeting the same gene to reduce off-target false positives.
```r
rsaHits(example_dt, treatment = "treatment", control = "control", outputFile = "RSAhits.csv")
```

## Workflow Tips

*   **Hit Consolidation**: High-confidence hits are typically those identified by at least two different statistical methods.
*   **Multi-siRNA Rule**: An interesting gene should ideally show a significant effect in at least two different siRNAs to rule out off-target effects.
*   **Normalization**: By default, `madSelect` uses fraction of samples normalization. This can be adjusted via the `normMethod` parameter.

## Reference documentation

- [A working Demo for synlet](./references/synlet-vignette.md)