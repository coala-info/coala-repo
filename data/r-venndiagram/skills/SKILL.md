---
name: r-venndiagram
description: R package venndiagram (documentation from project home).
homepage: https://cran.r-project.org/web/packages/venndiagram/index.html
---

# r-venndiagram

## Overview
The `VennDiagram` package is a specialized R tool for generating high-resolution Venn and Euler plots. It supports up to five sets for Venn diagrams and up to three sets for Euler diagrams. It is particularly useful for its extensive customization options, including scaling, shape-fill, and label placement.

## Installation
To install the package from CRAN:
```R
install.packages("VennDiagram")
```

## Core Workflow

### 1. Basic Venn Diagram
The primary function is `venn.diagram()`. By default, it writes a file to disk. To plot directly in R, set `filename = NULL`.

```R
library(VennDiagram)

# Create a list of sets
my_sets <- list(Set1 = 1:100, Set2 = 80:150)

# Generate the plot object
v_plot <- venn.diagram(
  x = my_sets,
  filename = NULL,
  fill = c("cornflowerblue", "darkorchid1"),
  alpha = 0.50,
  label.col = "white",
  cex = 1.5,
  fontfamily = "serif",
  fontface = "bold",
  cat.col = c("cornflowerblue", "darkorchid1"),
  cat.cex = 1.5,
  cat.fontfamily = "serif"
)

# Render the plot
grid::grid.draw(v_plot)
```

### 2. Handling Different Set Counts
The package provides specific functions for different numbers of sets, though `venn.diagram()` automatically selects the appropriate one:
- `draw.pairwise.venn()`: 2 sets.
- `draw.triple.venn()`: 3 sets.
- `draw.quad.venn()`: 4 sets.
- `draw.quintuple.venn()`: 5 sets.

### 3. Euler Diagrams (Area-Proportional)
For 2 or 3 sets, you can create Euler diagrams where the circle areas are proportional to the set sizes by setting `euler.d = TRUE` and `scaled = TRUE`.

```R
v_euler <- venn.diagram(
  x = list(A = 1:100, B = 1:50),
  filename = NULL,
  euler.d = TRUE,
  scaled = TRUE
)
grid::grid.draw(v_euler)
```

## Key Customization Parameters
- `fill`: Vector of colors for the circles.
- `alpha`: Transparency level (0 to 1).
- `lty`: Line type for circle borders (e.g., "blank", "solid").
- `cat.pos`: Position of category names (in degrees, 0 is 12 o'clock).
- `cat.dist`: Distance of category names from the edge of the circles.
- `inverted`: Boolean to flip the diagram (useful for specific 2-set layouts).

## Tips and Troubleshooting
- **Logging**: The package uses `futile.logger`. If you see unwanted console output, you can suppress it using `futile.logger::flog.threshold(futile.logger::ERROR, name = "VennDiagramLogger")`.
- **Grid Graphics**: Since the output is a `gList` object, you must use `grid::grid.draw()` to display it if `filename` is `NULL`.
- **File Output**: If `filename` is provided (e.g., "plot.tiff"), the package saves a high-resolution TIFF file by default.

## Reference documentation
- [README](./references/README.html.md)
- [VennDiagram Home Page](./references/home_page.md)