---
name: bioconductor-rgraph2js
description: This tool generates interactive HTML and JavaScript network visualizations from R graph objects or adjacency matrices. Use when user asks to create web-based graph diagrams, embed barplots or starplots within network nodes, or generate time-series animations of network data.
homepage: https://bioconductor.org/packages/release/bioc/html/RGraph2js.html
---

# bioconductor-rgraph2js

name: bioconductor-rgraph2js
description: Create interactive HTML/JavaScript graph visualizations from R. Use this skill when you need to generate web-based, interactive network diagrams from adjacency matrices or graph objects (graphNEL, graphAM). It supports embedding barplots/starplots inside nodes, time-series animations, and custom tooltips.

## Overview
`RGraph2js` is a Bioconductor package that transforms R graph objects into interactive HTML pages using D3.js and Raphael. It is particularly useful for biological networks where nodes need to display associated data (like gene expression) directly within the visualization via sub-plots.

## Core Workflow

1.  **Prepare Input**: Use a signed/weighted adjacency matrix or a `graph` package object (e.g., `graphNEL`).
2.  **Define Properties**: (Optional) Create data frames for node and edge attributes (colors, shapes, tooltips).
3.  **Generate Visualization**: Call `graph2js()` to produce the HTML/JS bundle.
4.  **View**: Open the resulting `index.html` in a web browser.

## Key Functions

### graph2js()
The primary function to generate the visualization.
```r
graph2js(A, outputDir, nodesProp, edgesProp, opts, ...)
```
- `A`: Adjacency matrix or graph object.
- `outputDir`: Path where HTML/JS files will be saved.
- `nodesProp`: Data frame with row names matching node names. Columns: `color`, `shape` ("circle", "rect", "lozenge", "triangle"), `link`, `tooltip`, `x`, `y`, `fixed`.
- `edgesProp`: Data frame with columns `from`, `to`, `width`, `color`, `tooltip`.

### Helper Functions
- `getDefaultOptions()`: Returns a list of global settings (e.g., `displayNodeLabels`, `layout_forceCharge`).
- `getNodesDataFrame()`: Generates a template data frame for node properties.
- `getEdgesDataFrame()`: Generates a template data frame for edge properties.

## Specialized Visualizations

### In-Node Plots
You can embed plots directly inside nodes to represent multi-dimensional data.
- **Barplots**: Pass `innerValues` (matrix of values) and `innerColors` (matrix of colors) to `graph2js()`.
- **Starplots**: Pass `starplotValues`, `starplotColors`, and `starplotLabels`.

### Time-Step Animations
To show dynamic changes in a network:
1. Add columns to `nodesProp` with prefixes `leading.nodes.N` (binary 1/0 for highlighting) and `highlight.N` (color) where N is the step index.
2. The output HTML will include a slider to navigate steps.

### Fixed Layouts
To prevent the force-directed layout from moving nodes, specify `x`, `y` coordinates and set `fixed=TRUE` in the `nodesProp` data frame.

## Tips and Constraints
- **Adjacency Matrix Values**: 0 = no connection; 1 = arrow ($\to$); -1 = dot ($\bullet$). Bidirectional connections of the same type become undirected lines (—).
- **Dependencies**: The generated HTML requires an internet connection to load D3.js and JQuery from CDNs by default.
- **Large Graphs**: For performance, set `opts$displayNetworkEveryNLayoutIterations` to a high number (e.g., 100) or 0 to only show the final result.
- **HTML Tooltips**: The `tooltip` column in `nodesProp` supports full HTML strings, including tables and CSS styles.

## Reference documentation
- [RGraph2js: Usage from an R session](./references/RGraph2js.md)