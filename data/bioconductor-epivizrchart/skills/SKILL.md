---
name: bioconductor-epivizrchart
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/epivizrChart.html
---

# bioconductor-epivizrchart

## Overview

The `epivizrChart` package enables the creation of interactive genomic visualizations using the Epiviz framework. It leverages web components (Polymer) to provide high-performance, linked visualizations that can be embedded directly into RMarkdown documents, HTML reports, or Shiny applications. The package separates data management from visualization, allowing multiple charts to share a single data source and support cross-chart brushing and navigation.

## Core Components

- **epivizChart**: A standalone chart component for a specific data object.
- **epivizEnv**: A data container that manages multiple charts. It enables brushing (linked highlighting) across all child charts.
- **epivizNav**: An extension of `epivizEnv` that includes genomic context (chromosome, start, end) and navigation controls (pan, zoom, gene search).

## Typical Workflow

### 1. Basic Chart Creation
`epivizrChart` automatically infers the chart type based on the input data object, but it can be overridden using the `chart` parameter.

```r
library(epivizrChart)
library(Homo.sapiens)

# Create a genes track
genes_track <- epivizChart(Homo.sapiens, chr="chr11", start=118000000, end=121000000)

# Create a scatter plot from a data frame or SummarizedExperiment
scatter_plot <- epivizChart(tcga_colon_curves, 
                           columns=c("cancerMean","normalMean"), 
                           chart="ScatterPlot")
```

### 2. Using Environments for Linked Plots
To link multiple plots (e.g., so brushing a point in a scatter plot highlights the region in a track), use `epivizEnv`.

```r
# Initialize environment
env <- epivizEnv(chr="chr11", start=118000000, end=121000000)

# Add plots to the environment
env$plot(Homo.sapiens)
env$plot(tcga_colon_blocks, datasource_name="450kMeth")

# Render the environment (displays all linked charts)
env
```

### 3. Visualizing Files with IGV.js
The package supports visualizing local or remote files using IGV.js tracks within an Epiviz environment.

```r
library(Rsamtools)
file_bam <- BamFile("http://path.to/remote.bam")

env <- epivizEnv(chr="chr11", start=118000000, end=121000000)
env$plot(file_bam, datasource_name="BAM_Track")
```

### 4. Integration with Shiny
To use these charts in a Shiny app, use `renderUI` and register the shiny handler to manage data requests.

```r
ui <- fluidPage(uiOutput("epivizChart"))

server <- function(input, output, session) {
  nav <- epivizNav(chr="chr11", start=118000000, end=121000000, interactive=TRUE)
  nav$plot(Homo.sapiens)
  
  output$epivizChart <- renderUI({
    nav$render_component(shiny=TRUE)
  })
  
  nav$register_shiny_handler(session)
}
```

## Supported Chart Types
- `BlocksTrack`: For genomic regions (GRanges).
- `HeatmapPlot`: For matrix-like data (SummarizedExperiment, ExpressionSet).
- `LinePlot` / `LineTrack`: For base-pair level or quantitative data.
- `ScatterPlot`: For comparing two columns of data.
- `StackedLinePlot` / `StackedLineTrack`.

## Tips and Best Practices
- **Interactive Mode**: When working in a live R session (not just knitting a static doc), set `interactive=TRUE` in the environment to enable websocket-based data fetching.
- **Memory Efficiency**: Use `env$plot(measurements = ...)` to create new charts from data already loaded into the environment rather than re-uploading the same object.
- **Browser Compatibility**: IGV.js components may not render correctly in the RStudio internal viewer; use Chrome or Firefox for the best experience.
- **Settings**: Use `chart_object$get_available_settings()` to see customization options like colors, titles, and margins.

## Reference documentation

- [Visualizing Files with epivizrChart (IGV.js)](./references/IntegrationWithIGVjs.md)
- [Visualizing genomic data in Shiny Apps](./references/IntegrationWithShiny.md)
- [Visualizing Epiviz Web Components with epivizrChart](./references/IntroToEpivizrChart.md)
- [Visualizing RangeSummarizedExperiment objects in Shiny](./references/VisualizeSumExp.md)