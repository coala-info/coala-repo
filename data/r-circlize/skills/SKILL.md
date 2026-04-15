---
name: r-circlize
description: This tool creates complex circular visualizations and chord diagrams in R using a track-and-sector framework. Use when user asks to create chord diagrams, visualize genomic data with ideograms, or generate multi-layered circular layouts for directional relationships.
homepage: https://cloud.r-project.org/web/packages/circlize/index.html
---

# r-circlize

name: r-circlize
description: Create complex circular visualizations and chord diagrams in R. Use this skill when you need to visualize genomic data, directional relationships (Chord diagrams), or multi-dimensional data in a circular layout using the circlize package.

# r-circlize

## Overview
The `circlize` package provides a flexible framework for circular layout generation in R. It follows a "track-and-sector" approach, allowing users to build complex visualizations layer by layer using low-level graphics functions. It is particularly powerful for genomic data (via `circos.genomic.*` functions) and relationship data (via `chordDiagram`).

## Installation
```R
install.packages("circlize")
```

## Core Workflow
Circular plots are initialized, populated with tracks, and then finalized.

1.  **Initialize**: Define sectors and x-ranges using `circos.initialize()`.
2.  **Create Tracks**: Add layers using `circos.track()`.
3.  **Add Graphics**: Use low-level functions (e.g., `circos.points`, `circos.lines`, `circos.rect`) inside `panel.fun`.
4.  **Clear**: Always call `circos.clear()` to reset graphic parameters after finishing a plot.

## Key Functions

### Initialization and Layout
- `circos.initialize(factors, x)`: Initialize the layout. `factors` defines sectors.
- `circos.par()`: Set global parameters (gap degree, track height, start degree).
- `circos.clear()`: Reset all parameters.

### Track Creation
- `circos.track(factors, y, panel.fun)`: Create a new track.
- `get.cell.meta.data(name)`: Retrieve information (e.g., `xlim`, `ylim`) inside `panel.fun`.

### Low-level Graphics
- `circos.points(x, y)`: Add points to a cell.
- `circos.lines(x, y)`: Add lines.
- `circos.rect(xleft, ybottom, xright, ytop)`: Add rectangles.
- `circos.text(x, y, labels)`: Add text.
- `circos.axis(h)`: Add an axis to a track.

### Chord Diagrams
- `chordDiagram(mat)`: Create a chord diagram from an adjacency matrix or a data frame.
- `chordDiagramFromDataFrame(df)`: Create a chord diagram specifically from a data frame representing links.

### Genomic Visualizations
- `circos.initializeWithIdeogram()`: Initialize with human/animal genome ideograms.
- `circos.genomicTrack()`: Create tracks specifically for genomic data frames (chr, start, end, value).

## Usage Tips
- **Coordinate System**: `circlize` uses a data-specific coordinate system within each cell. You don't need to calculate angles manually.
- **Panel Function**: Most drawing happens inside the `panel.fun` argument of `circos.track`.
- **Direction**: The default direction is clockwise. Change `circos.par(start.degree = ...)` to rotate the entire plot.
- **Colors**: Use `colorRamp2` from the `complexheatmap` or `circlize` package to create continuous color mappings for tracks.

## Example: Basic Chord Diagram
```R
library(circlize)
set.seed(123)
mat = matrix(sample(18, 18), 3, 6) 
rownames(mat) = paste0("S", 1:3)
colnames(mat) = paste0("E", 1:6)

chordDiagram(mat)
circos.clear()
```

## Reference documentation
- [The circlize package](./references/circlize.Rmd)