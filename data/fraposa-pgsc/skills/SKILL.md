---
name: fraposa-pgsc
description: The fraposa-pgsc tool projects study samples onto a reference PCA space to predict genetic ancestry while correcting for shrinkage using the OADP algorithm. Use when user asks to project samples onto a reference panel, predict ancestry labels, or visualize population clusters in PCA space.
homepage: https://github.com/PGScatalog/fraposa_pgsc
---

# fraposa-pgsc

## Overview

The `fraposa-pgsc` tool implements the Fast and Robust Ancestry Prediction (FRAPOSA) method. It allows you to project "study" samples onto a pre-calculated PCA space derived from a "reference" panel. This is critical in genomics to account for population stratification. The tool is optimized for speed and accuracy using the Online Augmentation, Decomposition, and Procrustes (OADP) algorithm, which addresses the "shrinkage" problem where projected samples appear closer to the PCA origin than they should. Use this skill to prepare datasets, execute projections, predict ancestry labels, and generate diagnostic plots.

## Core CLI Usage

### 1. Data Preparation
Reference and study datasets must share the exact same variants.
*   **Requirement**: The `.bim` files for both sets must be identical in terms of variant IDs and allele orientation.
*   **Manual Intersection**: Use PLINK to extract common variants before running FRAPOSA.

### 2. Running PCA and Projection
The primary command projects study samples onto the reference space.

```bash
# Basic projection using default OADP method
fraposa --stu_filepref study_prefix reference_prefix
```

**Key Arguments:**
*   `--method`: Defaults to `oadp` (recommended). Use `sp` for standard projection (faster but less accurate) or `adp`.
*   `--dim_ref`: Number of reference PCs to calculate (default is often sufficient).
*   `--out`: Custom prefix for output files (defaults to study prefix).

### 3. Ancestry Prediction
Once PC scores are generated, predict the population membership of study samples. This requires a reference population file (`reference_prefix.popu`).

```bash
# Predict ancestry labels
fraposa_pred study_prefix
```
*   **Input**: Requires `{study_prefix}.pcs` (from the previous step) and `{reference_prefix}.popu`.
*   **Output**: Generates `{study_prefix}.popu` containing predicted labels.

### 4. Visualization
Generate a 2D plot of the first two Principal Components to visually inspect ancestry clusters.

```bash
# Generate PC plot
fraposa_plot study_prefix
```
*   **Output**: A PNG file showing study samples overlaid on the reference clusters.

## Expert Tips and Best Practices

### Memory Management for Large Datasets
FRAPOSA loads study samples into memory. If you encounter memory errors with large cohorts (e.g., UK Biobank):
1.  **Split the study samples**: Use the `split` command on the `.fam` file to create smaller batches of IIDs.
2.  **Filter by IID**: Use the `--stu_filt_iid` flag to process one batch at a time.
3.  **Parallelize**: Run multiple `fraposa` instances in parallel for different IID batches using the same reference.

### Handling Intermediate Files
The tool produces `*.dat` files. These are binary caches of the genotype data.
*   Keep these if you plan to re-run projections with different parameters to save time on data loading.
*   Delete them if disk space is a concern after the final `.pcs` files are generated.

### Method Selection
*   **OADP (Default)**: Always use this for final analysis. It provides the most robust results by correcting for the shrinkage of PC scores in projected samples.
*   **SP**: Only use for quick exploratory looks where high precision isn't required.



## Subcommands

| Command | Description |
|---------|-------------|
| fraposa | Performs Principal Component Analysis (PCA) prediction using reference and study samples. |
| fraposa_plot | Plots the results of FRA-POSA. |
| fraposa_pred | Predicts the genetic risk score for a study population based on a reference population. |

## Reference documentation
- [FRAPOSA_PGSC README](./references/github_com_PGScatalog_fraposa_pgsc_blob_master_README.md)
- [Tool Overview and Requirements](./references/github_com_PGScatalog_fraposa_pgsc.md)