---
name: bioconductor-rifi
description: This tool analyzes RNA stability and transcription kinetics from Rifampicin time-series data using an annotation-agnostic fragmentation approach. Use when user asks to estimate RNA half-life, calculate transcription velocity, or identify transcriptional events such as pausing sites, internal transcription start sites, and transcriptional interference.
homepage: https://bioconductor.org/packages/release/bioc/html/rifi.html
---


# bioconductor-rifi

name: bioconductor-rifi
description: Analysis of RNA stability and transcription kinetics using Rifampicin time-series data (microarray or RNA-seq). Use this skill to estimate RNA half-life, transcription velocity, and identify transcriptional events like pausing sites, internal TSS (iTSS), processing sites, and transcriptional interference (TI).

# bioconductor-rifi

## Overview

The `rifi` package provides a comprehensive workflow for analyzing bacterial transcription dynamics from Rifampicin time-series data. Unlike standard methods that average half-lives across annotated genes, `rifi` uses an annotation-agnostic, hierarchical fragmentation approach. It fits non-linear regression models to individual probes or bins to estimate three key parameters: decay constant ($\lambda$), delay (time before decay starts), and transcription interference (TI) factors.

## Core Workflow

The package is designed to be used either via a high-level wrapper or a step-by-step pipeline.

### 1. Quick Start (Wrapper)
The `rifi_wrapper` function executes the entire pipeline, from preprocessing to visualization.
```r
library(rifi)
data(example_input_e_coli)
gff_path <- system.file("extdata", "gff_e_coli.gff3.gz", package = "rifi")

result_list <- rifi_wrapper(
  inp = example_input_e_coli,
  path = gff_path,
  cores = 2,
  bg = 0,      # Background intensity (0 for RNA-seq)
  restr = 0.01 # Restriction for the fit
)
```

### 2. Step-by-Step Pipeline
For custom control, execute the functions in this specific order:

1.  **Preprocessing**: `rifi_preprocess()` filters background and identifies potential TI/PDD regions.
2.  **Fitting**: `rifi_fit()` applies non-linear regression to estimate delay and half-life for each bin.
3.  **Penalties**: `rifi_penalties()` automatically determines optimal penalties for dynamic programming.
4.  **Fragmentation**: `rifi_fragmentation()` groups bins into segments based on similar properties (Delay -> Half-life -> Intensity).
5.  **Statistics**: `rifi_stats()` identifies significant events (pausing, iTSS, termination).
6.  **Summary & Visualization**: `rifi_summary()` generates result tables; `rifi_visualization()` produces the genome-wide plot.

## Data Input Requirements

The input must be a `SummarizedExperiment` object:
*   **Assays**: Matrix of intensities. The first column must be named "0" (pre-Rifampicin).
*   **rowRanges**: Must contain `ID` (unique per position/strand) and `position`.
*   **colData**: Must contain `timepoint` and `replicate` columns.

## Interpreting Results

Results are stored in the `metadata()` of the final `SummarizedExperiment` object:
*   `dataframe_summary_1`: Bin-level fit results.
*   `dataframe_summary_2`: Fragment-level results (mean half-life, velocity).
*   `dataframe_summary_events`: Identified transcriptional events:
    *   **PS (Pausing Site)**: Sudden increase in delay.
    *   **iTSS**: Sudden decrease in delay or increase in synthesis ratio.
    *   **Velocity (V)**: Change in the slope of the delay fragment.
    *   **Processing Site**: Change in half-life within the same TU.
    *   **Termination (Ter)**: Decrease in intensity/synthesis ratio.

## Tips for Success

*   **System Requirement**: `rifi` is only available for Unix-based systems.
*   **Background**: For microarray data, correctly identifying the background (`bg`) is critical for accurate half-life estimation.
*   **Binning**: For RNA-seq, data should be binned (e.g., 50nt) before input.
*   **Penalties**: If the visualization shows too many "mini-segments" or segments that are too long, manually adjust the penalties in the fragmentation step.

## Reference documentation
- [rifi for decay estimation](./references/vignette.md)
- [rifi Rmd source](./references/vignette.Rmd)