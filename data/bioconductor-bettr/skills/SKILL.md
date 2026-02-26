---
name: bioconductor-bettr
description: The bioconductor-bettr package provides tools for the visual exploration, aggregation, and comparative analysis of benchmarking results. Use when user asks to aggregate performance metrics, rank methods, create interactive benchmarking dashboards, or generate heatmaps and polar plots for benchmark data.
homepage: https://bioconductor.org/packages/release/bioc/html/bettr.html
---


# bioconductor-bettr

name: bioconductor-bettr
description: Visual exploration and comparative analysis of benchmark results using the bettr package. Use when you need to aggregate multiple performance metrics, rank methods, and create interactive or static visualizations (heatmaps, polar plots) for benchmarking studies.

# bioconductor-bettr

## Overview
The `bettr` package is designed for the visual exploration of benchmark results. It allows users to aggregate multiple evaluation metrics, apply custom transformations (scaling, flipping signs), and weight different metrics to produce a unified performance score. While it features a robust Shiny interface for interactive exploration, it also provides a programmatic workflow for data preparation and static plotting.

## Core Workflow

### 1. Data Preparation
The primary input is a `data.frame` where rows are methods and columns are metrics. You can also provide metadata for metrics (grouping) and methods (annotations).

```r
library(bettr)
library(SummarizedExperiment)

# Example data
df <- data.frame(Method = c("M1", "M2", "M3"),
                 metric1 = c(1.0, 2.0, 3.0),
                 metric2 = c(3.0, 1.0, 2.0))

# Metric metadata (e.g., grouping metrics into classes)
metricInfo <- data.frame(Metric = c("metric1", "metric2"),
                         Group = c("G1", "G2"))

# Assemble into a SummarizedExperiment
se <- assembleSE(df = df, idCol = "Method", metricInfo = metricInfo)
```

### 2. Defining Transformations
Metrics often have different scales or directions (e.g., higher is better vs. lower is better). Use `initialTransforms` to standardize them.

*   `flip`: Set to `TRUE` if lower values are better.
*   `transform`: Options include `[0,1]`, `[-1,1]`, `z-score`, or `Rank`.

```r
initialTransforms <- list(
  metric2 = list(flip = TRUE, transform = "[0,1]")
)

se <- assembleSE(df = df, idCol = "Method", 
                 metricInfo = metricInfo, 
                 initialTransforms = initialTransforms)
```

### 3. Interactive Exploration
Launch the Shiny app to interactively adjust weights, filter methods, and explore rankings.

```r
bettr(bettrSE = se)
```

### 4. Programmatic Plotting
To generate plots without the UI, use `bettrGetReady` to process the data, followed by specific plotting functions.

```r
# Prepare data (collapsing metrics by group and calculating weighted means)
prepData <- bettrGetReady(
    bettrSE = se, 
    idCol = "Method",
    scoreMethod = "weighted mean", 
    metricGrouping = "Group",
    metricCollapseGroup = TRUE
)

# Generate Heatmap
makeHeatmap(bettrList = prepData)

# Generate Polar Plot
makePolarPlot(bettrList = prepData)
```

## Tips for Success
*   **Metric Grouping**: Use the `metricInfo` argument in `assembleSE` to group related metrics (e.g., "Accuracy", "Runtime"). This allows you to collapse them into a single representative value in the visualizations.
*   **Custom Colors**: You can pass `idColors` and `metricColors` (as named lists) to `assembleSE` to ensure consistent branding across plots.
*   **Exporting from App**: To capture the state of an interactive session, run `app <- bettr(...)` and then `out <- shiny::runApp(app)`. Clicking "Close app" in the UI will return the processed data list to the `out` variable.

## Reference documentation
- [bettr](./references/bettr.md)