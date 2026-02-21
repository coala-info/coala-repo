---
name: bioconductor-hicool
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/HiCool.html
---

# bioconductor-hicool

name: bioconductor-hicool
description: Specialized R package for processing, normalizing, and visualizing Hi-C data using the HiC-Pro pipeline outputs or raw files. Use this skill when a user needs to handle Hi-C contact maps, perform matrix normalization (ICE), calculate A/B compartments, or generate genomic tracks and heatmaps within the Bioconductor ecosystem.

# bioconductor-hicool

## Overview
HiCool is an R interface designed to facilitate the processing of Hi-C data, specifically acting as a bridge for the HiC-Pro pipeline and the Cooler file format. It provides a streamlined workflow for importing raw contact data, performing Iterative Correction (ICE) normalization, and conducting downstream analyses such as compartment detection and visualization. It integrates tightly with the `HiCExperiment` and `InteractionSet` frameworks.

## Core Workflow

### 1. Data Import
HiCool primarily handles HiC-Pro output files or `.cool`/`.mcool` files.

```r
library(HiCool)

# Import from HiC-Pro output
# Requires the matrix file and the bed/bins file
hi_data <- importHiCPro(
  matrix = "path/to/matrix.matrix",
  bed = "path/to/bins.bed",
  genome = "hg38"
)

# Import from Cooler files
hi_cool <- importCooler("path/to/file.cool", resolution = 50000)
```

### 2. Normalization (ICE)
If the data is raw, apply Iterative Correction (ICE) to remove technical biases.

```r
# Apply ICE normalization
hi_norm <- updateObject(hi_data) # Ensure object is current
hi_ice <- ice(hi_norm, max_iter = 100)
```

### 3. Analysis: A/B Compartments
Identify active (A) and inactive (B) chromatin compartments using principal component analysis (PCA).

```r
# Calculate compartments at a specific resolution
compartments <- getCompartments(hi_ice, resolution = 100000)

# Access the results (GRanges object)
head(compartments)
```

### 4. Visualization
HiCool provides functions to generate publication-quality heatmaps and genomic tracks.

```r
# Plot a specific genomic region
plotHiC(
  hi_ice, 
  chrom = "chr1", 
  start = 10e6, 
  end = 15e6, 
  resolution = 50000,
  type = "triangle"
)

# Plotting compartments alongside the matrix
plotCompartments(compartments, chrom = "chr1")
```

## Tips and Best Practices
- **Resolution Selection**: Always ensure the resolution (bin size) is appropriate for the sequencing depth. Compartments are typically calculated at 50kb or 100kb, while loops/TADs require higher resolution (5kb-10kb).
- **Memory Management**: Hi-C matrices can be extremely large. Use the `Cooler` format (via `importCooler`) for disk-backed access to avoid crashing R sessions with large genomes.
- **Genome Versions**: Ensure the `genome` argument matches the assembly used for mapping (e.g., "hg38", "mm10") to ensure correct chromosome lengths and annotations.
- **Integration**: The objects returned are often compatible with `HiCExperiment`, allowing for advanced differential interaction analysis.

## Reference documentation
- [HiCool Bioconductor Page](https://bioconductor.org/packages/release/bioc/html/HiCool.html)
- [HiCool GitHub Repository](https://github.com/js2264/HiCool)