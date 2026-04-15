---
name: bioconductor-alps
description: ALPS is a Bioconductor package for the downstream analysis, quantification, and visualization of epigenomic data from bigwig and BED files. Use when user asks to quantify enrichments, perform exploratory data analysis, annotate peaks, or generate browser tracks and motif logos.
homepage: https://bioconductor.org/packages/3.10/bioc/html/ALPS.html
---

# bioconductor-alps

## Overview
ALPS (AnaLysis routines for ePigenomicS data) is a Bioconductor package designed for downstream analysis of epigenomic data. It primarily operates on bigwig files and BED files (peaks), allowing users to perform quantification, exploratory data analysis (EDA), and visualization without leaving the R environment. It integrates well with the ggplot2 ecosystem and other Bioconductor tools like ComplexHeatmap and ChIPseeker.

## Core Workflow

### 1. Data Preparation
Most ALPS functions require a sample data table (data.frame) containing metadata and file paths.
- `bw_path`: Full path to bigwig files.
- `bed_path`: Full path to BED files (required for consensus peak generation).
- `group`: Sample grouping for aggregate analysis.
- `sample_id`: Unique identifiers.

### 2. Quantifying Enrichments
Use `multiBigwig_summary` to calculate read counts/enrichments across genomic regions. It automatically generates a consensus peak set from the provided BED files.

```r
enrichments <- multiBigwig_summary(
  data_table = my_metadata,
  summary_type = "mean",
  parallel = FALSE
)
```

### 3. Exploratory Data Analysis
- **Variable Regions**: Extract the most variable regions for heatmaps using `get_variable_regions`.
- **Correlation**: Check replicate or group-level consistency with `plot_correlation`.
  - `plot_type = "replicate_level"`: Individual sample comparisons.
  - `plot_type = "group_level"`: Comparisons of group averages.

### 4. Visualization of Enrichments
Use `plot_enrichments` to create raincloud-style plots (combined box and violin plots).
- `plot_type = "separate"`: Standard group-wise comparison.
- `plot_type = "overlap"`: Paired conditions (e.g., treated vs. untreated) using an additional `sample_status` column in metadata.

### 5. Genomic Annotation
Annotate peaks using `get_genomic_annotations` (wrapper for ChIPseeker).
- `merge_level`: Set to "all", "group_level", or "none" to control how peaks are merged before annotation.
- `plot_genomic_annotations`: Visualize results as a "bar" or "heatmap".

### 6. Specialized Plots
- **Browser Tracks**: Generate UCSC-style tracks for specific loci using `plot_browser_tracks(data_table, gene_range = "chr:start-end", ref_gen = "hg38")`.
- **Motif Logos**: Visualize transcription factor binding motifs from MEME, JASPAR, or TRANSFAC files using `plot_motif_logo`. Supports `plot_type = "logo"` or `"bar"`.

## Tips for Success
- **Path Handling**: Ensure `bw_path` and `bed_path` in your data table are absolute paths or correctly relative to the working directory.
- **Log Transformation**: Most plotting functions (`plot_correlation`, `plot_enrichments`) include a `log_transform` argument; set this to `TRUE` for high-dynamic-range sequencing data.
- **Customization**: Most ALPS plotting functions return `ggplot2` objects, which can be further modified using standard `+ theme()` or `+ labs()` calls.

## Reference documentation
- [ALPS - AnaLysis routines for ePigenomicS data](./references/ALPS-vignette.md)
- [ALPS Vignette Source](./references/ALPS-vignette.Rmd)