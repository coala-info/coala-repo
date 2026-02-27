---
name: bioconductor-tdaracne
description: This tool infers gene regulatory networks from time-course gene expression data using the TimeDelay-ARACNE algorithm. Use when user asks to reconstruct oriented gene interaction graphs, detect time-delayed dependencies between genes, or analyze biological pathways from longitudinal transcriptomic data.
homepage: https://bioconductor.org/packages/3.6/bioc/html/TDARACNE.html
---


# bioconductor-tdaracne

name: bioconductor-tdaracne
description: Infer gene regulatory networks from time-course gene expression data using the TimeDelay-ARACNE (TD-ARACNE) algorithm. Use this skill when you need to reconstruct oriented gene interaction graphs, detect time-delayed dependencies between genes, or analyze biological pathways (like SOS or Yeast cell cycle) from longitudinal transcriptomic data.

# bioconductor-tdaracne

## Overview

TDARACNE (TimeDelay ARACNE) is an R package designed to infer gene regulatory networks from time-series measurements. Unlike the original ARACNE algorithm which handles steady-state data, TD-ARACNE detects dependencies between genes at different time delays using mutual information and a stationary Markov Random Field model. It produces oriented graphs that can identify the direction of regulation and discover cyclic interactions even with medium-to-small datasets.

## Core Workflow

### 1. Data Preparation
The package expects input as an `ExpressionSet` object. Data should be numeric and organized with genes as rows and time points as columns.

```r
library(TDARACNE)

# Load example data (e.g., Yeast, SOS pathway, or IRMA synthetic network)
data(dataIRMAon)
data(threshIRMAon) # Pre-calculated thresholds are often provided for examples
```

### 2. Network Inference
The primary function is `TDARACNE()`. It performs three steps: detecting initial changes in expression (IcE), network construction, and network pruning via the Data Processing Inequality (DPI).

```r
# Basic execution
result <- TDARACNE(
  eSet = dataIRMAon, 
  N = 11,               # Number of bins for normalization
  delta = 3,            # Maximum time delay allowed
  likehood = 1.2,       # Fold change threshold for initial change
  norm = 2,             # 1 for percentile (row), 2 for Rank normalization
  logarithm = 1,        # 0 if data is already log-transformed, 1 otherwise
  thresh = threshIRMAon,# Influence threshold (0 if unknown)
  ksd = 0,              # Standard deviation multiplier
  tolerance = 0.15,     # DPI tolerance (0.15 is default)
  plot = TRUE,          # Automatically plot the graph
  dot = FALSE,          # Set TRUE to save a .dot file
  adj = TRUE            # Set TRUE to return an adjacency matrix
)
```

### 3. Parameter Tuning
- **delta**: Crucial parameter. It defines the search window for time delays. If set too low, long-range dependencies are missed; if too high, computational cost increases and false positives may rise.
- **tolerance**: Controls the pruning of indirect interactions. A value of 0 is strict; 1 disables DPI pruning entirely.
- **norm**: Choose `1` for percentile normalization or `2` for Rank normalization based on your data distribution.

## Output Formats
Depending on the parameters, `TDARACNE()` can return:
- A `graphNEL` object (default).
- An adjacency matrix (if `adj = TRUE`).
- A `.dot` file for Graphviz (if `dot = TRUE`).
- A visual plot (if `plot = TRUE`).

## Tips for Success
- **Dependencies**: Ensure `GenKern`, `Biobase`, and `Rgraphviz` are installed, as TDARACNE relies on them for kernel density estimation and visualization.
- **Thresholding**: If you do not have a pre-calculated threshold, set `thresh = 0`. The algorithm will attempt to calculate an automated threshold.
- **Published Results**: To replicate the results from the original TD-ARACNE publication, you can run the helper function `TDARACNEdataPublished()`, though note it is computationally intensive.

## Reference documentation
- [TDARACNE](./references/TDARACNE.md)