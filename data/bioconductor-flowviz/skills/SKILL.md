---
name: bioconductor-flowviz
description: This tool provides visualization functions for flow cytometry data using the lattice graphics system. Use when user asks to create density plots, generate scatter plots for flowFrames or flowSets, visualize gating results, or display population statistics on flow cytometry plots.
homepage: https://bioconductor.org/packages/release/bioc/html/flowViz.html
---


# bioconductor-flowviz

name: bioconductor-flowviz
description: Visualization of flow cytometry data using the flowViz package. Use this skill when you need to create 1D density plots, 2D scatter plots (xyplot), or parallel coordinate plots for flow cytometry data (flowFrames or flowSets). It includes specialized support for visualizing gates (filters) and filter results, including geometric outlines, population statistics, and event highlighting.

# bioconductor-flowviz

## Overview
The `flowViz` package is the primary visualization tool for flow cytometry data in Bioconductor, built upon the `lattice` (Trellis) graphics system. It extends standard plotting functions to handle `flowFrame` and `flowSet` objects, allowing for high-dimensional data exploration through conditioning variables and integrated gating (filtering) visualizations.

## Core Workflows

### 1. Basic Data Visualization
The package uses a formula interface `y ~ x | conditioning` similar to `lattice`.

```r
library(flowViz)
data(GvHD)

# 2D Scatter plot (smoothed by default)
xyplot(`SSC-H` ~ `FSC-H` | Visit, data = GvHD, subset = Patient == "6")

# 1D Density plot (stacked by default)
densityplot(~ `FSC-H`, GvHD)

# Parallel coordinate plot
parallel(~ . | Visit, GvHD[1:2])
```

### 2. Visualizing Gates (Filters)
Gates can be added to plots using the `filter` argument. You can pass either a `filter` object (abstract definition) or a `filterResult` (computed result).

*   **Geometric Outlines:** For `rectangleGate`, `ellipsoidGate`, or `polygonGate`, boundaries are drawn automatically.
*   **Data-Driven Gates:** For `norm2Filter` or `curv2Filter`, it is more efficient to compute the `filterResult` first.

```r
# Define and apply a gate
rgate <- rectangleGate("FSC-H" = c(200, 400), "SSC-H" = c(200, 400))
n2Filter <- norm2Filter("SSC-H", "FSC-H", scale = 2)
res <- filter(GvHD, n2Filter)

# Plot with gate boundaries
xyplot(`SSC-H` ~ `FSC-H` | Visit, data = GvHD, filter = rgate)

# Plot with data-driven gate results
xyplot(`SSC-H` ~ `FSC-H` | Visit, data = GvHD, filter = res)
```

### 3. Highlighting Events and Statistics
To see individual cells instead of density clouds, set `smooth = FALSE`.

*   **Highlighting:** Points inside the gate are colored differently.
*   **Statistics:** Use `stat = TRUE` to display the percentage of events within the gate.
*   **Hexbinning:** For large datasets, use `xbin` to speed up non-smoothed plots.

```r
xyplot(`SSC-H` ~ `FSC-H` | Visit, data = GvHD, 
       filter = rgate, 
       smooth = FALSE, 
       stat = TRUE, 
       pos = 0.5, 
       abs = TRUE)

# Fast hexbin version
xyplot(`SSC-H` ~ `FSC-H` | Visit, data = GvHD, filter = rgate, xbin = 128)
```

### 4. Customizing Appearance
Use `flowViz.par.set` for global changes or `par.settings` for local function calls. Key categories include `gate`, `gate.density`, `gate.text`, and `flow.symbol`.

```r
# Change gate color and transparency
xyplot(`SSC-H` ~ `FSC-H` | Visit, data = GvHD, filter = rgate,
       par.settings = list(gate = list(fill = "red", alpha = 0.2)))

# Add population names
xyplot(`SSC-H` ~ `FSC-H` | Visit, data = GvHD, filter = res, names = TRUE)
```

## Tips and Best Practices
*   **Performance:** For complex data-driven filters (like `curv2Filter`), always compute the `filterResult` once and pass that to `xyplot` to avoid re-calculating during iterative plot adjustments.
*   **Subsetting:** Use the `subset` argument within plotting functions to evaluate expressions against `phenoData` or raw data without creating new objects.
*   **Transformations:** Apply transformations (e.g., `asinh` via `transformList`) before plotting to ensure gates and data are on the same scale.
*   **Margin Events:** `flowViz` automatically handles events on the instrument margins (e.g., showing them as ticks in `xyplot` or bars in `densityplot`). Avoid using complex R expressions in the formula that might break this coordinate mapping.

## Reference documentation
- [Gates/filters in Flow Cytometry Data Visualization](./references/filters.md)