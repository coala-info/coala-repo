---
name: bioconductor-hicontacts
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/HiContacts.html
---

# bioconductor-hicontacts

name: bioconductor-hicontacts
description: Analysis and visualization of Hi-C data using the HiContacts R package. Use this skill to import .cool and .mcool files, generate contact map heatmaps, perform matrix arithmetics (detrending, autocorrelation, ratios), and identify topological features like compartments, insulation scores, and borders.

# bioconductor-hicontacts

## Overview

`HiContacts` is a Bioconductor package designed for the advanced analysis of chromosome conformation capture (Hi-C) data. It builds upon the `HiCExperiment` class to provide a high-level interface for manipulating contact matrices, calculating topological features, and generating publication-quality visualizations. It is particularly effective for comparing different Hi-C datasets through matrix arithmetics and aggregated feature analysis.

## Core Workflow

### 1. Data Import and Setup

Data is typically imported from `.cool` or `.mcool` files into `HiCExperiment` objects.

```r
library(HiContacts)
library(HiCExperiment)
library(HiContactsData)

# Import a specific resolution from an mcool file
mcool_path <- HiContactsData('yeast_wt', format = 'mcool')
hic <- import(mcool_path, format = 'mcool', resolution = 1000, focus = 'IV')
```

### 2. Visualization

The `plotMatrix` function is the primary tool for visualizing contact maps.

- **Basic Heatmap**: `plotMatrix(hic, use.scores = 'balanced', limits = c(-4, -1))`
- **With Features**: Overlay loops or borders by passing `GInteractions` or `GRanges` objects.
- **Aggregated Analysis**: Use `HiContacts::aggregate()` to create APA (Aggregate Peak Analysis) plots over a set of genomic targets.

### 3. Matrix Arithmetics

`HiContacts` allows for direct comparison and transformation of contact maps:

- **Detrending**: Remove the distance-decay effect to highlight local enrichments.
  ```r
  hic_detrended <- detrend(hic)
  ```
- **Autocorrelation**: Highlight domain structures.
  ```r
  hic_auto <- autocorrelate(hic)
  ```
- **Comparison**: Use `divide(hic1, by = hic2)` to calculate fold-change maps or `merge(hic1, hic2)` to sum contacts.
- **Smoothing**: Use `despeckle(hic, focal.size = 3)` to reduce noise.

### 4. Topological Feature Extraction

- **Compartments**: Identify A/B compartments using Eigenvector decomposition.
  ```r
  hic <- getCompartments(hic)
  plotSaddle(hic)
  ```
- **Insulation and Borders**: Calculate diamond insulation scores to find Topologically Associating Domain (TAD) boundaries.
  ```r
  hic <- getDiamondInsulation(hic, window_size = 8000)
  hic <- getBorders(hic)
  ```

### 5. Advanced Analysis

- **Virtual 4C**: Extract "points-of-view" from a Hi-C matrix.
  ```r
  v4c <- virtual4C(hic, viewpoint = GRanges('chrIV:400000-401000'))
  plot4C(v4c)
  ```
- **Distance Law (P(s))**: Calculate the probability of contact as a function of genomic distance.
  ```r
  ps <- distanceLaw(hic)
  plotPs(ps)
  ```
- **Cis/Trans Ratio**: Calculate the proportion of intra- vs inter-chromosomal contacts using `cisTransRatio(hic)`.

## Tips and Best Practices

- **Resolution Management**: Use `zoom(hic, resolution = ...)` to quickly switch between resolutions available in an mcool file.
- **Focusing**: Use `refocus(hic, 'chrII:1-100000')` to subset the experiment to a specific genomic region for faster processing and plotting.
- **Score Selection**: Most functions allow specifying `use.scores`. Ensure your input file has 'balanced' scores (ICE/KR normalization) for meaningful biological comparisons.
- **Parallelization**: For large-scale aggregations, provide a `BPPARAM` argument (e.g., `BiocParallel::MulticoreParam()`) to `aggregate()`.

## Reference documentation

- [HiContacts](./references/HiContacts.md)