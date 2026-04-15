---
name: bioconductor-samexplorer
description: samExploreR assesses the impact of sequencing depth and genomic annotation choices on RNA-seq results through virtual subsampling and statistical analysis. Use when user asks to subsample BAM or SAM files, simulate lower sequencing depths, or test the robustness and reproducibility of RNA-seq metrics across different experimental parameters.
homepage: https://bioconductor.org/packages/3.8/bioc/html/samExploreR.html
---

# bioconductor-samexplorer

## Overview

The `samExploreR` package provides tools to assess how sequencing depth and genomic annotation choices affect the results of RNA-seq experiments. It allows users to "virtually" subsample existing SAM or BAM files to simulate lower sequencing depths and provides statistical frameworks (ANOVA) to test the stability of downstream metrics (like differentially expressed gene counts) across these variations.

## Core Functions

### 1. Subsampling and Counting with `samExplore`
This is the primary function for generating subsampled count data. It extends the functionality of `Rsubread::featureCounts`.

```r
library(samExploreR)
library(RNAseqData.HNRNPC.bam.chr14)

# Define input BAM files
inpf <- RNAseqData.HNRNPC.bam.chr14_BAMFILES

# Perform subsampling
# subsample_d: fraction of reads to keep (0.0 to 1.0)
# N_boot: number of repeated virtual experiments
results <- samExplore(
  files = inpf,
  annot.inbuilt = "hg19",
  subsample_d = 0.8,
  N_boot = 5,
  GTF.featureType = "exon",
  GTF.attrType = "gene_id"
)
```

### 2. Robustness Analysis with `exploreRob`
Tests if results change significantly when sequencing depth ($f$) changes for a fixed annotation.

```r
# Requires a data frame with columns: Label (annotation), Variable (f value), Value (metric)
data("df_sole")

# Run ANOVA for specific f values within one annotation type
rob_results <- exploreRob(
  df_sole, 
  lbl = 'New, Gene', 
  f_vect = c(0.85, 0.9, 0.95)
)
```

### 3. Reproducibility Analysis with `exploreRep`
Tests the influence of different annotation types or summarization methods for a fixed sequencing depth ($f$).

```r
# Run ANOVA across different annotations for a fixed f
rep_results <- exploreRep(
  df_sole, 
  lbl_vect = c('New, Gene', 'Old, Gene', 'New, Exon'), 
  f = 0.9
)
```

### 4. Visualization with `plotSamExplorer`
Generates boxplots of the investigated metric across different sequencing depths.

```r
data("df_sole")
plotsamExplorer(
  df_sole, 
  p.depth = 0.9, 
  font.size = 4, 
  anova = FALSE, 
  save = FALSE
)
```

## Typical Workflow

1.  **Data Preparation**: Identify BAM/SAM files and the appropriate GTF annotation.
2.  **Virtual Sequencing**: Use `samExplore` with varying `subsample_d` values (e.g., 0.1 to 0.9) and multiple `N_boot` replicates to simulate different experimental conditions.
3.  **Metric Calculation**: Calculate your target metric (e.g., number of DE genes using `edgeR` or `DESeq2`) for every subsampled replicate.
4.  **Data Formatting**: Organize results into a data frame with `Label`, `Variable` (f), and `Value` (metric) columns.
5.  **Statistical Testing**: 
    *   Use `exploreRob` to find the "saturation point" where increasing sequencing depth no longer significantly changes results.
    *   Use `exploreRep` to determine if your choice of annotation (e.g., RefSeq vs Ensembl) introduces significant variance.
6.  **Visualization**: Use `plotSamExplorer` to visualize the stability of your findings.

## Usage Tips
*   **Memory Management**: `samExplore` can be memory-intensive as it processes multiple replicates. Ensure `N_boot` is scaled according to available system resources.
*   **Annotation**: The `annot.inbuilt` parameter supports "hg19", "hg38", "mm9", and "mm10". For other organisms, provide an external GTF file via `annot.ext`.
*   **Probability-based Subsampling**: Every read is kept with probability $f$. This means the exact number of reads will vary slightly between replicates even with the same $f$ value.

## Reference documentation
- [Manual](./references/Manual.md)