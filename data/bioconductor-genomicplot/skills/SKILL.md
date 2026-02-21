---
name: bioconductor-genomicplot
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/GenomicPlot.html
---

# bioconductor-genomicplot

## Overview

`GenomicPlot` is an R/Bioconductor package designed for efficient visualization of Next-Generation Sequencing (NGS) data. It handles the entire pipeline from raw data (.bam, .bigwig) to publication-quality plots, including profile line plots with error bands, heatmaps, and statistical comparisons. It is particularly useful for comparing signal distributions across different genomic features (e.g., 5' UTR, CDS, 3' UTR) or custom regions defined by BED/narrowPeak files.

## Core Workflow

### 1. Setup and Parameter Initialization
Before plotting, define import parameters using `setImportParams`. This controls how reads are processed (normalization, strand-specificity, and genomic shifts).

```r
library(GenomicPlot)

# Define parameters for BAM/BED import
importParams <- setImportParams(
  offset = 0,            # Shift for CLIP-seq (e.g., -1) or ChIP-seq (0)
  fix_width = 150,       # Extend reads to a fixed width
  fix_point = "start",   # Point to keep (start, end, or center)
  norm = TRUE,           # Normalize by library size
  genome = "hg19"        # Reference genome
)
```

### 2. Metagene and Gene Body Plotting
Use `plot_5parts_metagene` to visualize signals across scaled gene components (5' UTR, CDS, 3' UTR).

```r
# queryFiles and inputFiles should be named vectors of file paths
plot_5parts_metagene(
  queryFiles = c("Sample" = "path/to/treat.bam"),
  inputFiles = c("Input" = "path/to/input.bam"),
  gFeatures_list = list("metagene" = gf5_meta), # gf5_meta is a pre-built feature list
  importParams = importParams,
  heatmap = TRUE,
  smooth = TRUE
)
```

### 3. Plotting Around Genomic Regions or Loci
*   **`plot_region`**: Plots signals across the full length of provided ranges (e.g., peaks, exons).
*   **`plot_locus`**: Plots signals centered on a specific point (e.g., TSS, peak summit).

```r
# Plotting around peak centers
plot_locus(
  queryFiles = queryfiles,
  centerFiles = c("Peaks" = "path/to/peaks.bed"),
  ext = c(-500, 500),      # Extension around the locus
  hl = c(-100, 100),       # Highlight/test region
  refPoint = "center",     # Reference point: start, end, or center
  statsMethod = "wilcox.test",
  importParams = importParams
)
```

### 4. Peak Annotation and Overlaps
Analyze where peaks fall relative to gene models and how different peak sets overlap.

```r
# Distribution of peaks in genomic features
pa <- plot_peak_annotation(
  peakFile = "path/to/peaks.bed",
  gtfFile = "path/to/annotation.gtf",
  importParams = importParams,
  fiveP = -2000, dsTSS = 300 # Define promoter region
)

# Venn diagrams and overlap matrices
plot_overlap_bed(bedList = list("SetA" = "a.bed", "SetB" = "b.bed"))
```

### 5. Sample Correlation
Evaluate library reproducibility using PCA and correlation heatmaps.

```r
plot_bam_correlation(
  bamFiles = c("S1" = "s1.bam", "S2" = "s2.bam"),
  binSize = 100000,
  importParams = importParams
)
```

## Tips for Success
*   **Named Vectors**: Always provide named vectors for `queryFiles`, `inputFiles`, and `centerFiles`. The names are used as labels in the plot legends.
*   **TxDb Objects**: For gene-based plots, you often need a `TxDb` object. Use `AnnotationDbi::loadDb` or `GenomicFeatures::makeTxDbFromGFF`.
*   **Memory Management**: For large BAM files, ensure `nc` (number of cores) is set appropriately for your environment to speed up matrix computation.
*   **Normalization**: If comparing samples with different sequencing depths, ensure `norm = TRUE` in `setImportParams`.

## Reference documentation
- [GenomicPlot: an R package for efficient and flexible visualization of genome-wide NGS coverage profiles](./references/GenomicPlot_vignettes.md)