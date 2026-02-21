---
name: bioconductor-interactivedisplay
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/interactiveDisplay.html
---

# bioconductor-interactivedisplay

name: bioconductor-interactivedisplay
description: Use when an AI agent needs to perform interactive visualization of Bioconductor objects (GRanges, GRangesList, ExpressionSet, RangedSummarizedExperiment) or data frames using the interactiveDisplay R package. This skill is triggered when a user wants to launch Shiny-based web applications for genomic data exploration, subsetting, and returning results to the R console.

# bioconductor-interactivedisplay

## Overview

The `interactiveDisplay` package provides a Shiny-based framework for the interactive visualization of common Bioconductor data objects. It allows users to explore genomic data, gene expression, and metadata through web-based interfaces that include track plots (via Gviz/ggbio), network graphs (via D3.js), and heatmaps. A key feature is the ability to subset data interactively within the UI and return the selected subset back to the R session for further analysis.

## Core Workflows

### 1. Launching the Interactive Display
The primary function is `display()`, which is S4 dispatched to handle different object types.

```R
library(interactiveDisplay)

# For GRanges or GRangesList
# Launches a UI with trackplots, ideograms, and range filtering
new_ranges <- display(my_granges)

# For ExpressionSet
# Launches a UI with heatmaps, network views, and GO summaries
display(my_exprSet)

# For RangedSummarizedExperiment
# Launches a UI for binned mean counts by position
display(my_se)

# For Data Frames
# Launches a searchable, sortable datatable
selected_rows <- display(my_df)
```

### 2. Returning Data to the Console
For `GRanges`, `GRangesList`, and `data.frame` methods, the `display()` function returns a value when the "Save to Console" or "Stop" button is clicked in the UI.

- **GRanges/GRangesList**: Use the "Deposit Ranges in View" button to collect subsets across different chromosomes, then "Save to Console" to return the combined object.
- **Data Frames**: Select rows in the table and exit to return the subset.

### 3. Visualizing Generic Grid Plots
The `gridsvgjs()` function can be used to wrap any grid-based plot (like those from `ggplot2` or `lattice`) in a local Shiny instance with pan and zoom capabilities.

```R
library(ggplot2)
p <- ggplot(mtcars, aes(wt, mpg)) + geom_point()
gridsvgjs(p)
```

### 4. Network Visualization
The `simplenet()` function provides a standalone method for visualizing numeric data frames as force-directed network graphs.

```R
simplenet(mtcars)
```

## Object-Specific Features

### ExpressionSet Exploration
- **Heatmaps**: Visualizes expression levels; can be suppressed or transposed for performance/clarity.
- **Network View**: Uses D3.js to show distances between samples or probes.
- **GO Summaries**: Provides Gene Ontology analysis for individual probes or clusters using `GOstats`.
- **Clustering**: Supports various distance and hierarchical clustering methods.

### Genomic Ranges (GRanges/GRangesList)
- **Ideograms**: Displays UCSC genome ideograms (requires internet access).
- **Trackplots**: Uses `Gviz` for coordinate-based visualization.
- **Filtering**: Interactive sliders for range length, strand selection, and genomic window.

## Tips for Effective Use
- **Dependencies**: Many dependencies (like `Gviz`, `ggbio`, or `GOstats`) are suggested. If a method fails, check the R console for messages indicating missing packages.
- **Memory/Performance**: For large `ExpressionSet` objects, use `sflag = FALSE` in `display()` or check the "Suppress Heatmap" box in the UI to avoid long rendering times.
- **Assignment**: Always assign the output of `display()` to a variable if you intend to save the interactive subsets (e.g., `result <- display(data)`).

## Reference documentation

- [interactiveDisplay: A package for enabling interactive visualization of Bioconductor objects](./references/interactiveDisplay.md)