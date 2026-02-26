---
name: bioconductor-bubbletree
description: bioconductor-bubbletree analyzes and visualizes tumor purity, clonality, and somatic copy number alterations using next-generation sequencing data. Use when user asks to estimate tumor fraction, model clonal architecture, or generate bubble plots for genomic segments from B-allele frequencies and log-ratios.
homepage: https://bioconductor.org/packages/release/bioc/html/BubbleTree.html
---


# bioconductor-bubbletree

name: bioconductor-bubbletree
description: Analysis and visualization of tumor purity, clonality, and copy number variations (CNV) using Next-Generation Sequencing (NGS) data. Use this skill to generate bubble plots for genomic segments, estimate tumor fraction, and model clonal architecture from B-allele frequencies (BAF) and log-ratios.

## Overview
BubbleTree is a Bioconductor package designed for the analysis of somatic copy number alterations (SCNA) in tumor samples. It provides a unique visualization approach—the "bubble track"—where genomic segments are represented as bubbles. The position and size of these bubbles reflect the copy number state and the prevalence of the alteration, allowing for the intuitive estimation of tumor purity and the identification of subclonal populations.

## Data Preparation
BubbleTree primarily operates on `GRanges` objects. Your input data should typically include:
- Genomic coordinates (chr, start, end).
- **LogR/Ratio**: The copy number intensity ratio.
- **BAF**: B-Allele Frequency (values between 0 and 0.5 or 0 and 1).

```r
library(BubbleTree)
# Example: Loading provided vignette data
data(vignette_data)
# rbd.gt is a GRanges object containing segmented data
```

## Core Workflow

### 1. Annotation
Before analysis, segments should be annotated with genomic features.
```r
# Load annotation data (e.g., for hg19)
data(hg19.GRanges)
# Annotate your segments
annotated_data <- annotate_gr(rbd.gt, hg19.GRanges)
```

### 2. Tumor Purity and Clonality Estimation
The package uses the relationship between BAF and Ratio to infer the most likely tumor content.
```r
# Calculate clonality and purity
# 'rbd.gt' is the input GRanges
clonality_res <- get_tumor_clonality(rbd.gt, 
                                     purity.min = 0.1, 
                                     purity.max = 1.0, 
                                     max.reps = 1)
```

### 3. Interpreting Results
The output of `get_tumor_clonality` contains:
- **Purity**: Estimated percentage of tumor cells in the sample.
- **Clonality**: The fraction of tumor cells harboring a specific mutation.
- **Adjacency**: A measure of how well the segments fit the predicted copy number model.

## Visualization

### The Bubble Plot
The signature plot represents segments as bubbles on a 2D plane (Ratio vs. BAF).
```r
# Generate the bubble plot
plot_obj <- draw_bubble(rbd.gt, purity = 0.8)
print(plot_obj)
```

### Genomic Tracks
To visualize alterations across the linear genome:
```r
# Create a track plot for a specific chromosome or the whole genome
track_plot(rbd.gt, s_name = "Sample_01")
```

## Tips for Success
- **Segmentation**: BubbleTree performs best on pre-segmented data. Ensure your segmentation (e.g., via CBS or Lasso) is robust before inputting into the package.
- **Filtering**: Remove segments with very few probes or high noise to improve the purity estimation accuracy.
- **Purity Range**: If the automated estimation fails, narrow the `purity.min` and `purity.max` parameters based on pathological estimates if available.
- **Multi-sample**: For longitudinal or multi-region studies, compare the "clonality" scores of the same segments across samples to track clonal evolution.

## Reference documentation
- [BubbleTree Bioconductor Page](https://bioconductor.org/packages/release/bioc/html/BubbleTree.html)