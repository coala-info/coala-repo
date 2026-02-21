---
name: bioconductor-geneplotter
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/geneplotter.html
---

# bioconductor-geneplotter

name: bioconductor-geneplotter
description: Visualization of genomic data and microarray expression levels in relation to chromosomal location. Use this skill when you need to create whole-genome plots (cPlot), color-code genes by expression (cColor), or visualize expression trends along specific chromosomes using Bioconductor data packages.

## Overview

The `geneplotter` package provides functions for plotting genomic data, specifically focusing on the relationship between gene expression and physical chromosomal location. It is widely used for identifying spatial patterns in expression, such as amplicons or deletions, and for visualizing differential expression across the entire genome.

## Core Workflows

### 1. Assembling Chromosome Location Data
Before plotting, you must create a `chromLocation` object which maps genes to their physical coordinates using a Bioconductor annotation package (e.g., `hu6800.db`, `hgu95av2.db`).

```r
library(geneplotter)
library(annotate)
# Example using hgu95av2 annotation
chrObj <- buildChromLocation("hgu95av2")
```

### 2. Whole Genome Visualization (cPlot and cColor)
Whole genome plots represent chromosomes as horizontal lines and genes as short vertical ticks.

*   **cPlot**: Initializes the genomic plot.
*   **cColor**: Overlays colors on specific genes based on experimental data (e.g., expression deciles or t-test results).

```r
# Setup layout for two side-by-side plots and a legend
layout(matrix(1:3, nr=1), widths=c(5, 5, 2))

# Plot Group 1
cPlot(chrObj)
cColor(featureNames(eset), group1_colors, chrObj)

# Plot Group 2
cPlot(chrObj)
cColor(featureNames(eset), group2_colors, chrObj)
```

### 3. Single Chromosome Plots
To detect localized genomic events like amplifications or deletions, you can plot cumulative expression levels along a single chromosome.

```r
# Example logic for single chromosome exploration
# These plots help identify regions where expression deviates from the baseline
# often used with smoothing or cumulative sums.
```

## Key Functions

- `buildChromLocation(pkg)`: Creates the required data structure from an annotation package.
- `cPlot(chromLocation, ...)`: Draws the chromosomal axes and gene positions.
- `cColor(featureNames, colors, chromLocation)`: Highlights specific features on an existing `cPlot`.
- `dChip.colors(n)`: Provides a standard color palette (blue-to-red) often used in microarray visualization.

## Tips for Success

- **Data Packages**: Ensure the appropriate `.db` annotation package is installed and loaded.
- **Pseudoautosomal Regions**: Some genes map to multiple chromosomes (e.g., X and Y). `geneplotter` workflows typically involve selecting the first mapping or a primary chromosome to avoid ambiguity.
- **Coordinate Systems**: Locations are measured in base pairs from the p-arm (5') to the q-arm (3').
- **Graphics Device**: `cPlot` uses standard R graphics. For complex layouts, use `layout()` or `par(mfrow=...)` before calling the plotting functions.

## Reference documentation

- [How to Assemble a chromLocation Object](./references/byChroms.md)
- [Visualization of Microarray Data](./references/visualize.md)