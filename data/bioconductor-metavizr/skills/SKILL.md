---
name: bioconductor-metavizr
description: This tool provides an interactive WebSocket-based interface for visualizing and exploring metagenomics data through the Metaviz web application. Use when user asks to visualize MRexperiment or phyloseq objects interactively, perform facetzoom visualization of taxonomic hierarchies, compute alpha diversity or PCA within a dashboard, or manage connections between R sessions and the Metaviz browser.
homepage: https://bioconductor.org/packages/3.6/bioc/html/metavizr.html
---

# bioconductor-metavizr

name: bioconductor-metavizr
description: Interactive visualization and exploration of metagenomics data using the Metaviz web app. Use this skill when a user wants to: (1) Visualize MRexperiment or phyloseq objects interactively, (2) Perform facetzoom visualization of taxonomic hierarchies, (3) Compute alpha diversity or PCA within an interactive dashboard, or (4) Manage WebSocket connections between R/Bioconductor sessions and the Metaviz browser interface.

# bioconductor-metavizr

## Overview
The `metavizr` package implements a WebSocket-based interface between R/Bioconductor sessions and the Metaviz web application. It allows researchers to interactively visualize metagenomic datasets, specifically focusing on taxonomic hierarchies using d3.js-based visualizations like icicle plots and heatmaps. It supports two-way communication, where data filtered or selected in the web browser can be accessed in R, and R-driven analysis can be pushed to the browser.

## Typical Workflow

1. **Initialize Connection**: Start the Metaviz application instance.
2. **Prepare Data**: Load and validate `MRexperiment` (from `metagenomeSeq`) or `phyloseq` objects.
3. **Register Data**: Add the data object to the Metaviz app instance.
4. **Visualize**: Add charts (heatmaps, icicle plots) to the dashboard.
5. **Manipulate**: Use control functions to aggregate data at different taxonomic levels or select specific nodes.

## Key Functions

### App Management
- `startMetaviz()`: Starts a connection to the hosted Metaviz web app (default: http://metaviz.cbcb.umd.edu).
- `startMetavizStandalone()`: Launches a local instance of the Metaviz app, useful for offline work or RStudio Viewer integration.
- `app$stop_app()`: Closes the WebSocket connection and stops the app.

### Data Registration
- `register(object, ...)`: S4 method to register `MRexperiment` or `phyloseq` objects. Returns an `EpivizMetagenomicsData` object.
- `validateObject(object)`: Checks if an `MRexperiment` object is valid for use with `metavizr`.
- `replaceNAFeatures(fData, feature_order)`: Replaces NA or null taxonomic labels with "Not_Annotated", preventing hierarchy breaks.

### Visualization Control
- `metavizControl()`: Defines settings for plots, including `aggregateAtDepth`, `log` transformation, and `norm` (normalization).
- `generateSelection(feature_names, aggregation_level, selection_type)`: Creates a selection object to programmatically update the FacetZoom/icicle plot view.
- `buildMetavizGraph(object)`: Builds a `MetavizGraph` object from an `MRexperiment` to manage hierarchy queries.

## Examples

### Basic Interactive Session
```r
library(metavizr)
library(metagenomeSeq)
data(mouseData)

# Start the app
app <- startMetaviz()

# Register data (MRexperiment object)
# This automatically adds an icicle plot for the hierarchy
obj <- app$data_mgr$add_measurements(mouseData, "Mouse_Gut_Data")

# Add a heatmap for the registered data
chart <- app$chart_mgr$visualize("Heatmap", measurements = obj)

# Stop the app when finished
app$stop_app()
```

### Using Standalone Mode in RStudio
```r
# Run Metaviz in the RStudio Viewer pane
app <- startMetavizStandalone(use_viewer_option = TRUE)
```

### Customizing Aggregation
```r
# Set default aggregation to the Class level (depth 2 or 3 depending on data)
control <- metavizControl(aggregateAtDepth = 2, log = TRUE)
# Use this control when registering or updating charts
```

## Tips and Best Practices
- **Hierarchy Integrity**: Ensure your taxonomic data (fData) does not have gaps. Use `replaceNAFeatures()` if the hierarchy is incomplete.
- **Memory Management**: For very large metagenomic datasets, use `metavizControl(n = ...)` to limit the number of OTUs ranked and displayed to maintain browser performance.
- **Interactive Queries**: The `EpivizMetagenomicsData` object (returned by `register`) has methods like `$getPCA()` and `$getAlphaDiversity()` that can be called to retrieve analysis results based on the current browser state.

## Reference documentation
- [metavizr Reference Manual](./references/reference_manual.md)