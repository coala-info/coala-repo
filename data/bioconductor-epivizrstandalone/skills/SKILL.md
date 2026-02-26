---
name: bioconductor-epivizrstandalone
description: This tool runs the Epiviz interactive genomic visualization application locally within an R session. Use when user asks to launch a standalone genome browser, visualize functional genomics data tracks, or create interactive plots from Bioconductor objects.
homepage: https://bioconductor.org/packages/release/bioc/html/epivizrStandalone.html
---


# bioconductor-epivizrstandalone

name: bioconductor-epivizrstandalone
description: Use this skill to run the Epiviz interactive genomic visualization app locally within R. It enables two-way communication between R/Bioconductor and the Epiviz JS framework for browsing genomes, visualizing tracks, and creating plots (scatterplots, heatmaps) using local Bioconductor infrastructure. Use when the user needs to launch a standalone genome browser or connect to the Epiviz desktop application from an R session.

## Overview
The `epivizrStandalone` package allows users to run the Epiviz web application UI entirely within a local R session. It leverages the `epivizr` framework to provide interactive visualizations of functional genomics data. By running standalone, it can browse any genome supported by Bioconductor (e.g., Human, Mouse) without requiring an external web server. It supports both a browser-based viewer and an Electron-based desktop application.

## Typical Workflow

### 1. Launching the Standalone App
To start the visualization tool within R (often appearing in the RStudio Viewer or a browser window), use a `GenomicFeatures` or `OrganismDb` object to define the genome.

```r
library(epivizrStandalone)
library(Mus.musculus)

# Define the genome and start the app
# keep_seqlevels limits the chromosomes displayed
app <- startStandalone(Mus.musculus, 
                       keep_seqlevels = paste0("chr", c(1:19, "X", "Y")), 
                       verbose = TRUE, 
                       use_viewer_option = TRUE)
```

### 2. Launching the Desktop Application
If the Epiviz Desktop app (Electron-based) is preferred, use the `startStandaloneApp` function.

```r
app <- startStandaloneApp(Mus.musculus, 
                          keep_seqlevels = paste0("chr", c(1:19, "X", "Y")), 
                          verbose = TRUE)
```

### 3. Managing the Session
The object returned (`app`) is an environment or reference class object used to manage the connection.

*   **Stop the app:** `app$stop_app()`
*   **Interact with data:** Once the app is running, use standard `epivizr` methods (like `app$plot()` or `app$add_measurements()`) to send R data objects (GRanges, SummarizedExperiment) to the browser for visualization.

## Tips and Best Practices
*   **Genome Selection:** Always provide a valid OrganismDb or TxDb object to `startStandalone` to ensure the genome coordinates and navigation work correctly.
*   **Memory Management:** Large datasets should be filtered or subsetted before being sent to the visualization to maintain performance.
*   **Viewer Integration:** Setting `use_viewer_option = TRUE` is recommended when working in RStudio to keep the visualization within the IDE panes.
*   **Communication:** Remember that this package uses Websockets. If you encounter connection issues, ensure no firewall is blocking the local ports used by the app.

## Reference documentation
- [Introduction to epivizrStandalone](./references/EpivizrStandalone.md)