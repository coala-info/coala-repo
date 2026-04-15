---
name: bioconductor-expressionview
description: ExpressionView visualizes and optimizes the arrangement of overlapping biclusters in gene expression data. Use when user asks to rearrange rows and columns to maximize bicluster contiguity, export biclustering results to EVF format, or interactively explore gene expression modules.
homepage: https://bioconductor.org/packages/3.8/bioc/html/ExpressionView.html
---

# bioconductor-expressionview

## Overview

ExpressionView is a Bioconductor package designed to visualize biclusters (modules) identified in gene expression data. Because biclusters often overlap, they are difficult to represent as contiguous rectangles in a standard heatmap. This package provides a C++ based greedy ordering algorithm to rearrange rows and columns to maximize the contiguous area of biclusters. It also provides tools to export these results into a specialized XML format (.evf) for interactive exploration.

## Core Workflow

### 1. Data Preparation and Biclustering
ExpressionView works with `ExpressionSet` objects and biclustering results from the `eisa` (ISA) or `biclust` packages.

```R
library(ExpressionView)
library(ALL)
data(ALL)

# Example using ISA (Iterative Signature Algorithm)
library(eisa)
modules <- ISA(ALL, thr.gene=2.7, thr.cond=1.4)

# Example using biclust package
library(biclust)
biclusters <- biclust(exprs(ALL), BCPlaid())
```

### 2. Optimizing Matrix Order
The `OrderEV` function is the core computational tool. It rearranges the rows and columns to make biclusters appear as contiguous as possible.

```R
# Calculate optimal order
optimalorder <- OrderEV(modules)

# Check if the algorithm reached the global optimum (1) or timed out (0)
optimalorder$status

# Increase time for complex, overlapping modules
optimalorder_long <- OrderEV(modules, maxtime=120)
```

### 3. Exporting to ExpressionView Format (.evf)
The `ExportEV` function bundles the expression data, the bicluster definitions, the optimal ordering, and automatically calculated GO/KEGG enrichment into a single XML file.

```R
# Export to file
ExportEV(modules, ALL, optimalorder, filename="my_analysis.evf")
```

### 4. Interactive Visualization
Launch the interactive viewer directly from R. Note: This requires a Flash-enabled environment or the standalone ExpressionView desktop application to open the resulting `.evf` file.

```R
LaunchEV()
```

## Advanced Usage

### Working with Non-Gene Expression Data
You can use ExpressionView for any matrix-based biclustering by providing a custom `description` list to `ExportEV`.

```R
description <- list(
  experiment = list(
    title = "Custom Analysis",
    xaxislabel = "Features",
    yaxislabel = "Observations"
  ),
  coldata = my_column_metadata, # Matrix or data.frame
  rowdata = my_row_metadata     # Matrix or data.frame
)

ExportEV(modules, data_matrix, filename="custom.evf", description=description)
```

### Key Functions
- `OrderEV()`: Finds the optimal arrangement of rows and columns.
- `ExportEV()`: Creates the .evf XML file.
- `LaunchEV()`: Starts the visualization applet.

## Reference documentation

- [ExpressionView file format](./references/ExpressionView.format.md)
- [Ordering algorithm used in ExpressionView](./references/ExpressionView.ordering.md)
- [ExpressionView Tutorial](./references/ExpressionView.tutorial.md)