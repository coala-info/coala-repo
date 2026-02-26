---
name: bioconductor-iseehub
description: iSEEhub provides an interactive interface for browsing and visualizing Bioconductor ExperimentHub datasets using the iSEE framework. Use when user asks to browse ExperimentHub datasets, launch the iSEEhub Shiny application, or configure interactive data visualizations for omics datasets.
homepage: https://bioconductor.org/packages/release/bioc/html/iSEEhub.html
---


# bioconductor-iseehub

name: bioconductor-iseehub
description: Interactive exploration of Bioconductor ExperimentHub datasets using the iSEE framework. Use this skill to launch the iSEEhub Shiny application, browse available datasets, and configure initial panel layouts for interactive data visualization.

## Overview
iSEEhub provides an interactive interface to browse and load datasets from the Bioconductor ExperimentHub into the iSEE (Interactive SummarizedExperiment Explorer) environment. It acts as a bridge, allowing users to search for omics datasets via metadata and immediately visualize them without manual data downloading or object construction.

## Installation
Install the package via BiocManager:
```r
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("iSEEhub")
```

## Basic Workflow
The primary entry point is the `iSEEhub()` function, which requires an `ExperimentHub` object.

1. **Initialize ExperimentHub**:
   ```r
   library(iSEEhub)
   library(ExperimentHub)
   ehub <- ExperimentHub()
   ```

2. **Launch the App**:
   ```r
   app <- iSEEhub(ehub)
   if (interactive()) {
     shiny::runApp(app)
   }
   ```

## Key Features and Parameters
- **Runtime Installation**: Use `runtime_install = TRUE` to allow the app to prompt for and install missing package dependencies required by specific ExperimentHub datasets.
  ```r
  app <- iSEEhub(ehub, runtime_install = TRUE)
  ```
- **Dataset Selection**: The app features an "ExperimentHub" pane for filtering/sorting datasets and a "Selected Dataset" pane for viewing metadata and launching the iSEE interface.
- **Initial Configurations**: Users can choose between "Default" (auto-detects compatible panels) or dataset-specific configurations (pre-defined scripts) in the "Config" tab before clicking "Launch!".

## Custom Initial Configurations
Initial configurations are R scripts that define an `initial` object (a list of iSEE panel instances).
- **Location**: Stored in `inst/initial/EHXXXX` where `EHXXXX` is the ExperimentHub identifier.
- **Structure**:
  ```r
  library(iSEE)
  initial <- list(
      ComplexHeatmapPlot(PanelWidth = 6L),
      RowDataPlot()
  )
  ```

## Tips for Usage
- **Dependencies**: Many datasets require specific packages (e.g., SingleCellExperiment). If `runtime_install` is FALSE, you must manually install suggested packages from the R console if a load fails.
- **Metadata**: Use the `Show columns` input in the app to customize which ExperimentHub metadata fields are visible during browsing.
- **Public Servers**: For hosted applications, it is recommended to set `runtime_install = FALSE` to maintain environment stability.

## Reference documentation
- [Contributing to iSEEhub](./references/contributing.md)
- [Introduction to iSEEhub](./references/iSEEhub.md)