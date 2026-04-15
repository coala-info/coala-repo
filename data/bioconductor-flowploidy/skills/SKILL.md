---
name: bioconductor-flowploidy
description: The flowPloidy package provides automated analysis of DNA flow cytometry data using non-linear regression to model cell populations and account for debris. Use when user asks to analyze genome size, estimate ploidy from flow cytometry histograms, or calculate DNA content using internal standards.
homepage: https://bioconductor.org/packages/release/bioc/html/flowPloidy.html
---

# bioconductor-flowploidy

## Overview

The `flowPloidy` package provides an automated and objective approach to analyzing DNA flow cytometry data. Unlike manual gating, it uses non-linear regression to model cell populations (G1 and G2 peaks) as normal curves while accounting for debris and S-phase components. This ensures repeatable results and accurate Coefficient of Variation (CV) calculations.

## Installation

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("flowPloidy")
# Optional: for example data
BiocManager::install("flowPloidyData")
```

## Typical Workflow

### 1. Data Import and Channel Selection
Before loading files, identify the correct fluorescence channel (e.g., "FL3.INT.LIN" or "FL2.A").

```r
library(flowPloidy)
library(flowPloidyData)

# List your files
my_files <- list.files("~/path/to/data", full.names = TRUE, pattern = ".LMD")

# View available channels in a file
viewFlowChannels(my_files[1])

# Batch process files
# 'standards' can be a single value or a vector of known genome sizes (pg)
batch1 <- batchFlowHist(my_files, channel = "FL3.INT.LIN", standards = 1.11)
```

### 2. Interactive Review and Correction
The `browseFlowHist` function opens a Shiny-based web interface. **Crucial:** You must assign the output back to a variable to save changes.

```r
# Update analyses 'in place'
batch1 <- browseFlowHist(batch1)
```

**Common Adjustments in the GUI:**
*   **Peak Positioning:** If the automated fit fails, select the peak (A or B) and click the correct location on the histogram.
*   **Debris Model:** Toggle between Single-Cut (SC) and Multi-Cut (MC). Use the one that yields a lower Residual Chi-Square (RCS).
*   **Standard Identification:** Use the "Standard Peak" dropdown to label which peak (A or B) is the known standard.
*   **Gating:** If debris obscures peaks, use the Gating tab to draw a rectangle around the nuclei clusters (typically plotting Fluorescence vs. Side Scatter).

### 3. Exporting Results
Once the GUI is closed (using the **Exit** button), extract the data into a dataframe.

```r
# Generate summary table
results <- tabulateFlowHist(batch1)

# Export to CSV
tabulateFlowHist(batch1, file = "ploidy_results.csv")

# Save the R object for future sessions
save(batch1, file = "my_analyses.Rdata")
```

## Key Parameters and Metrics

*   **RCS (Residual Chi-Square):** A goodness-of-fit measure. Values between 0.7 and 4 are generally acceptable. Very high or `Inf` values indicate a failed fit or local minima trap.
*   **CV (Coefficient of Variation):** Indicates peak quality. Values below 5% are standard for reliable genome size estimation.
*   **Linearity:** The ratio between G1 and G2 peaks (ideally 2.0). `flowPloidy` fits this as a parameter between 1.5 and 2.5.
*   **pg:** The calculated genome size of the unknown sample, provided the standard peak and size were defined.

## Reference documentation

- [flowPloidy: Getting Started](./references/flowPloidy-gettingStarted.md)
- [flowPloidy: Flow Cytometry Histograms](./references/histogram-tour.md)