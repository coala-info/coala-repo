---
name: bioconductor-spectraltad
description: SpectralTAD identifies Topologically Associated Domains from Hi-C contact matrices using a windowed spectral clustering algorithm. Use when user asks to perform hierarchical TAD calling, filter TADs by quality scores, or export TAD coordinates for visualization in Juicebox or HiCExplorer.
homepage: https://bioconductor.org/packages/release/bioc/html/SpectralTAD.html
---

# bioconductor-spectraltad

name: bioconductor-spectraltad
description: Identify Topologically Associated Domains (TADs) from Hi-C contact matrices using windowed spectral clustering. Use this skill when you need to perform hierarchical TAD calling, filter TADs by quality (silhouette score or z-score), or export TAD coordinates for visualization in Juicebox or HiCExplorer.

# bioconductor-spectraltad

## Overview
SpectralTAD is an R package for fast, hierarchical TAD calling. It utilizes a windowed spectral clustering algorithm that is robust to noise and sparsity. It supports various input formats (square matrices, sparse 3-column, TopDom format) and provides automated resolution estimation.

## Core Functions
- `SpectralTAD()`: The primary function for single-CPU TAD calling.
- `SpectralTAD_Par()`: Parallelized version for processing multiple chromosomes or replicates simultaneously.

## Typical Workflow

### 1. Data Preparation
SpectralTAD accepts three main matrix formats:
- **n x n**: Square symmetric contact matrix.
- **n x (n+3)**: Square matrix with three leading columns (chr, start, end).
- **Sparse 3-column**: Coordinated list (region1, region2, IF).

```r
library(SpectralTAD)
# Load example sparse data
data("rao_chr20_25_rep") 
```

### 2. Basic TAD Calling
Run the algorithm with minimal parameters. Resolution is automatically estimated if not provided.

```r
# Basic run (Level 1 TADs)
results <- SpectralTAD(rao_chr20_25_rep, chr = "chr20")

# View results
head(results$Level_1)
```

### 3. Hierarchical TAD Calling
Specify the number of levels to find sub-TADs.

```r
# Find 3 levels of TAD hierarchy
spec_hier <- SpectralTAD(rao_chr20_25_rep, 
                         chr = "chr20", 
                         levels = 3)

# Access different levels
level1 <- spec_hier$Level_1
level2 <- spec_hier$Level_2
```

### 4. Filtering and Quality Control
- **Silhouette Filtering**: Set `qual_filter = TRUE` to remove TADs with a silhouette score < 0.25 (indicates poor connectivity).
- **Z-score Filtering**: Set `z_clust = TRUE` to use eigenvector gap z-scores (faster, often results in finer TADs).
- **Gap Threshold**: Use `gap_threshold` (default 1) to filter out rows/columns with high percentages of zeros near the diagonal.

```r
# Quality filtered run
qual_filt <- SpectralTAD(rao_chr20_25_rep, 
                         chr = "chr20", 
                         qual_filter = TRUE)
```

### 5. Parallel Processing
Use `SpectralTAD_Par` for multiple matrices.

```r
cont_list <- list(mat1, mat2, mat3)
chrs <- c("chr1", "chr2", "chr3")
results_par <- SpectralTAD_Par(cont_list = cont_list, 
                               chr_over = chrs, 
                               cores = 3)
```

### 6. Exporting for Visualization
Format output for external tools using `out_format`.

```r
# For HiCExplorer (.bed)
SpectralTAD(rao_chr20_25_rep, chr = "chr20", 
            out_format = "hicexplorer", out_path = "tads.bed")

# For Juicebox (.bedpe)
SpectralTAD(rao_chr20_25_rep, chr = "chr20", 
            out_format = "juicebox", out_path = "tads.bedpe")
```

## Tips
- **Performance**: `z_clust = TRUE` is the fastest method. Sparse 3-column matrices take longer to process than square matrices due to internal conversion.
- **Resolution**: While the tool can estimate resolution, explicitly providing the `resolution` parameter is recommended for consistency.
- **Data Types**: For `.hic`, `.cool`, or HiC-Pro files, use the `HiCcompare` package to convert data into a compatible sparse or square format before running SpectralTAD.

## Reference documentation
- [SpectralTAD Vignette (Rmd)](./references/SpectralTAD.Rmd)
- [SpectralTAD Vignette (Markdown)](./references/SpectralTAD.md)