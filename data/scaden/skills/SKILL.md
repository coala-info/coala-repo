---
name: scaden
description: Scaden is a deep-learning framework used to estimate the cellular composition of bulk RNA-seq samples using single-cell RNA-seq data. Use when user asks to simulate artificial bulk samples, process gene expression data, train deconvolution models, or predict cell type proportions in bulk RNA-seq datasets.
homepage: https://github.com/KevinMenden/scaden
---


# scaden

## Overview

Scaden (Single-cell assisted deconvolutional network) is a deep-learning framework used to estimate the cellular composition of bulk RNA-seq samples. It addresses the limitations of traditional deconvolution by using an ensemble of deep neural networks trained on simulated bulk data derived from single-cell RNA-seq (scRNA-seq) datasets. This allows the model to learn complex, non-linear relationships between gene expression and cell type proportions.

The tool is particularly useful when you have access to scRNA-seq data for the tissue of interest and want to apply that knowledge to deconvolve large cohorts of bulk RNA-seq samples.

## Core Workflow

A standard Scaden deconvolution pipeline consists of four sequential steps.

### 1. Data Simulation
Generate artificial bulk samples with known cell type compositions from scRNA-seq data. You need a counts file and a corresponding cell types file.

```bash
# Generate 1000 simulated samples from scRNA-seq data
scaden simulate --data <sc_data_dir> -n 1000 --pattern "*_counts.txt"
```
*   **Output**: `data.h5ad` (containing simulated bulk samples).
*   **Tip**: Increasing the number of samples (`-n`) generally improves model robustness but increases training time.

### 2. Data Processing
Align the features (genes) between your training data and the target bulk RNA-seq data.

```bash
# Process simulated data against the target bulk expression file
scaden process data.h5ad <bulk_data.txt>
```
*   **Output**: `processed.h5ad`.
*   **Note**: This step ensures that only genes present in both datasets are used for training.

### 3. Training
Train the Scaden ensemble model on the processed data.

```bash
# Train for 5000 steps and save to a specific directory
scaden train processed.h5ad --steps 5000 --model_dir <model_output_path>
```
*   **Ensemble**: Scaden trains three different model architectures by default to improve prediction stability.
*   **Hardware**: Use a GPU if available by installing `tensorflow-gpu` to significantly speed up this step.

### 4. Prediction
Apply the trained model to your bulk RNA-seq samples to get cell type proportions.

```bash
# Predict cell compositions
scaden predict --model_dir <model_output_path> <bulk_data.txt>
```
*   **Output**: `scaden_predictions.txt`.

## Advanced Commands and Tips

### Dataset Management
*   **Merging**: If you have simulated datasets from different sources, use `scaden merge` to combine them before processing.
*   **Example Data**: Use `scaden example` to generate a toy dataset to verify your installation and workflow.
*   **Reproducibility**: Use the `--seed` parameter during simulation and training to ensure consistent results across runs.

### Performance Optimization
*   **Memory**: Scaden recommends at least 16 GB of RAM. For very large scRNA-seq datasets, simulation is performed one dataset at a time to minimize memory overhead.
*   **Format**: Always prefer `.h5ad` files over large text files for faster I/O performance.

### Troubleshooting
*   **Duplicate Genes**: Scaden automatically removes duplicate genes during the processing step.
*   **Missing Genes**: If the overlap between your scRNA-seq and bulk data is too small, deconvolution quality will drop. Ensure your scRNA-seq reference is comprehensive for the tissue type.



## Subcommands

| Command | Description |
|---------|-------------|
| predict | Predict cell type composition using a trained Scaden model |
| scaden process | Process a dataset for training |
| scaden simulate | Create artificial bulk RNA-seq data from scRNA-seq dataset(s) |
| scaden train | Train a Scaden model |
| scaden_example | Generate an example dataset |
| scaden_merge | Merge simulated datasets into on training dataset |

## Reference documentation
- [Scaden README](./references/github_com_KevinMenden_scaden_blob_master_README.md)
- [Scaden Changelog](./references/github_com_KevinMenden_scaden_blob_master_CHANGELOG.md)