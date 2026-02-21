---
name: bioconductor-degnorm
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/DegNorm.html
---

# bioconductor-degnorm

name: bioconductor-degnorm
description: Corrects for transcript degradation bias in RNA-seq data. Use when analyzing RNA-seq samples with varying degradation levels to improve differential expression accuracy. Supports calculating gene-specific coverage from BAM files, estimating Degradation Index (DI) scores, and generating normalized read counts for downstream DE analysis.

# bioconductor-degnorm

## Overview

DegNorm (Degradation Normalization) is a bioinformatics pipeline that corrects for bias caused by heterogeneous transcript degradation in RNA-seq data. Unlike global normalization methods, DegNorm accounts for the fact that degradation is both sample-specific and gene-specific (e.g., longer genes often degrade faster). It produces a Degradation Index (DI) and degradation-normalized read counts suitable for differential expression tools like DESeq2 or edgeR.

## Installation

Install the package via BiocManager:

```r
if(!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("DegNorm")
library(DegNorm)
```

## Typical Workflow

### 1. Compute Coverage from BAM Files
Use `read_coverage_batch` to process alignment files. This step is computationally intensive.

```r
# Provide paths to BAM files and the corresponding GTF
bam_files <- c("sample1.bam", "sample2.bam")
gtf_file <- "annotation.gtf"

# Calculate coverage (use multiple cores for efficiency)
coverage_res <- read_coverage_batch(bam_files, gtf_file, cores = 4)

# Extract coverage and raw counts
coverage_matrix <- coverage_res$coverage
raw_counts <- coverage_res$counts
```

### 2. Run DegNorm Core Algorithm
The `degnorm` function performs rank-one over-approximation to estimate degradation.

```r
res_degnorm <- degnorm(read_coverage = coverage_res$coverage,
                       counts = coverage_res$counts,
                       iteration = 5,
                       down_sampling = 1, # 1 for efficiency, 0 for full resolution
                       grid_size = 10,    # Bin size in bp for down-sampling
                       loop = 100,
                       cores = 4)

# Extract normalized counts for DE analysis
norm_counts <- res_degnorm$counts_normed
```

### 3. Quality Control and Visualization
Evaluate the degradation patterns across samples and genes.

```r
# Summary of results
summary_DegNormClass(res_degnorm)

# Plot coverage for a specific gene (e.g., "SOD1")
plot_coverage(gene_name = "SOD1", 
              coverage_output = coverage_res, 
              degnorm_output = res_degnorm, 
              group = c(0, 1, 1))

# Visualize Degradation Index (DI) distribution
plot_boxplot(DI = res_degnorm$DI)
plot_heatmap(DI = res_degnorm$DI)
plot_corr(DI = res_degnorm$DI)
```

## Key Parameters and Tips

- **Parallel Computing**: Always specify the `cores` argument in `read_coverage_batch` and `degnorm`. This package is designed for high-performance computing environments.
- **Down-sampling**: Set `down_sampling = 1` and a `grid_size` (default 10bp, recommended < 50bp) to significantly speed up processing without major loss of accuracy.
- **Gene Filtering**: `degnorm` automatically filters out genes with extremely low counts (default: genes where >50% of samples have <5 reads). This explains why the output object may contain fewer genes than the input coverage object.
- **Input for DE**: Use the `counts_normed` matrix as the input for downstream differential expression tools.

## Reference documentation

- [DegNorm Vignette (Rmd)](./references/DegNorm.Rmd)
- [DegNorm Vignette (Markdown)](./references/DegNorm.md)