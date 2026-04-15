---
name: bioconductor-targetdecoy
description: This tool generates diagnostic plots to evaluate the quality of the Target Decoy Approach for FDR estimation in mass spectrometry proteomics. Use when user asks to assess TDA assumptions, generate histograms or PP-plots for PSM scores, and compare decoy distributions across multiple search engines or experimental runs.
homepage: https://bioconductor.org/packages/release/bioc/html/TargetDecoy.html
---

# bioconductor-targetdecoy

name: bioconductor-targetdecoy
description: Diagnostic plots to evaluate the quality of the Target Decoy Approach (TDA) in Mass Spectrometry (MS) based proteomics. Use when you need to assess if TDA assumptions are met for peptide-to-spectrum matches (PSMs) using histograms and PP-plots. Supports mzID, mzR, and data.frame objects.

# bioconductor-targetdecoy

## Overview

The `TargetDecoy` package provides diagnostic tools to evaluate the key assumptions of the Target Decoy Approach (TDA) used in MS-based proteomics for False Discovery Rate (FDR) estimation. It generates histograms and Probability-Probability (PP) plots to ensure that decoy PSM scores are a good simulation of incorrect target PSM scores.

## Installation

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("TargetDecoy")
```

## Data Loading

The package supports `mzID` and `mzRIdent` objects, as well as standard `data.frame` objects.

```r
library(TargetDecoy)

# Loading an mzid file using mzID
library(mzID)
mz_obj <- mzID("path/to/file.mzid")

# Loading an mzid file using mzR
library(mzR)
mzr_obj <- openIDfile("path/to/file.mzid")
```

## Core Functions and Workflows

### 1. Comprehensive Evaluation
Use `evalTargetDecoys()` to generate a 4-plot summary (Histogram, PP-plot, and zoomed versions of both).

```r
evalTargetDecoys(mz_obj, 
                 decoy = "isdecoy", 
                 score = "ms-gf:specevalue", 
                 log10 = TRUE, 
                 nBins = 50)
```

### 2. Individual Diagnostic Plots
Generate specific plots for more control or custom ggplot manipulation.

*   **Histogram**: Compares target and decoy score distributions.
    ```r
    evalTargetDecoysHist(mz_obj, decoy = "isdecoy", score = "score_var", log10 = TRUE)
    ```
*   **PP-plot**: Plots the ECDF of targets against decoys.
    ```r
    evalTargetDecoysPPPlot(mz_obj, decoy = "isdecoy", score = "score_var", log10 = TRUE)
    ```

### 3. Comparing Multiple Search Engines
Use `createPPlotScores()` when a single file contains scores from multiple algorithms (e.g., MS-GF+, X!Tandem, OMSSA).

```r
createPPlotScores(mz_obj,
                  decoy = "isdecoy",
                  scores = c("omssa:evalue", "ms-gf:specevalue"),
                  log10 = c(TRUE, TRUE))
```

### 4. Comparing Multiple Runs
Use `createPPlotObjects()` to compare TDA quality across different experimental runs or files.

```r
mz_list <- list(Run1 = obj1, Run2 = obj2)
createPPlotObjects(mz_list, decoy = "isdecoy", score = "score_var")
```

## Interpretation Guidelines

*   **Histogram**: The decoy distribution (blue) should match the shape of the first mode (incorrect hits) of the target distribution (red).
*   **PP-plot**: The points at lower percentiles should follow a straight line through the origin. The slope of this line estimates $\pi_0$ (the fraction of incorrect PSMs).
*   **Standardized PP-plot**: In multi-engine plots, the "standardized" version removes the $\pi_0$ slope; deviations from the 0-line indicate violations of TDA assumptions.
*   **Common Issues**: If the PP-plot deviates from the straight line at low scores, the decoys are not representative of bad target hits (common in "two-pass" search strategies like X!Tandem).

## Tips
*   **Log Transformation**: Set `log10 = TRUE` for E-values or Expectation values where smaller is better.
*   **Interactive Selection**: If you call `evalTargetDecoys(mz_obj)` without specifying `decoy` or `score` arguments in an interactive R session, a Shiny gadget will launch to help you select variables.
*   **ggplot2 Integration**: All plotting functions return `ggplot` objects, allowing for further customization (e.g., `+ theme_bw()` or `+ coord_cartesian()`).

## Reference documentation
- [Introduction to TargetDecoy](./references/TargetDecoy.md)
- [TargetDecoy Vignette Source](./references/TargetDecoy.Rmd)