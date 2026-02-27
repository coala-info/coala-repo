---
name: bioconductor-mimager
description: The mimager package visualizes microarray probe-level data to identify spatial artifacts and physical defects on chip surfaces. Use when user asks to create chip-surface images, visualize probe intensities, or inspect microarray data for spatial biases and regional artifacts.
homepage: https://bioconductor.org/packages/release/bioc/html/mimager.html
---


# bioconductor-mimager

name: bioconductor-mimager
description: Visualizing microarray probe-level data and identifying spatial artifacts using the mimager package. Use this skill when you need to create chip-surface images from AffyBatch, PLMset, or oligo-class objects (ExpressionFeatureSet, etc.) to inspect for physical defects, bubbles, or regional biases on microarrays.

# bioconductor-mimager

## Overview

The `mimager` package provides a unified interface for genomic microarray data visualization. Its primary function, `mimage()`, generates high-level representations of probe intensities arranged by their physical location on the chip. This is essential for Quality Control (QC) to detect spatial artifacts (e.g., "rings," "smudges," or "halos") that standard summary statistics might miss. It supports objects from `affy`, `affyPLM`, `oligo`, and `oligoClasses`.

## Core Workflows

### Basic Visualization
To visualize a single array or a subset from a microarray object:

```r
library(mimager)
# For AffyBatch objects (e.g., from affydata)
mimage(Dilution, select = 1)

# To change the legend label
mimage(Dilution, select = 1, legend.label = "Log2 Intensity")
```

### Visualizing Multiple Arrays
`mimage()` automatically handles multi-sample objects by creating a grid.

```r
# Visualize all samples in a grid
mimage(Dilution)

# Specify grid layout and specific samples
mimage(Dilution, select = c("10A", "20A"), nrow = 1)
```

### Probe-Level Linear Models (PLM)
Visualizing residuals or weights from PLMs is often more effective at revealing artifacts than raw intensities.

```r
library(affyPLM)
# Fit the model
dataset_plm <- fitPLM(Dilution)

# Visualize residuals/weights
# Note: 'type' refers to model value type (residuals/weights) for PLM objects
mimage(dataset_plm, type = "residuals")
```

### Data Transformations
`mimager` includes specialized transformations to highlight spatial bias:

1.  **`arank()`**: Computes the rank of values within each matrix.
2.  **`arle()`**: Computes Relative Log Expression (RLE) compared to a median reference chip.

```r
# Using RLE with a divergent color palette
div_colors <- scales::brewer_pal(palette = "RdBu")(9)
mimage(Dilution, transform = arle, colors = div_colors)

# Using ranks
mimage(Dilution, transform = arank)
```

## Advanced Options

### Handling Probe Types
For Affymetrix platforms with Mismatch (MM) probes:
- `probes = "pm"`: (Default) Only Perfect Match probes.
- `probes = "mm"`: Only Mismatch probes.
- `probes = "all"`: Both types.

### Empty Row Filling
To prevent rasterization artifacts caused by missing probe types, `mimager` fills empty rows by default.
- `empty.rows = "fill"`: (Default) Fills empty rows using neighbors.
- `empty.rows = "ignore"`: Disables filling.
- `empty.thresh`: Numeric (0-1). Threshold of missingness to consider a row "empty" (default is 0.6).

### Manual Array Conversion
If you need to manipulate the underlying data matrix before plotting:
```r
# Convert Bioconductor object to a 3D array (m x n x k)
chip_array <- marray(Dilution)
```

## Reference documentation

- [mimager overview](./references/introduction.md)
- [mimager overview (Rmd source)](./references/introduction.Rmd)