---
name: r-tinyarray
description: The tinyarray package streamlines bioinformatics workflows for analyzing and visualizing NCBI GEO and TCGA datasets. Use when user asks to download GEO data, perform differential expression analysis, process TCGA barcodes, conduct survival analysis, or generate standard bioinformatics plots like heatmaps and volcano plots.
homepage: https://cran.r-project.org/web/packages/tinyarray/index.html
---

# r-tinyarray

## Overview
The `tinyarray` package simplifies the workflow for bioinformatics data analysis, particularly for researchers working with NCBI GEO and TCGA datasets. It provides streamlined functions for data downloading, probe annotation, differential analysis using `limma`, and high-quality visualization.

## Installation
Install the stable version from CRAN:
```r
install.packages("tinyarray")
```

For the development version:
```r
devtools::install_github("xjsun1221/tinyarray")
```

## Core Workflows

### 1. GEO Data Analysis
The package provides a "one-stop" solution for GEO datasets:
- `geo_download(getGPL = T)`: Downloads expression matrix, clinical data, and platform info.
- `find_anno(GPL)`: Automatically identifies the correct annotation package for a platform.
- `get_deg()`: Performs differential analysis (limma wrapper) and returns results.
- `get_deg_all()`: Executes DEA and automatically generates standard plots (heatmap, volcano).

### 2. TCGA Data Processing
Functions designed for TCGA barcode formats:
- `make_tcga_group()`: Creates Group vectors (Tumor/Normal) based on sample barcodes.
- `sam_filter()`: Removes duplicate tumor samples to ensure one sample per patient.
- `match_exp_cl()`: Synchronizes expression matrices with clinical metadata.
- `trans_exp_new()`: Converts Ensembl IDs to Gene Symbols using recent Gencode versions.

### 3. Survival Analysis
- `point_cut()`: Calculates the optimal cutoff point for continuous gene expression.
- `surv_KM()`: Performs Kaplan-Meier analysis for multiple genes.
- `surv_cox()`: Performs batch univariate Cox regression.
- `exp_surv()`: A wrapper to draw KM plots for specific genes of interest.

### 4. Visualization
- `draw_heatmap()`: Creates complex heatmaps with group annotations.
- `draw_volcano()`: Generates volcano plots for DEA results.
- `draw_venn()`: Draws Venn diagrams for overlapping gene sets.
- `risk_plot()`: Creates a three-panel risk score plot (expression heatmap, scatter plot, and survival status).
- `box_surv()`: Combines a boxplot (T vs N) and a KM plot into a single figure.

## Utility Functions
- `intersect_all()` / `union_all()`: Handles intersections/unions across any number of vectors.
- `trans_array()`: Replaces matrix row names (e.g., probes to symbols).
- `double_enrich()`: Performs and plots enrichment analysis for up-regulated and down-regulated genes separately.

## Tips for Success
- **Group Factors**: Most functions require a `group_list` factor. Ensure the levels are set correctly (usually `control` then `treat`) for proper fold-change direction.
- **Gene Symbols**: When using `get_deg`, ensure the `ids` data frame has two columns: `probe_id` and `symbol`.
- **Batch Processing**: Use `t_choose()` for batch t-tests and `cor.full()` for batch correlation analysis between genes.

## Reference documentation
- [tinyarray README](./references/README.md)