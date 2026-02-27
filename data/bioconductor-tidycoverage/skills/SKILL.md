---
name: bioconductor-tidycoverage
description: This tool extracts, aggregates, and visualizes genomic coverage data from BigWig files over specific genomic features using a tidy data framework. Use when user asks to perform meta-gene analysis, profile chromatin assays over genomic loci, or convert coverage tracks into tidy data frames for visualization.
homepage: https://bioconductor.org/packages/release/bioc/html/tidyCoverage.html
---


# bioconductor-tidycoverage

name: bioconductor-tidycoverage
description: Specialized workflow for extracting, aggregating, and visualizing genomic coverage tracks (BigWig) over genomic features (GRanges) using the tidyCoverage Bioconductor package. Use when the user needs to perform meta-gene analysis, profile chromatin assays (ChIP-seq, RNA-seq, ATAC-seq) over specific genomic loci, or create tidy data frames from coverage experiments for ggplot2 visualization.

# bioconductor-tidycoverage

## Overview

The `tidyCoverage` package provides a tidy framework for handling genome-wide coverage data. It introduces two primary S4 classes, `CoverageExperiment` and `AggregatedCoverage`, which extend the `SummarizedExperiment` class. These classes allow for efficient storage of per-base or binned coverage scores across multiple genomic tracks and features, facilitating quantitative comparisons and high-quality visualizations using `ggplot2`.

## Core Workflows

### 1. Creating a CoverageExperiment
The `CoverageExperiment()` constructor is the entry point. It requires genomic tracks (BigWig files) and features (GRanges).

```r
library(tidyCoverage)
library(rtracklayer)

# Define tracks (can be a named list of paths or BigWigFileList)
tracks <- list(
  Sample1 = "path/to/sample1.bw",
  Sample2 = "path/to/sample2.bw"
) |> BigWigFileList()

# Define features (GRanges or named GRangesList)
features <- import("features.bed")

# Create experiment (width centers features and resizes them)
ce <- CoverageExperiment(
  tracks = tracks,
  features = features,
  width = 3000,
  window = 1 # Optional: set to >1 for immediate binning
)
```

### 2. Data Manipulation and Binning
If per-base resolution is too high, use `coarsen()` to reduce resolution or `expand()` to convert the object into a tidy tibble.

```r
# Reduce resolution to 20bp bins
ce_coarse <- coarsen(ce, window = 20)

# Convert to a tidy tibble for custom analysis
tidy_ce <- expand(ce_coarse)
# Columns: track, features, chr, ranges, strand, coord, coverage, coord.scaled
```

### 3. Aggregating Coverage
To summarize signal across all features (e.g., a meta-gene profile), use `aggregate()`. This creates an `AggregatedCoverage` object containing metrics like mean, median, sd, and se.

```r
# Aggregate signal into 20bp bins
ac <- aggregate(ce, bin = 20)

# View available statistical assays
assays(ac) # mean, median, min, max, sd, se, ci_low, ci_high
```

### 4. Visualization
`tidyCoverage` provides `geom_aggrcoverage()` for easy plotting of aggregated profiles.

```r
library(ggplot2)

# Plot aggregated coverage
as_tibble(ac) |>
  ggplot(aes(x = coord, y = mean, col = track)) +
  geom_aggrcoverage() +
  facet_grid(features ~ .) +
  theme_bw()
```

### 5. Tidy Integration
Loading `tidySummarizedExperiment` allows the use of `dplyr` verbs directly on `CoverageExperiment` objects.

```r
library(tidySummarizedExperiment)

ce |>
  filter(track == "Sample1") |>
  aggregate(bin = 50) |>
  ggplot() +
  geom_aggrcoverage()
```

## Tips and Best Practices
- **Naming**: Always use named lists for `tracks` and `features` to ensure the resulting objects have informative row and column names.
- **Memory**: For very large feature sets, use `window` in the constructor or `coarsen()` early to reduce the memory footprint of the coverage matrices.
- **Strand Awareness**: `CoverageExperiment` respects strand information. When `center = TRUE` (default), features are centered on their midpoint; use `anchor_5p()` from `plyranges` before passing to the constructor if you want to align by TSS.
- **Scaling**: Use `scale = TRUE` in the constructor to normalize tracks if they have different global signal intensities.

## Reference documentation

- [Introduction to tidyCoverage](./references/tidyCoverage.md)