---
name: bioconductor-interaccircos
description: This tool creates interactive circular genomic visualizations in R by interfacing with JavaScript-based Circos libraries. Use when user asks to generate interactive Circos plots, visualize genomic data tracks like SNPs or histograms, or layer multiple circular data modules.
homepage: https://bioconductor.org/packages/release/bioc/html/interacCircos.html
---


# bioconductor-interaccircos

name: bioconductor-interaccircos
description: Create interactive Circos plots in R using the interacCircos package. Use this skill when a user needs to visualize genomic data (SNPs, histograms, links, backgrounds) in a circular, interactive JavaScript-based format.

## Overview

The `interacCircos` package provides an R interface to JavaScript-based Circos libraries, allowing for the creation of interactive circular plots without requiring local JS library compilation. It supports 14 track types and 7 auxiliary functions. The core workflow involves defining a genome (chromosomes/segments) and layering modules (tracks) using the `+` operator within the `Circos()` function.

## Core Workflow

1.  **Initialize Genome**: Define the segments and their lengths.
2.  **Prepare Data**: Format data as data frames (typically with columns for chromosome, start, end, and value).
3.  **Define Modules**: Use specific `Circos*` functions (e.g., `CircosHistogram`, `CircosSnp`) to define tracks.
4.  **Render**: Call `Circos()` with the `moduleList` and genome parameters.

## Key Functions

### The Main Container
- `Circos(moduleList, genome, outerRadius, width, height, zoom)`: The primary function to render the plot. `moduleList` accepts one or multiple modules combined with `+`.

### Track Modules
- `CircosHistogram(id, data, fillColor, maxRadius, minRadius)`: Creates a histogram track.
- `CircosSnp(id, data, minRadius, maxRadius, SNPFillColor, circleSize)`: Creates a dot/SNP track.
- `CircosBackground(id, minRadius, maxRadius, color)`: Adds a background layer to highlight specific radial ranges.
- `CircosLine`, `CircosScatter`, `CircosHeatmap`, `CircosLink`: Other available track types for various data visualizations.

## Usage Examples

### Basic Genome Track
```r
library(interacCircos)
# Simple plot with default genome
Circos(width = 700, height = 550)

# Custom genome segments
Circos(genome = list("Chr1" = 100, "Chr2" = 200), 
       genomeFillColor = c("red", "blue"),
       zoom = TRUE)
```

### Multi-Module Plot
To layer multiple tracks, use the `+` operator:
```r
library(interacCircos)

# Example with Histogram and Background
hist_mod <- CircosHistogram('H1', data = histogramExample, 
                            fillColor = "orange", 
                            maxRadius = 200, minRadius = 150)

bg_mod <- CircosBackground('B1', minRadius = 150, maxRadius = 200)

Circos(moduleList = hist_mod + bg_mod, 
       genome = list("2L"=23011544, "2R"=21146708),
       outerRadius = 210)
```

## Tips and Best Practices
- **Data Format**: Most modules expect a data frame where the first column is the chromosome name matching the `genome` list keys.
- **Radius Management**: Ensure `minRadius` and `maxRadius` of different modules do not overlap unless intentional (e.g., putting a track on top of a background).
- **Interactivity**: Set `zoom = TRUE` in the `Circos()` function to enable mouse-wheel zooming in the resulting HTML widget.
- **Colors**: `genomeFillColor` can take a vector of colors or a RColorBrewer palette name (e.g., "Blues").

## Reference documentation
- [interacCircos](./references/interacCircos.md)