---
name: bioconductor-omxplore
description: omXplore provides a suite of interactive Shiny modules for visualizing and exploring high-dimensional omics data such as genomics, transcriptomics, and proteomics. Use when user asks to interactively visualize omics datasets, perform PCA, generate heatmaps, analyze intensity distributions, or explore connected components in peptide-protein graphs.
homepage: https://bioconductor.org/packages/release/bioc/html/omXplore.html
---


# bioconductor-omxplore

## Overview

`omXplore` (Omics Explore) is a Bioconductor package providing a suite of interactive Shiny modules for visualizing high-dimensional omics data (genomics, transcriptomics, proteomics). It acts as a versatile hub that supports standard Bioconductor objects and allows for easy extension via third-party plot modules. Key visualizations include PCA, heatmaps, density plots, intensity distributions (boxplots/violin plots), and graph-based connected components.

## Core Workflows

### 1. Interactive Dataset Exploration
The primary entry point for the package is `view_dataset()`. This function launches a comprehensive Shiny dashboard that allows users to switch between different assays within a dataset and select various visualization modules.

```r
library(omXplore)
data(sub_R25)

# Launch the main interactive hub
app <- view_dataset(sub_R25)
shiny::runApp(app)
```

### 2. Using Individual Plot Modules
Each visualization is available as a standalone Shiny module. These functions typically require the dataset and the index of the assay to be analyzed.

Available modules include:
- `omXplore_pca()`: Principal Component Analysis.
- `omXplore_density()`: Density plots of quantitative data.
- `omXplore_intensity()`: Boxplots and violin plots.
- `omXplore_heatmap()`: Interactive heatmaps.
- `omXplore_cc()`: Connected components for peptide-protein graphs.
- `omXplore_corrmatrix()`: Correlation matrices.
- `omXplore_variance()`: Variance distribution analysis.

Example of launching a specific module:
```r
# Launch only the density plot for the first assay
app <- omXplore_density(sub_R25, 1)
shiny::runApp(app)
```

### 3. Extending with Third-Party Plots
You can add custom plots to the `view_dataset` interface by passing an `addons` list.

**From a Package:**
```r
addons <- list(
  myCustomPkg = c("plotModule1", "plotModule2")
)
view_dataset(sub_R25, addons = addons)
```

**From the Global Environment:**
To register a plot from the R console, prefix the functions with `omXplore_` and ensure they are loaded before calling `view_dataset()`.
```r
omXplore_myPlot_ui <- function(id) { ... }
omXplore_myPlot_server <- function(id, obj, i) { ... }
omXplore_myPlot <- function(obj, i) { ... } # Wrapper
```

## Data Compatibility
`omXplore` automatically converts the following formats into an internal enriched `MultiAssayExperiment` (MAE) structure:
- `SummarizedExperiment`
- `MultiAssayExperiment`
- `MSnSet`
- `QFeatures`
- `list`, `data.frame`, or `matrix` (quantitative tables)

## Tips for Usage
- **Assay Selection**: In the main UI, use the sidebar widget to toggle between different experiments (e.g., peptide-level vs. protein-level data).
- **Metadata Enrichment**: `omXplore` looks for specific metadata slots like `type`, `colID`, and `proteinID` to optimize plot displays.
- **Standalone Integration**: Because these are Shiny modules, they can be embedded into larger bioinformatics applications (like Prostar).

## Reference documentation
- [Adding third party plots](./references/addingThirdPartyPlots.md)
- [omXplore: a versatile series of Shiny apps to explore 'omics' data](./references/omXplore.md)