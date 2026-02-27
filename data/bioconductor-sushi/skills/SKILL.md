---
name: bioconductor-sushi
description: Bioconductor-sushi is an R package for creating publication-quality, multi-panel visualizations of genomic data. Use when user asks to plot signal tracks, visualize chromatin interactions, display genomic features, plot gene structures, or create Manhattan plots.
homepage: https://bioconductor.org/packages/3.5/bioc/html/Sushi.html
---


# bioconductor-sushi

name: bioconductor-sushi
description: A tool for visualizing genomic data in R. Use this skill to create publication-quality multi-panel genomic plots, including signal tracks (bedgraph), genomic features (bed), chromatin interactions (Hi-C, 5C, ChIA-PET), and GWAS results (Manhattan plots).

## Overview
Sushi is an R/Bioconductor package designed for flexible and highly customizable visualization of genomic data. It supports common formats such as BED, BEDPE, and Bedgraph, as well as interaction matrices (e.g., Hi-C). Its primary strength lies in its ability to combine multiple genomic tracks into complex, publication-ready figures using standard R layout tools.

## Loading the Package and Data
To use Sushi, load the library and the provided example datasets:
```R
library(Sushi)
# Load all example datasets
Sushi_data = data(package = 'Sushi')
data(list = Sushi_data$results[,3])
```

## Core Plotting Functions

### Signal Tracks (Bedgraph)
Use `plotBedgraph()` to plot continuous data like ChIP-seq or RNA-seq coverage.
```R
chrom = "chr11"
chromstart = 1650000
chromend = 2350000
plotBedgraph(Sushi_DNaseI.bedgraph, chrom, chromstart, chromend, colorbycol=SushiColors(5))
labelgenome(chrom, chromstart, chromend, n=4, scale="Mb")
```
*   **Overlays**: Set `overlay=TRUE` to plot multiple tracks on the same axes. Use `rescaleoverlay=TRUE` to match scales.
*   **Flipping**: Set `flip=TRUE` to plot data below the x-axis (useful for comparing strands).

### Chromatin Interactions (Hi-C and BEDPE)
*   **Hi-C**: Use `plotHic()` with an interaction matrix.
    ```R
    phic = plotHic(Sushi_HiC.matrix, chrom, chromstart, chromend, max_y=20, zrange=c(0,28), palette=SushiColors(7))
    addlegend(phic[[1]], palette=phic[[2]], title="score", side="right")
    ```
*   **Loops/Arches**: Use `plotBedpe()` for BEDPE data (e.g., 5C, ChIA-PET).
    ```R
    plotBedpe(Sushi_5C.bedpe, chrom, chromstart, chromend, heights=Sushi_5C.bedpe$score, plottype="loops")
    ```

### Genomic Features (BED)
Use `plotBed()` to visualize discrete features like ChIP-seq peaks or SNPs.
*   **Pile-up**: Set `row="auto"` for a standard pile-up.
*   **Density**: Set `type="density"` to create a heatmap of feature density.
*   **Specific Rows**: Set `row="given"` and provide `rownumber` to arrange features manually.

### Gene and Transcript Structures
Use `plotGenes()` to plot gene models from BED data.
```R
plotGenes(Sushi_genes.bed, chrom, chromstart, chromend, plotgenetype="arrow", labeltext=TRUE)
```
*   **Exon/UTR**: Provide a `types` column to distinguish between exons and UTRs (UTRs are drawn thinner).

### Manhattan Plots
Use `plotManhattan()` for GWAS results. It requires a genome object defining chromosome sizes.
```R
plotManhattan(bedfile=Sushi_GWAS.bed, pvalues=Sushi_GWAS.bed[,5], genome=Sushi_hg18_genome)
```

## Annotation and Customization

### Genomic Coordinates
`labelgenome()` adds the x-axis. Parameters include `n` (number of ticks), `scale` ("Mb", "Kb", or "bp"), and `side` (1 for bottom, 3 for top).

### Colors
*   `SushiColors(n)`: Returns a function providing color palettes (n = 2 to 7).
*   `opaque(color, transparency)`: Adjusts the transparency of a color (0 to 1).
*   `maptocolors(values, palette)`: Maps a numeric vector to a color scale.

## Advanced Workflows: Multi-panel and Zooming
Sushi integrates with `layout()` or `par(mfrow=...)` to create multi-track figures.

### Creating Zooms
1.  Define the main plot.
2.  Use `zoomsregion(region)` to draw the "zoom" lines connecting the main plot to the inset.
3.  Create the zoomed-in plot in the next layout panel.
4.  Call `zoombox()` to draw a border around the zoomed plot.

```R
layout(matrix(c(1,1,2,3), 2, 2, byrow = TRUE))
# Panel 1: Main plot
plotBedgraph(data, chrom, start, end)
zoomsregion(c(zoomstart, zoomend))
# Panel 2: Zoomed plot
plotBedgraph(data, chrom, zoomstart, zoomend)
zoombox()
```

## Tips
*   **Data Prep**: Sushi expects data frames. Ensure your BED/BEDPE/Bedgraph files are read into R using `read.table()`.
*   **External Formats**: Convert BAM or GFF files to BED using `bedtools` before importing into R.
*   **Standard R Functions**: Use `axis()`, `mtext()`, and `legend()` to add standard R annotations to Sushi plots.

## Reference documentation
- [Sushi](./references/Sushi.md)