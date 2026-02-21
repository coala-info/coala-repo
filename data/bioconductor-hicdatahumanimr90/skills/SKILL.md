---
name: bioconductor-hicdatahumanimr90
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/experiment/html/HiCDataHumanIMR90.html
---

# bioconductor-hicdatahumanimr90

name: bioconductor-hicdatahumanimr90
description: Access and explore Hi-C chromosome conformation capture data from human IMR90 fibroblast cells (Dixon et al. 2012). Use this skill to load genome-wide interaction maps (HTClist objects) and Topological Associating Domains (TADs) for spatial genome analysis.

# bioconductor-hicdatahumanimr90

## Overview
The `HiCDataHumanIMR90` package provides a processed dataset of Hi-C interactions from the human IMR90 cell line. It includes genome-wide contact maps at 40kb resolution and a set of identified Topological Associating Domains (TADs). The data is stored in formats compatible with the `HiTC` and `GenomicRanges` packages, facilitating the study of 3D genome architecture.

## Data Loading and Exploration
The package contains two primary objects: `hic_imr90_40` (interaction data) and `tads_imr90` (domain boundaries).

```r
# Load the package and data
library(HiCDataHumanIMR90)
library(HiTC)
data(Dixon2012_IMR90)

# Explore the Hi-C interaction list
show(hic_imr90_40)
isComplete(hic_imr90_40) # Check if all intra/inter maps are present
seqlevels(hic_imr90_40)  # List available chromosomes
```

## Working with Interaction Maps
Interaction data is stored as an `HTClist`. Individual maps can be accessed using chromosome pair names.

```r
# Access a specific chromosome interaction map (e.g., chrX)
map_x <- hic_imr90_40$chrXchrX

# Get detailed statistics for a map
detail(map_x)

# Get summary statistics for the first few maps in the list
head(summary(hic_imr90_40))
```

## Analyzing Topological Domains (TADs)
TADs are provided as a `GRanges` object, allowing for standard genomic interval operations.

```r
# View TAD boundaries
show(tads_imr90)

# Example: Count TADs per chromosome
table(seqnames(tads_imr90))
```

## Visualization
You can visualize specific genomic regions by extracting a subset of the interaction matrix and overlaying the TAD tracks.

```r
# 1. Extract a specific region (e.g., 10Mb window on chrX)
regx <- extractRegion(hic_imr90_40$chrXchrX, 
                     chr="chrX", 
                     from=95000000, 
                     to=105000000)

# 2. Plot the interaction map with TAD tracks
# maxrange controls the color scale intensity
plot(regx, tracks=list(tads_imr90), maxrange=20)
```

## Usage Tips
- **Resolution**: The interaction data in this package is binned at 40kb.
- **Dependencies**: Always load `HiTC` alongside this package to access the methods for `HTClist` and `HTCexp` objects.
- **Memory**: While these are processed objects, genome-wide Hi-C data can be memory-intensive; use `extractRegion` to focus on specific loci for plotting.

## Reference documentation
- [Human Fibroblast IMR90 Hi-C Data (Dixon et al.)](./references/HiC_Human_IMR90.md)