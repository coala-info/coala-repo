---
name: bioconductor-levi
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/levi.html
---

# bioconductor-levi

name: bioconductor-levi
description: Landscape Expression Visualization Interface (LEVI) for projecting gene expression data onto biological networks. Use this skill to create 2D density plots (landscapes) that visualize expression changes across network topologies, supporting various network formats (Pajek, Medusa, RedeR, STRING) and both single-sample or case-control comparisons.

## Overview

The `levi` package provides a "Landscape Expression Visualization Interface" to visualize gene expression levels within the context of biological networks. It transforms discrete expression data into a continuous surface (landscape) where peaks and valleys represent up-regulated and down-regulated regions of the network. This approach helps identify functional modules or network neighborhoods that are coordinately regulated.

## Core Workflow

### 1. Data Preparation
Two inputs are required:
- **Expression Data**: A data frame or file with a gene identifier column (e.g., Gene Symbol) and one or more columns of numeric expression values.
- **Network Data**: A file defining the network structure. Supported formats include:
    - `.dat` (Medusa)
    - `.dyn` (RedeR)
    - `.net` (Pajek)
    - `.txt`/`.dat` (STRING/STITCH coordinates and interactions)

### 2. Defining Analysis Columns
Use `readExpColumn()` to specify which samples to analyze or compare.
- **Single Sample**: `readExpColumn("SampleName")`
- **Comparison (Case-Control)**: `readExpColumn("Case-Control")`
- **Multiple Comparisons**: `readExpColumn("Case1-Ctrl1", "Case2-Ctrl2")`

### 3. Generating the Landscape
The primary function is `levi()`.

```r
library(levi)

# Generate a landscape using script mode
res <- levi(
  networkCoordinatesInput = "path/to/network.dat",
  expressionInput = "path/to/expression.csv",
  fileTypeInput = "dat",        # Options: "dat", "dyn", "net", "stg"
  geneSymbolnput = "ID",        # Column name for gene IDs in expression file
  readExpColumn = readExpColumn("Tumor-Normal"),
  contrastValueInput = 50,      # Range 1-100
  resolutionValueInput = 50,    # Range 1-100
  zoomValueInput = 50,          # Range 1-100
  smoothValueInput = 50,        # Range 1-100
  setcolor = "multicolor",      # Or "pink_green", "green_blue", etc.
  contourLevi = TRUE            # Enable/disable contour lines
)
```

### 4. Interactive Visualization (GUI)
For an interactive Shiny interface to upload files and adjust parameters:

```r
# Launch in system browser
LEVIui(browser = TRUE)

# Launch in RStudio/R environment
LEVIui(browser = FALSE)
```

## Parameters and Tuning

- **Contrast**: Adjusts the intensity of the expression peaks.
- **Resolution**: Higher values increase image detail but significantly increase processing time.
- **Smoothing**: Controls the interpolation between network nodes. Higher values create a more "fluid" landscape.
- **Missing Data**: Genes in the network without corresponding expression values are assigned a neutral value (0.5), appearing flat on the landscape.
- **Color Palettes**: 
    - `multicolor`: 20 combined color levels.
    - `two colors`: Targeted palettes like `pink_green` or `orange_purple` to highlight high-expression areas.

## Reference documentation

- [levi](./references/levi.md)