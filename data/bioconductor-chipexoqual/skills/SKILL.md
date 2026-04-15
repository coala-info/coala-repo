---
name: bioconductor-chipexoqual
description: This tool provides a statistical quality control pipeline for ChIP-exo and ChIP-nexus data. Use when user asks to analyze aligned reads, identify read islands, calculate enrichment statistics, or generate diagnostic plots to assess library complexity and strand imbalance.
homepage: https://bioconductor.org/packages/release/bioc/html/ChIPexoQual.html
---

# bioconductor-chipexoqual

name: bioconductor-chipexoqual
description: Statistical quality control (QC) pipeline for ChIP-exo and ChIP-nexus data. Use this skill to analyze aligned reads (BAM files or GAlignments), identify read islands, calculate enrichment statistics (ARC, URC, FSR), and generate diagnostic plots to assess library complexity and strand imbalance.

## Overview

The `ChIPexoQual` package provides a specialized pipeline for the quality control of ChIP-exo and ChIP-nexus experiments. Unlike standard ChIP-seq, ChIP-exo uses exonuclease digestion to achieve base-pair resolution. This package partitions the genome into "islands" (overlapping clusters of reads) and calculates metrics to evaluate if an experiment has high enrichment and sufficient library complexity.

## Core Workflow

### 1. Data Loading and Object Creation
The primary data structure is the `ExoData` object. You can create it from BAM files or `GAlignments` objects.

```r
library(ChIPexoQual)

# From a BAM file
ex_data <- ExoData(file = "path/to/sample.bam", mc.cores = 2L, verbose = FALSE)

# From GAlignments
library(GenomicAlignments)
reads <- readGAlignments("path/to/sample.bam")
ex_data <- ExoData(reads = reads)

# Check total reads
nreads(ex_data)
```

### 2. Diagnostic Plotting
The package uses three main plots to visualize sample quality:

*   **ARC vs URC Plot**: Evaluates enrichment and complexity.
    *   `ARC` (Average Read Coefficient): $Reads / Width$.
    *   `URC` (Unique Read Coefficient): $UniquePositions / Reads$.
    *   *Interpretation*: High-quality samples show a decreasing trend in URC as ARC increases (high enrichment) and higher overall URC levels (high complexity).
*   **Region Composition Plot**: Shows the proportion of regions formed by fragments on exclusive strands.
    *   *Interpretation*: High-quality experiments show exponential decay in single-stranded regions.
*   **FSR Distribution Plot**: Visualizes the Forward Strand Ratio.
    *   *Interpretation*: Distributions that centralize quickly around the median as depth increases indicate better enrichment.

```r
# Compare multiple samples
ARCvURCplot(list(rep1, rep2), names.input = c("Rep1", "Rep2"))

# Strand imbalance plots
p1 <- regionCompplot(ex_data)
p2 <- FSRDistplot(ex_data)
```

### 3. Statistical Quality Evaluation
The pipeline fits a linear model $D_i = \beta_1 U_i + \beta_2 W_i + \varepsilon_i$ (where $D$ is reads, $U$ is unique positions, and $W$ is width) to quantify quality.

*   **$\beta_1$ (Library Complexity)**: Values $\leq 10$ typically indicate high-quality samples. High values suggest low complexity (PCR bottlenecks).
*   **$\beta_2$ (Enrichment/Noise)**: Values $\approx 0$ indicate high quality.

```r
# Generate boxplots of parameter distributions
paramDistBoxplot(ex_data, which.param = "beta1")
paramDistBoxplot(ex_data, which.param = "beta2")

# Access median values
median(beta1(ex_data))
median(-beta2(ex_data))
```

### 4. Subsampling for Deeply Sequenced Data
For very deep libraries, patterns might look like low quality due to saturation. Use subsampling to check if quality metrics stabilize.

```r
sample_depths <- seq(1e5, 1e6, by = 2e5)
exo_list <- ExoDataSubsampling(file = "sample.bam", sample.depth = sample_depths)
paramDistBoxplot(exo_list, which.param = "beta1")
```

## Tips for Analysis
- **Island Subsetting**: You can use `subset()` on `ExoData` objects to explore specific regions (e.g., `subset(ex_data, uniquePos > 10)`) and pass these to plotting functions.
- **Parallelization**: Use the `mc.cores` argument in `ExoData` to speed up the initial processing of BAM files.
- **Comparison**: Always process replicates together in a list when calling plotting functions to ensure consistent scales for comparison.

## Reference documentation
- [ChIPexoQual: A quality control pipeline for ChIP-exo/nexus data.](./references/vignette.md)
- [ChIPexoQual Vignette Source](./references/vignette.Rmd)