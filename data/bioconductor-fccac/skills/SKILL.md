---
name: bioconductor-fccac
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/fCCAC.html
---

# bioconductor-fccac

name: bioconductor-fccac
description: Assess covariance and reproducibility between nucleic acid sequencing datasets (ChIP-seq, ATAC-seq, RNA-seq, etc.) using functional Canonical Correlation Analysis (fCCA). Use this skill to compare biological or technical replicates and identify correlations between different genomic datasets using BigWig and peak files.

# bioconductor-fccac

## Overview

The `fCCAC` package implements functional Canonical Correlation Analysis to evaluate the covariance between Next-Generation Sequencing (NGS) datasets. It is primarily used to assess reproducibility across biological or technical replicates and to compare different types of sequencing data (e.g., comparing ChIP-seq for different marks) to identify potential correlations.

## Typical Workflow

1.  **Prepare Input Files**: You need BigWig files (.bw) representing mapped read densities and a BED file (.bed) containing genomic regions of interest (e.g., merged peaks, exons).
2.  **Run fCCA**: Use the `fccac` function to calculate canonical correlations and F-values.
3.  **Visualize Results**: Generate a heatmap of the F-values to visualize pairwise covariance.

## Key Functions and Usage

### fccac

The main function for performing functional Canonical Correlation Analysis.

```r
library(fCCAC)

# Define file paths
bw_files <- c("rep1.bw", "rep2.bw", "rep3.bw")
peak_file <- "merged_peaks.bed"
sample_labels <- c("Mark_Rep1", "Mark_Rep2", "Mark_Rep3")

# Run analysis
results <- fccac(peaks = peak_file, 
                 bigwigs = bw_files, 
                 labels = sample_labels, 
                 splines = 15, 
                 nbins = 100, 
                 ncan = 15,
                 main = "Analysis Title")

# View results (dataframe of pairwise comparisons)
head(results)
```

**Important Parameters:**
*   `splines`: Number of splines for functional data smoothing. A low number (e.g., 10-20) is recommended relative to the region length to ensure heavy smoothing.
*   `nbins`: Number of bins for data discretization. Use lower values (e.g., 50) for narrow peaks (TFs) and higher values for broad domains.
*   `ncan`: Number of canonical correlations to compute. This is limited by the number of splines and genomic regions.

### heatmapfCCAC

Generates a heatmap based on the F-values calculated by `fccac`.

```r
heatmapfCCAC(results)
```

## Interpreting Results

*   **F-value**: An overall measure of shared covariance. Values close to 100 indicate very high reproducibility or strong covariance between datasets.
*   **Squared Canonical Correlation**: Values (typically the first canonical correlation) > 0.99 indicate high reproducibility in replicates.

## Tips and Constraints

*   **Platform Limitation**: The `rtracklayer` dependency may have issues reading BigWig files on Windows. This package is best used on Unix-like systems (Linux/macOS).
*   **Smoothing**: Functional CCA relies on smoothing. If results seem noisy, consider reducing the number of `splines`.
*   **Memory**: Processing many large BigWig files across many peak regions can be memory-intensive. Ensure the `peaks` file is filtered to relevant regions of interest.

## Reference documentation

- [fCCAC](./references/fCCAC.md)