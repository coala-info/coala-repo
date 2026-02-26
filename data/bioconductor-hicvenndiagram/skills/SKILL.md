---
name: bioconductor-hicvenndiagram
description: This tool calculates and visualizes overlaps between genomic interactions or peaks while correcting for multiple-overlap biases. Use when user asks to calculate Hi-C loop overlaps, generate Venn diagrams or UpSet plots for genomic interactions, or perform enrichment analysis using GLEAM.
homepage: https://bioconductor.org/packages/release/bioc/html/hicVennDiagram.html
---


# bioconductor-hicvenndiagram

name: bioconductor-hicvenndiagram
description: Specialized tool for calculating and visualizing overlaps between genomic interactions (Hi-C loops) and peaks. Use this skill when the user needs to identify common or unique interactions across multiple samples using Venn diagrams or UpSet plots, specifically to avoid the "counts method" bias where a single overlap might represent multiple interactions.

# bioconductor-hicvenndiagram

## Overview

The `hicVennDiagram` package addresses a common issue in genomic interaction analysis: traditional Venn diagrams often misrepresent the number of overlapping loops because one interaction in sample A might overlap with multiple interactions in sample B. This package provides methods to calculate these overlaps accurately and visualize them using Venn diagrams, UpSet plots, or an interactive browser-based interface. It also includes the GLEAM (Genomic Loops Enrichment Analysis Method) for enrichment testing.

## Core Workflow

### 1. Data Preparation
The package primarily works with `BEDPE` files or `GRanges`/`InteractionSet` objects.

```r
library(hicVennDiagram)

# List BEDPE files
files <- c("sample1.bedpe", "sample2.bedpe", "sample3.bedpe")
names(files) <- c("Group1", "Group2", "Group3")
```

### 2. Calculating Overlaps
The `vennCount` function is the engine for calculating overlaps between interaction sets.

```r
# Calculate overlaps with default parameters
venn_data <- vennCount(files)

# Adjusting sensitivity with maxgap (distance between anchors)
# FUN = max/min determines how to handle multiple overlaps
venn_data_custom <- vennCount(files, maxgap = 50000, FUN = max)
```

### 3. Visualization

#### Venn Diagrams
Best for 2-3 samples.
```r
# Static plot
v_plot <- vennPlot(venn_data)

# Interactive adjustment (opens in browser to move labels/colors)
browseVenn(v_plot)
```

#### UpSet Plots
Best for 4+ samples or complex intersections.
```r
# Basic UpSet plot
upsetPlot(venn_data)

# Customizing labels and appearance
upsetPlot(venn_data, label_all = list(color = 'black', size = 5))
```

### 4. Enrichment Analysis (GLEAM)
Perform enrichment analysis for interactions similar to how GREAT works for peaks.

```r
# Create a background model from your files
background <- createGIbackground(files)

# Run the enrichment test
results <- gleamTest(files, background = background, method = 'binom')
```

## Integration with ChIPpeakAnno
If working with genomic peaks instead of loops, you can convert `ChIPpeakAnno` results for use in `hicVennDiagram` visualizations:

```r
# Assuming 'ol' is an object from ChIPpeakAnno::findOverlapsOfPeaks
# Use the internal conversion logic to create a vennTable
# Then plot:
vennPlot(vennTable_object)
```

## Tips for Success
- **Naming**: Always name your input file list; these names become the labels in the plots.
- **Themes**: UpSet plots use `ggplot2` themes. If the plot looks cluttered, pass a list of theme modifications to the `themes` argument in `upsetPlot`.
- **InteractionSet**: For advanced users, the package integrates with the `InteractionSet` Bioconductor class, allowing for sophisticated filtering before overlap calculation.

## Reference documentation
- [hicVennDiagram](./references/hicVennDiagram.md)