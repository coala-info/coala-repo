---
name: bioconductor-transview
description: This tool analyzes and visualizes read density profiles from NGS data such as ChIP-seq and RNA-seq. Use when user asks to create density maps from BAM files, normalize read counts, generate genomic heatmaps, or plot average enrichment profiles across genomic regions.
homepage: https://bioconductor.org/packages/release/bioc/html/TransView.html
---


# bioconductor-transview

name: bioconductor-transview
description: Analysis and visualization of read density profiles from ChIP-seq, RNA-seq, and other NGS technologies. Use this skill when needing to generate high-resolution density maps, perform peak-based analysis, or visualize read distributions across genomic regions using the TransView R package.

# bioconductor-transview

## Overview
TransView is a Bioconductor package designed for the efficient memory-handling and visualization of Next-Generation Sequencing (NGS) data. It excels at creating density maps (DensityContainer objects) from BAM files, allowing for rapid access to read counts across specific genomic coordinates. It is particularly useful for comparing density profiles across different samples, normalizing ChIP-seq/RNA-seq data, and generating publication-quality heatmaps or profile plots.

## Core Workflow

### 1. Data Import and Density Generation
The primary entry point is `annotateReads` and `renameChr` to prepare annotations, followed by `parseReads` to create a `DensityContainer`.

```r
library(TransView)

# Create a DensityContainer from a BAM file
# ex_met: 'paired' for paired-end, 'filtered' to use MAPQ
dc <- parseReads(test_bam, ex_met = "paired", filtered = 10, last_line = 1000)

# Access basic information
sliceData(dc, chrom="chr1", start=1, end=1000)
```

### 2. Genomic Normalization
TransView provides automated normalization to account for library size differences.

```r
# Calculate normalization factors based on total reads
dc_norm <- parseReads(test_bam, norm = TRUE)
```

### 3. Region-based Density Extraction
Use `macs2gr` to import peak files or standard `GRanges` objects to extract densities.

```r
# Extract densities for a set of peaks
peaks <- macs2gr("peaks.xls")
dens_mat <- rmvtnorm(dc, peaks, bin_size = 10)
```

### 4. Visualization
The package provides high-level functions for plotting profiles.

```r
# Plot average profile across regions
plotProfile(dc, peaks, bin_size = 50, col = "red", main = "ChIP-seq Profile")

# Generate heatmaps for multiple regions
plotHeatmap(dc, peaks, cluster = TRUE, col = heat.colors(10))
```

## Key Functions
- `parseReads()`: The constructor for `DensityContainer`. Handles BAM file parsing, filtering, and memory mapping.
- `sliceData()`: Retrieves raw or normalized read densities for a specific genomic range.
- `rmvtnorm()`: Returns a matrix of densities across multiple GRanges, useful for custom heatmap generation.
- `plotProfile()`: Visualizes the average enrichment across a set of genomic features (e.g., TSS, peaks).
- `plotHeatmap()`: Creates density heatmaps, often used to show signal distribution across gene bodies or enhancers.
- `gtf2gr()` / `macs2gr()`: Helper functions to convert GTF or MACS peak files into compatible GRanges objects.

## Tips for Efficient Usage
- **Memory Management**: TransView uses memory mapping. For very large datasets, ensure the `last_line` or `filtered` arguments are used during initial testing to avoid loading unnecessary data.
- **Binning**: When working with large genomic regions, use the `bin_size` argument in `rmvtnorm` or `plotProfile` to reduce computational load and noise.
- **Strand Specificity**: For RNA-seq, pay attention to the `strand` argument in slicing functions to ensure correct antisense/sense density attribution.

## Reference documentation
- [TransView Bioconductor Page](https://bioconductor.org/packages/release/bioc/html/TransView.html)