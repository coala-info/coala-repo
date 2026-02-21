---
name: r-diagram
description: "Visualises simple graphs (networks) based on a transition matrix, utilities to plot flow diagrams,       visualising webs, electrical networks, etc.      Support for the book \"A practical guide to ecological modelling -      using R as a simulation platform\"      by Karline Soetaert and Peter M.J. Herman (2009), Springer.      and the book \"Solving Differential Equations in R\"      by Karline Soetaert, Jeff Cash and Francesca Mazzia (2012), Springer.      Includes demo(flowchart), demo(plotmat), demo(plotweb).</p>"
homepage: https://cloud.r-project.org/web/packages/diagram/index.html
---

# r-diagram

name: r-diagram
description: Visualizing simple graphs, networks, flowcharts, and ecological webs using the R package 'diagram'. Use this skill when you need to create transition matrix visualizations, food webs, or complex flow diagrams with custom shapes and arrows in R.

## Overview

The `diagram` package provides functions for visualising networks based on transition matrices or interaction strengths. It is particularly useful for ecological modeling (food webs), population dynamics (Leslie matrices), and technical flowcharts.

Key capabilities:
- `plotmat`: Plots networks from a transition matrix where elements are boxes and values are arrow labels.
- `plotweb`: Plots webs where arrow thickness represents flow magnitude.
- Flowcharting: Manual placement of text boxes (rectangles, ellipses, diamonds, etc.) connected by various arrow types.

## Installation

```R
install.packages("diagram")
library(diagram)
```

## Core Workflows

### 1. Plotting from a Matrix (plotmat)
The most efficient way to plot a network. The matrix `M[i, j]` represents the flow from column `j` to row `i`.

```R
# Define names and a 3x3 transition matrix
names <- c("A", "B", "C")
M <- matrix(nrow = 3, ncol = 3, byrow = TRUE, data = 0)
M[2, 1] <- 0.5 # Flow from A to B
M[3, 2] <- 0.8 # Flow from B to C
M[1, 3] <- 0.2 # Flow from C to A (feedback)
diag(M) <- 0.1 # Self-loops

# Plot the matrix
pp <- plotmat(M, pos = c(1, 2), 
              name = names, 
              lwd = 1, 
              box.lwd = 2, 
              cex.txt = 0.8, 
              box.type = "ellipse", 
              box.prop = 0.5,
              main = "Simple Transition Network")
```

**Key Parameters for `plotmat`:**
- `pos`: Vector defining the number of elements per row (e.g., `c(1, 2, 1)` for 4 elements).
- `box.type`: "rect", "ellipse", "diamond", "circle", "hexa", "multi", "none".
- `curve`: Curvature of arrows (0 for straight, >0 for curved).
- `arr.type`: "triangle", "arrow", "t-arrow", "simple".
- `self.shiftx` / `self.shifty`: Adjusts the position of self-loops.

### 2. Plotting Food Webs (plotweb)
Used when arrow thickness should reflect the magnitude of values.

```R
# Using the built-in Rigaweb dataset
data(Rigaweb)
plotweb(Rigaweb, main = "Gulf of Riga Food Web", 
        sub = "mgC/m3/d", val = TRUE, maxarrow = 3)
```

### 3. Creating Custom Flowcharts
For non-matrix diagrams, use `openplotmat` and manual coordinate placement.

```R
openplotmat()
# Define coordinates for 3 rows: 1 top, 2 middle, 1 bottom
elpos <- coordinates(c(1, 2, 1))

# Draw arrows
straightarrow(from = elpos[1,], to = elpos[2,], lty = 1, lwd = 2)
straightarrow(from = elpos[1,], to = elpos[3,], lty = 1, lwd = 2)

# Draw text boxes
textrect(elpos[1,], radx = 0.1, rady = 0.05, lab = "Start", box.col = "lightblue")
textellipse(elpos[2,], radx = 0.1, rady = 0.05, lab = "Process A")
textellipse(elpos[3,], radx = 0.1, rady = 0.05, lab = "Process B")
textdiamond(elpos[4,], radx = 0.1, rady = 0.05, lab = "End", box.col = "lightgreen")
```

## Shape and Arrow Functions

| Category | Functions |
| :--- | :--- |
| **Shapes** | `textrect`, `textellipse`, `textdiamond`, `textround`, `texthexa`, `textmulti`, `textparallel`, `textempty` |
| **Arrows** | `straightarrow`, `curvedarrow`, `bentarrow`, `segmentarrow`, `selfarrow`, `treearrow`, `splitarrow` |
| **Utility** | `openplotmat` (init plot), `coordinates` (calc positions), `shadowbox` |

## Tips and Best Practices
- **Capture Output**: Always assign `plotmat` to a variable (e.g., `pp <- plotmat(...)`). The returned list contains the coordinates of all components (`pp$comp`) and arrows (`pp$arr`), allowing you to add manual annotations or extra arrows precisely.
- **Mathematical Labels**: To use LaTeX-like symbols, pass a `data.frame` with character strings like `"f[2,1]"` or `expression` objects to the `name` or matrix values.
- **Layout**: Use the `pos` argument in `plotmat` to control the vertical/horizontal distribution. If `pos` is a single number, elements are arranged on a circle.
- **Integration**: The package works well with `shape` for advanced graphical primitives.

## Reference documentation
- [R Package diagram: visualising simple graphs, flowcharts, and webs](./references/diagram.md)