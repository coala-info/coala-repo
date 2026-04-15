---
name: bioconductor-onesense
description: This tool performs one-dimensional stochastic embedding to visualize relationships between marker categories in high-dimensional cytometry data. Use when user asks to categorize cellular parameters, visualize relationships between marker groups using 1D t-SNE, or generate median and frequency heatplots for cytometry data.
homepage: https://bioconductor.org/packages/3.8/bioc/html/oneSENSE.html
---

# bioconductor-onesense

name: bioconductor-onesense
description: Perform One-Dimensional Soli-Expression by Nonlinear Stochastic Embedding (oneSENSE) for high-dimensional cytometry data. Use this skill to categorize cellular parameters into predefined groups and visualize them using t-SNE-based one-dimensional maps, heatplots, and frequency plots to assess relationships between marker categories.

# bioconductor-onesense

## Overview

oneSENSE is a dimensionality reduction method designed for high-dimensional cytometry data (e.g., CyTOF or flow cytometry). It partitions markers into biologically relevant categories (e.g., phenotypic markers vs. functional markers) and computes a 1D t-SNE projection for each category. By plotting these 1D projections against each other, users can visualize the relationship between different marker groups simultaneously.

## Installation and Loading

To install and load the package:

```R
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("oneSENSE")

library(oneSENSE)
```

## Core Workflow

The package is primarily designed to be used via a Graphical User Interface (GUI), which handles data loading, marker selection, and plot generation.

### Using the GUI

To launch the interactive interface:

```R
onesense_GUI()
```

**Workflow Steps in GUI:**
1. **Directory Selection:** Choose the folder containing your FCS files.
2. **Marker Selection:** Select and group markers into Category 1, Category 2, and optionally Category 3.
3. **Subsampling:** Define the "cell ceiling" (number of cells to subsample per file) to manage computational load.
4. **Binning:** Set the number of bins for sorting cells into the heatplot grid.
5. **Analysis:** Submit to generate median heatplots.
6. **Frequency Analysis:** Use "Select Coordinates" and "Generate CSV" to produce frequency-based heatplots.

## Key Concepts

- **Categorization:** Unlike standard t-SNE which uses all markers for a 2D map, oneSENSE uses specific subsets for each axis. This makes the axes inherently interpretable.
- **Median Heatplots:** These show the median expression of markers across the 1D t-SNE axes, allowing for the identification of specific cell populations based on their signature in both categories.
- **Frequency Heatplots:** These visualize the density or distribution of cells across the defined categories.

## Tips for Success

- **Data Preparation:** Ensure FCS files are pre-processed (compensated and transformed) before loading into oneSENSE.
- **Computational Time:** t-SNE is computationally intensive. Start with a lower "cell ceiling" (e.g., 1000-2000 cells per file) to test the categorization before running a full analysis.
- **Marker Grouping:** Group markers that are functionally related (e.g., all T-cell activation markers in one category and lineage markers in another) to maximize the biological insight from the resulting plots.

## Reference documentation

- [Quickstart guide](./references/quickstart.md)