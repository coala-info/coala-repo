---
name: bioconductor-chromplot
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/chromPlot.html
---

# bioconductor-chromplot

name: bioconductor-chromplot
description: Visualization of genome-wide data along chromosomes. Use this skill to create idiograms, plot genomic elements (genes, SNPs, QTLs), and visualize data tracks such as histograms, XY plots (points/lines), and synteny maps for any organism with linear chromosomes.

# bioconductor-chromplot

## Overview
The `chromPlot` package provides a global visualization tool for genomic data. It allows users to plot multiple data tracks—including annotations, segments, histograms, and statistical values—on or alongside chromosome bodies. It is particularly useful for detecting chromosomal clustering of genes, visualizing QTL mapping results, and comparing synteny between species.

## Core Workflow

### 1. Coordinate System (Gaps)
The `gaps` argument defines the genome's coordinate system (chromosome names, lengths, and centromere positions).
- **Built-in data:** `data(hg_gap)` (human hg19) or `data(mm10_gap)` (mouse mm10).
- **Custom data:** Provide a data frame following the UCSC 'Gap' track format (Columns: `Chrom`, `Start`, `End`, `Name`).

### 2. Input Data Formats
Most arguments (`annot1-4`, `segment`, `stat`) accept:
- **Data Frames:** Must follow BED format with column names: `Chrom`, `Start`, `End`.
- **GRanges objects:** From the `GenomicRanges` package.
- **Files:** Strings containing filenames or URLs.

### 3. Main Function: `chromPlot()`
The primary function for generating visualizations.

```R
library(chromPlot)
# Basic idiogram
chromPlot(gaps=hg_gap)

# Plotting with annotations and specific chromosomes
chromPlot(gaps=hg_gap, annot1=my_genes, chr=c("1", "2", "X"), figCols=3)
```

## Visualization Types

### Chromosome Banding and Idiograms
- **G-banding:** Use the `bands` argument with a cytoBandIdeo table (e.g., `data(hg_cytoBandIdeo)`).
- **Genomic Elements:** Plot specific regions on the chromosome body by passing a data frame to `bands`. Use a `Colors` column for custom coloring.

### Histograms
- Triggered automatically for `annot` or `segment` tracks if the number of elements exceeds `maxSegs` (default 200) or if elements are smaller than `bin` size (default 1Mb).
- **Stacked Histograms:** Provide multiple tracks (`annot1`, `annot2`, etc.) to overlay data (e.g., total genes vs. differentially expressed genes).

### XY Plots (Points and Lines)
Use `stat` and `stat2` for continuous data.
- **`statCol`**: Name of the column containing numeric values.
- **`statTyp`**: "p" for points, "l" for lines, "n" for no plot (labels only).
- **`statSumm`**: Statistical function to apply per bin (e.g., "mean", "median", "sum").
- **`statThreshold`**: Draw a horizontal line and color points exceeding this value.

### Segments and QTLs
Use `segment` and `segment2` for large genomic regions.
- **`noHist=TRUE`**: Forces plotting as vertical bars instead of histograms.
- **`stack=TRUE`**: Packs non-overlapping segments to save space.
- **Two-category grouping:** If `Group` and `Group2` columns exist, segments are colored by `Group` and marked with shapes based on `Group2`.

### Synteny
- Provide a BED-like file to `bands` where the `Group` column indicates the target chromosome in the other species.

## Graphics Settings

### Placement and Side
- **`chrSide`**: A vector of 1 (left) or -1 (right) for each track: `c(annot1, annot2, annot3, annot4, segment, segment2, stat, stat2)`.
- **`figCols`**: Number of columns in the output figure.

### Colors
- **Track-level:** `colAnnot1`, `colSegments`, `colStat`, etc.
- **Element-level:** Add a `Colors` column to your data frame to override track defaults.

### Legends
- **`legChrom`**: Specify which chromosome the legend should appear under. Set to `NA` to remove the legend.

## Reference documentation
- [chromPlot](./references/chromPlot.md)