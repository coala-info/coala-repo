---
name: bioconductor-recoup
description: The recoup package visualizes Next Generation Sequencing signal profiles by generating average profile curves and heatmaps from BAM, BED, or BigWig files. Use when user asks to visualize NGS coverage profiles, create signal heatmaps, compare genomic signal across different sample groups, or plot gene body coverage for ChIP-Seq and RNA-Seq data.
homepage: https://bioconductor.org/packages/release/bioc/html/recoup.html
---


# bioconductor-recoup

## Overview

The `recoup` package is a Bioconductor tool designed for the complex visualization of Next Generation Sequencing (NGS) signal profiles. It bridges the gap between raw alignment data (BAM/BED/BigWig) and publication-ready graphics by leveraging `ggplot2` for average profile curves and `ComplexHeatmap` for signal heatmaps. It is particularly powerful for "factored" visualizations, where genomic regions are categorized by external metadata (e.g., high vs. low expression) to see how signal profiles differ across groups.

## Core Workflow

### 1. Data Preparation
To use `recoup`, you typically need three components:
*   **Input Files**: A list of BAM, BED, or BigWig files.
*   **Genomic Regions**: Reference areas (e.g., "hg19", "mm10", or a custom BED file).
*   **Design Metadata** (Optional): A data frame or file mapping sample IDs to categories for faceting.

### 2. Basic Usage
The primary function is `recoup()`. It handles data loading, coverage calculation, and plotting in one call.

```r
library(recoup)

# Define input samples
test.input <- list(
    sample1 = list(id = "WT", file = "path/to/wt.bam", format = "bam"),
    sample2 = list(id = "KO", file = "path/to/ko.bam", format = "bam")
)

# Run recoup for TSS profiles
result <- recoup(
    input = test.input,
    genome = "mm9",
    region = "tss",
    type = "chipseq",
    binParams = list(flank = c(2000, 2000), binSize = 50)
)
```

### 3. Visualizing Results
`recoup` returns a list containing the calculated coverage and plot objects. You can replot or customize using `recoupPlot`.

```r
# Generate the plots (Profile and Heatmap)
recoupPlot(result, plotParams = list(plot = TRUE, profile = TRUE, heatmap = TRUE))
```

## Advanced Features

### Faceting by Design
To separate plots by categories (e.g., gene expression levels), provide a design data frame. The first column must match the IDs in your genomic regions.

```r
# Assuming 'design_df' has 'id' and 'group' columns
result <- recoup(
    input = test.input,
    genome = "hg19",
    design = design_df,
    selector = "group" # Column name to facet by
)
```

### RNA-Seq vs. ChIP-Seq Mode
*   **ChIP-Seq**: Calculates coverage over continuous genomic intervals.
*   **RNA-Seq**: Handles non-continuous regions (exons) and is suitable for gene body coverage where splicing is a factor.

### Handling Small Regions
When genomic regions (like short genes) are smaller than the requested number of bins, `recoup` uses interpolation. You can control this via `preprocessParams`:
*   `method = "spline"`: Uses R's `spline` function.
*   `method = "linear"`: Uses `approx`.
*   `method = "neighborhood"`: Averages neighboring points (best for high-resolution data).

### Local Annotation Store
To speed up repeated runs, build a local database of genomic features:
```r
buildAnnotationDatabase(organisms = c("hg19", "mm10"), sources = "ensembl")
```

## Tips for Success
*   **Memory Management**: For large BAM files, consider using BigWig files as input to reduce memory overhead.
*   **Plot Customization**: Since `recoup` uses `ggplot2`, you can extract the `$plots$profile` object from the result and add standard ggplot layers (labels, themes, etc.).
*   **Reusability**: `recoup` is "smart"—if you change only plotting parameters and rerun the function on the same result object, it will skip the expensive coverage calculations.

## Reference documentation
- [Introduction to the recoup package](./references/recoup_intro.md)
- [Usage of the recoup package](./references/recoup_intro.Rmd)