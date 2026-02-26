---
name: r-epitrace
description: epitrace is an R package that infers the relative mitotic age of cells by measuring chromatin accessibility at specific clock-like genomic loci. Use when user asks to estimate cell age from ATAC-seq data, identify peaks associated with mitotic age, or reconstruct cell phylogenies based on replicative history.
homepage: https://cran.r-project.org/web/packages/epitrace/index.html
---


# r-epitrace

## Overview
`epitrace` is an R package designed to infer the relative mitotic age of cells by measuring chromatin accessibility at specific "clock-like" genomic loci. As cells undergo mitosis, the heterogeneity of accessibility at these reference loci decreases. This tool allows researchers to add a temporal dimension to single-cell datasets, complementing RNA velocity and trajectory inference.

## Installation
Install the package from CRAN:
```r
install.packages("epitrace")
```

## Core Workflow

### 1. Data Preparation
The package requires a peak-by-cell matrix (or bulk ATAC-seq data) and a defined peak set.

```r
# Initialize peakset and matrix
peaks <- Init_Peakset(peak_file)
matrix <- Init_Matrix(matrix_file)

# Prepare the EpiTrace object
# Supports Seurat objects or SummarizedExperiment
epi_obj <- EpiTrace_prepare_object(matrix, peaks)
```

### 2. Estimating Cell Age
The primary function for age estimation is `EpiTraceAge`.

```r
# Calculate age using default clock sets
results <- EpiTraceAge(epi_obj, 
                       genome = "hg38", 
                       clock_set = "ClockDML")

# For Seurat users, use the wrapper:
seurat_obj <- RunEpiTraceAge(seurat_obj, genome = "mm10")
```

### 3. Downstream Analysis
- **Convergence Analysis**: Check the stability of age estimates using `EpiTraceAge_Convergence`.
- **Peak Association**: Identify specific genomic regions that correlate with the calculated age using `AssociationOfPeaksToAge`.
- **Phylogeny**: Reconstruct cell lineages based on mitotic age using `RunEpiTracePhylogeny`.

## Clock Reference Options
The package provides several reference sets for different species and mechanisms:
- **ClockDML**: Based on clock-like differentially methylated loci (Standard).
- **G-quadruplex**: Uses G-quadruplex regions as reference loci for universal aging mechanisms.
- **solo_WCGW**: Specific CpG contexts often used in methylation clocks.

## Key Tips
- **Bulk vs. Single-Cell**: While optimized for single-cell, `epitrace` can process bulk ATAC-seq data to provide a population-level age estimate.
- **Genome Versions**: Ensure the `genome` parameter (e.g., "hg38", "mm10") matches your data alignment.
- **Interpretation**: EpiTrace age represents "replicative age" (number of divisions) rather than chronological time in days/years.

## Reference documentation
- [EpiTrace Home Page](./references/home_page.md)