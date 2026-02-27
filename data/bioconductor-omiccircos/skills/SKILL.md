---
name: bioconductor-omiccircos
description: OmicCircos creates high-quality circular plots for the visualization of multi-dimensional genomic data. Use when user asks to generate circos-style plots, visualize genomic variations across chromosomes, or display relationships between features using links and polygons.
homepage: https://bioconductor.org/packages/release/bioc/html/OmicCircos.html
---


# bioconductor-omiccircos

name: bioconductor-omiccircos
description: Create high-quality circular plots for omics data visualization (mutation, copy number, expression, methylation). Use when needing to generate circos-style plots in R to visualize genomic variations, relationships between features (links/polygons), and multi-sample data (heatmaps, boxplots, histograms) mapped to chromosome positions.

## Overview

OmicCircos is a Bioconductor package designed for circular visualization of genomic data. It operates on a track-based system where each track is drawn independently, allowing for complex, layered visualizations. It supports various plot types including scatterplots, lines, heatmaps, boxplots, and link curves/polygons to represent structural variations or interactions.

## Core Workflow

1.  **Prepare Segment Data**: Define the anchor track (e.g., chromosomes).
2.  **Convert Coordinates**: Use `segAnglePo` to transform genomic positions (bp) into angular coordinates.
3.  **Initialize Plot**: Create an empty square plot area.
4.  **Add Tracks**: Use the `circos` function repeatedly to layer data from the outside in.

## Input Data Formats

*   **Segment Data**: (Required) Columns: `chrom`, `start`, `end`. Used for the outermost anchor track.
*   **Mapping Data**: Columns: `chr`, `po` (position), followed by values/names.
*   **Link Data**: Columns: `chr1`, `po1`, `label1`, `chr2`, `po2`, `label2`. Used for curves between points.
*   **Link Polygon Data**: Columns: `chr1`, `start1`, `end1`, `chr2`, `start2`, `end2`. Used for connecting segments.

## Key Functions

### segAnglePo
Converts linear genomic coordinates to angular coordinates.
```r
# seg.f: segment data frame; seg: vector of segment names to include
db <- segAnglePo(seg.f, seg = seg.name)
```

### circos
The primary plotting function. Key parameters:
*   `R`: Radius of the track.
*   `cir`: The coordinate object created by `segAnglePo`.
*   `W`: Width of the track.
*   `type`: Plot type ("chr", "l" (line), "s" (scatter), "h" (histogram), "boxplot", "heatmap", "link", "link.pg", "label").
*   `mapping`: The data frame containing values to plot.
*   `col.v`: Column index in mapping data containing the values.
*   `B`: Boolean, whether to draw a background/border for the track.

## Common Plotting Patterns

### Initializing the Canvas
Always use a square plot area to ensure circles are not distorted.
```r
par(mar=c(2, 2, 2, 2))
plot(c(1, 800), c(1, 800), type="n", axes=FALSE, xlab="", ylab="")
```

### Drawing the Chromosome Anchor
```r
circos(R=400, cir=db, type="chr", col=colors, print.chr.lab=TRUE, W=4)
```

### Adding Data Tracks (Lines and Heatmaps)
```r
# Line plot
circos(R=360, cir=db, W=40, mapping=seg.v, type="l", col.v=3, col=colors[1])

# Heatmap
circos(R=240, cir=db, W=40, mapping=seg.v, type="heatmap", col.v=8)
```

### Adding Links (Structural Variations)
```r
circos(R=150, cir=db, mapping=link.v, type="link", lwd=2, col=colors[c(1,7)])
```

## Tips for Success
*   **Layering**: Start with the largest `R` (outermost) and decrease `R` for inner tracks.
*   **Colors**: Use `rainbow(n, alpha=0.5)` for transparent overlaps.
*   **Scaling**: Set `scale=TRUE` in `circos()` to normalize data within the track width.
*   **Labels**: Use `type="label"` with `side="out"` or `side="in"` to add gene symbols or identifiers.

## Reference documentation
- [The OmicCircos usages by examples](./references/OmicCircos_vignette.md)