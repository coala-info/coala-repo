---
name: scater-scripts
description: scater-scripts provides a command-line interface for processing and analyzing single-cell RNA-seq data using the Scater R package. Use when user asks to load 10X Genomics data, calculate quality control metrics, filter cells, normalize counts, or perform dimensionality reduction and visualization.
homepage: https://github.com/ebi-gene-expression-group/bioconductor-scater-scripts
---

# scater-scripts

## Overview
The `scater-scripts` package provides a modular command-line interface for the Scater R package, specifically designed for single-cell RNA-seq (scRNA-seq) processing. It transforms complex R-based workflows into discrete, scriptable steps. This skill enables the execution of standard scRNA-seq pipelines—from loading 10X Genomics data to identifying outliers and generating dimensionality reduction plots—using standard shell commands.

## Core Workflow and Commands

### 1. Data Ingestion
Load 10X Genomics output directories into a SingleCellExperiment (SCE) object.
```bash
scater-read-10x-results.R -d <data_dir> -o <output.rds>
```

### 2. Quality Control (QC)
Calculate comprehensive QC metrics for cells and features.
```bash
scater-calculate-qc-metrics.R -i <input.rds> -o <output_qc.rds>
```
*   **Tip**: Use `-f` to provide a file containing feature controls (e.g., mitochondrial genes) to calculate specific percentages.

### 3. Filtering
Filter the dataset based on calculated QC metrics.
```bash
scater-filter.R -i <input_qc.rds> \
    -s "total_counts,total_features_by_counts" \
    -l "500,200" \
    -o <filtered.rds>
```
*   `-s`: Comma-separated cell QC metrics.
*   `-l`: Corresponding lower limits for those metrics.

### 4. Normalization
Normalize the filtered counts, typically converting them to log-transformed values.
```bash
scater-normalize.R -i <filtered.rds> -o <normalized.rds>
```

### 5. Dimensionality Reduction
Generate PCA or t-SNE coordinates for visualization.
```bash
# PCA
scater-run-pca.R -i <normalized.rds> -o <pca.rds>

# t-SNE
scater-run-tsne.R -i <normalized.rds> -o <tsne.rds>
```

### 6. Visualization
Create plots from reduced dimension results.
```bash
scater-plot-reduced-dim.R -i <pca.rds> --dimred "PCA" -o <pca_plot.png>
```

## Expert Tips and Best Practices

*   **Intermediate Persistence**: Always use the `.rds` format for intermediate files. This preserves the `SingleCellExperiment` object, including all metadata, assays, and reduced dimension slots.
*   **Outlier Detection**: Use `scater-extract-qc-metric.R` to pull specific metrics into a CSV for manual inspection or to feed into `scater-is-outlier.R` for automated MAD-based (Median Absolute Deviation) filtering.
*   **Memory Management**: Single-cell objects can be large. When running `scater-calculate-cpm.R`, use the `-t` flag to output a raw matrix only if necessary for downstream non-R tools, as this can be memory-intensive.
*   **Feature Controls**: When calculating QC metrics, identifying mitochondrial or spike-in genes is critical. Pass these as a text list to the `-f` parameter in `scater-calculate-qc-metrics.R`.



## Subcommands

| Command | Description |
|---------|-------------|
| /usr/local/bin/scater-extract-qc-metric.R | Extracts a specified quality control metric from a singleCellExperiment object and saves it to a file. |
| scater-calculate-qc-metrics.R | Calculate QC metrics for single-cell RNA-seq data. |
| scater-filter.R | Filters cells and features from a SingleCellExperiment object based on specified criteria. |
| scater-is-outlier.R | Detects outliers in a numeric QC metric for each cell. |
| scater-normalize.R | Normalizes expression values in a SingleCellExperiment object. |
| scater-run-pca.R | Performs Principal Component Analysis (PCA) on a SingleCellExperiment object. |
| scater-run-tsne.R | Performs t-SNE dimensionality reduction on a SingleCellExperiment object. |

## Reference documentation
- [Scater Scripts README](./references/github_com_ebi-gene-expression-group_bioconductor-scater-scripts_blob_develop_README.md)
- [Post-install Test Suite (Usage Examples)](./references/github_com_ebi-gene-expression-group_bioconductor-scater-scripts_blob_develop_bioconductor-scater-scripts-post-install-tests.bats.md)