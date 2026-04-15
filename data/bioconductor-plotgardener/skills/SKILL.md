---
name: bioconductor-plotgardener
description: plotgardener is a coordinate-based genomic visualization package for R that enables absolute positioning of genomic tracks for complex, publication-quality figures. Use when user asks to create multi-panel genomic visualizations, plot Hi-C contact matrices, visualize signal tracks, or generate annotated gene models and Manhattan plots.
homepage: https://bioconductor.org/packages/release/bioc/html/plotgardener.html
---

# bioconductor-plotgardener

## Overview

`plotgardener` is a coordinate-based genomic visualization package for R built on `grid` graphics. Unlike standard plotting packages that use relative positioning, `plotgardener` allows for absolute positioning of genomic tracks on a defined page, making it ideal for complex, publication-quality multi-panel figures. It supports various data types including Hi-C, ChIP-seq/ATAC-seq signal, gene annotations, and GWAS results.

## Core Workflow

The typical `plotgardener` workflow follows these steps:

1.  **Initialize the Page**: Define the physical dimensions of your figure.
    ```R
    library(plotgardener)
    pageCreate(width = 6, height = 4, default.units = "inches", showGuides = TRUE)
    ```

2.  **Plot Genomic Data**: Call specific plotting functions using genomic coordinates (`chrom`, `chromstart`, `chromend`) and placement arguments (`x`, `y`, `width`, `height`).
    ```R
    # Example: Plotting a signal track
    signal_plot <- plotSignal(data = "path/to/file.bw", 
                              chrom = "chr1", chromstart = 1000000, chromend = 2000000,
                              x = 0.5, y = 0.5, width = 5, height = 1,
                              fill = "darkblue", linecolor = "darkblue")
    ```

3.  **Add Annotations**: Use the object returned by a plotting function to anchor annotations like axes or legends.
    ```R
    annoGenomeLabel(plot = signal_plot, x = 0.5, y = 1.5, scale = "Mb")
    annoHeatmapLegend(plot = hic_plot, x = 5.6, y = 0.5, width = 0.1, height = 1)
    ```

4.  **Finalize and Export**: Hide guides and close the device.
    ```R
    pageGuideHide()
    # If using pdf(): dev.off()
    ```

## Key Function Categories

### Plotting Functions
- `plotHicSquare()` / `plotHicTriangle()`: Visualize Hi-C contact matrices.
- `plotSignal()`: Visualize genomic signal tracks (e.g., BigWig, BedGraph).
- `plotGenes()`: Visualize gene models (requires `TxDb` or `EnsDb` objects).
- `plotManhattan()`: Create Manhattan plots for GWAS data.
- `plotPairs()`: Visualize chromatin interactions (e.g., BEDPE).
- `plotGG()`: Integrate standard `ggplot2` objects into the `plotgardener` layout.

### Annotation Functions
- `annoGenomeLabel()`: Adds genomic coordinate axis.
- `annoHeatmapLegend()`: Adds color scales for heatmaps.
- `annoText()` / `annoRect()` / `annoSegments()`: Add custom labels and shapes.

## Important Usage Tips

- **Coordinate System**: The origin (0,0) is at the top-left of the page. `x` and `y` arguments specify the top-left corner of the plot unless the `just` argument is modified.
- **Assemblies**: Always specify the `assembly` (e.g., "hg19", "mm10") to ensure correct genomic context.
- **Data Input**: Functions accept file paths (BigWig, HiC), DataFrames, or GRanges objects.
- **Quick Inspection**: If you omit `x`, `y`, `width`, and `height`, the plot will fill the entire device. This is useful for quick checks but should not be used for multi-panel layouts.
- **PDF Artifacts**: When exporting to PDF, set `showGuides = FALSE` inside `pageCreate()` rather than calling `pageGuideHide()` to avoid creating an extra blank page in the output file.

## Reference documentation

- [Introduction to plotgardener](./references/introduction_to_plotgardener.md)