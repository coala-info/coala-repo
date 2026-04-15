---
name: bioconductor-chromheatmap
description: The ChromHeatMap package visualizes genomic expression data as heatmaps plotted along specific chromosomal coordinates and cytogenetic bands. Use when user asks to plot expression data by chromosome, visualize genomic data with ideograms, or interactively identify genes from chromosomal heatmaps.
homepage: https://bioconductor.org/packages/release/bioc/html/ChromHeatMap.html
---

# bioconductor-chromheatmap

## Overview

The `ChromHeatMap` package facilitates the visualization of expression data (from `ExpressionSet` objects or data matrices) along specific chromosomes. It integrates genomic location information from `AnnotationDbi` packages to plot data points at their precise chromosomal positions. Key features include support for strand-specific heatmaps, integration of cytogenetic banding (ideograms) for human, mouse, and rat, and interactive identification of features from the resulting plots.

## Data Preparation

Before plotting, data must be mapped to chromosome coordinates using `makeChrStrandData`.

```r
library(ChromHeatMap)
# data: Expression matrix or ExpressionSet
# lib: The annotation package for your platform (e.g., 'hgu95av2')
chrdata <- makeChrStrandData(data, lib='hgu95av2')
```

The resulting `chrdata` object contains expression values indexed by genomic start and end coordinates, ensuring accurate representation of target widths on the plot.

## Generating Chromosome Heatmaps

The primary plotting function is `plotChrMap`.

### Basic Whole-Chromosome Plot
```r
# Plot chromosome 19, combining both strands
plotChrMap(chrdata, 19, strands='both')
```

### Subsetting and Customization
You can focus on specific regions using cytobands or base-pair intervals.

```r
# Plot a specific cytoband on chromosome 1
plotmap <- plotChrMap(chrdata, 1, cytoband='q23', interval=50000)

# Adding sample-group colors (RowSideColors)
group_colors <- ifelse(condition, 'red', 'blue')
plotChrMap(chrdata, 1, RowSideColors=group_colors)
```

### Key Parameters for `plotChrMap`:
- `chr`: Chromosome number or name.
- `strands`: 'both' (default), 'forward', or 'reverse'.
- `cytoband`: String specifying a cytogenetic band (e.g., 'q21').
- `start` / `end`: Integer base-pair coordinates for precise windowing.
- `RowSideColors`: Vector of colors for sample annotation.
- `cexCyto` / `srtCyto`: Control size and rotation of cytoband labels.

## Interactive Feature Identification

After generating a plot, you can identify the specific probes or genes in a region of interest by clicking on the heatmap.

```r
# 1. Generate the plot and save the output object
plotmap <- plotChrMap(chrdata, 1)

# 2. Call grabChrMapProbes and click twice on the plot (start and end of region)
probes <- grabChrMapProbes(plotmap)

# 3. Map probe IDs back to Gene Symbols
library(hgu95av2.db)
genes <- unlist(mget(probes, envir=hgu95av2SYMBOL, ifnotfound=NA))
```

*Note: If multiple genes occupy the same coordinate space at the current resolution, identifiers are returned concatenated with semicolons. Zoom in using `cytoband` or `interval` to resolve these.*

## Tips and Best Practices
- **Annotation Packages**: Ensure the correct `.db` package (e.g., `org.Hs.eg.db`, `hgu95av2.db`) is installed and loaded.
- **Color Schemes**: The default `heat.colors` may be suboptimal. Use `RColorBrewer` or `viridis` for better contrast.
- **Graphics Device**: Do not reset `par` or `layout` settings between plotting and using `grabChrMapProbes`, as the interactive function relies on the current coordinate system of the device.

## Reference documentation
- [ChromHeatMap](./references/ChromHeatMap.md)