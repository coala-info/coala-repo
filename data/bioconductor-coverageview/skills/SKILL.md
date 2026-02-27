---
name: bioconductor-coverageview
description: CoverageView calculates and visualizes genomic read coverage depth from BAM or BigWIG files relative to specific coordinates. Use when user asks to generate coverage matrices, create average profile plots, draw heatmaps of ChIP-seq or RNA-seq data, or perform comparative operations between treatment and control samples.
homepage: https://bioconductor.org/packages/release/bioc/html/CoverageView.html
---


# bioconductor-coverageview

## Overview
The `CoverageView` package provides tools for calculating and visualizing read coverage depth across genomic regions. It is particularly effective for identifying enrichment patterns in ChIP-seq data or expression distribution in RNA-seq. The package operates by creating coverage matrices from alignment files (BAM/BigWIG) relative to specific genomic coordinates (provided in BED format), which can then be visualized as aggregated profiles or heatmaps.

## Core Workflow

### 1. Data Initialization
Define the input files using specific class constructors. You can optionally provide `reads_mapped` for normalization.

```r
library(CoverageView)

# For BAM files
trm <- CoverageBamFile("path/to/file.bam", reads_mapped = 28564510)

# For BigWIG files
trm_bw <- CoverageBigWigFile("path/to/file.bw")
```

### 2. Generating a Coverage Matrix
The `cov.matrix` function is the primary engine for calculating coverage. It requires a coordinate file (BED) and can extend regions or bin the data.

```r
# Calculate matrix around TSS (e.g., +/- 1000nt)
cv_matrix <- cov.matrix(trm, 
                        coordfile = "coordinates.bed", 
                        extend = 1000, 
                        bin_width = 10, 
                        num_cores = 2)

# Calculate matrix for gene bodies (divided into equal windows)
cv_matrix_genes <- cov.matrix(trm, 
                              coordfile = "genes.bed", 
                              no_windows = 100, 
                              offset = 10, 
                              normalization = "rpm")
```

### 3. Visualization
`CoverageView` provides two main plotting functions that accept single matrices or lists of matrices for comparison.

```r
# Average Profile Plot
draw.profile(cv_matrix, ylab = "avg coverage", main = "Sample Profile")

# Heatmap
draw.heatmap(cv_matrix, outfile = "heatmap.png")

# Comparison Plot (Sample vs Control)
input_list <- list(sample_matrix, control_matrix)
draw.profile(input_list, main = "Comparison")
```

### 4. Comparative Operations
You can perform arithmetic between two samples (e.g., Treatment vs. Control) directly within `cov.matrix` or for a specific interval.

**Matrix-wide operations:**
```r
# Options for 'do': "log2ratio", "ratio", or "substraction"
ratio_matrix <- cov.matrix(trm, ctl, 
                           coordfile = "coords.bed", 
                           do = "log2ratio", 
                           normalization = "rpm")
```

**Specific interval operations:**
```r
# Returns a vector of values for a specific range
interval_res <- cov.interval(trm, ctl, 
                             chr = "chr19", 
                             start = 246050, 
                             end = 247000, 
                             bin_width = 1, 
                             do = "ratio")

# Export result to WIG format
export.wig(interval_res, outfile = "output.wig")
```

## Key Parameters
- `extend`: Number of nucleotides to extend upstream and downstream of a single point (e.g., TSS).
- `no_windows`: Number of bins to divide a genomic region of variable length (e.g., gene bodies).
- `bin_width`: Fixed size of bins in nucleotides.
- `normalization`: Set to `"rpm"` (reads per million) to compare samples with different sequencing depths.
- `num_cores`: Enables parallel processing for matrix calculation.

## Reference documentation
- [CoverageView](./references/CoverageView.md)