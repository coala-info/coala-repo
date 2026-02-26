---
name: scaden
description: Scaden is a deep-learning framework that estimates cell type proportions in bulk RNA-seq samples using single-cell RNA-seq data. Use when user asks to simulate artificial bulk samples, preprocess training data, train deconvolution models, or predict cell composition from bulk expression profiles.
homepage: https://github.com/KevinMenden/scaden
---


# scaden

## Overview

Scaden (Single-cell assisted deconvolutional network) is a deep-learning framework designed to estimate the proportions of different cell types within bulk RNA-seq samples. By leveraging single-cell RNA-seq (scRNA-seq) data to simulate artificial bulk samples with known compositions, Scaden trains an ensemble of neural networks that can then be applied to real bulk expression profiles. This skill provides the procedural knowledge to execute the four-step deconvolution workflow: data simulation, preprocessing, model training, and cell composition prediction.

## Core Workflow

### 1. Data Simulation
Generate artificial bulk samples from scRNA-seq data. This step creates the ground-truth training data.
```bash
scaden simulate --data <data_directory> -n 1000 --pattern "*_counts.txt"
```
*   **Note**: This produces a `data.h5ad` file.
*   **Tip**: Use a higher number of samples (e.g., 1000+) for better model generalization if hardware allows.

### 2. Data Processing
Prepare the simulated training data and the target bulk RNA-seq data for the neural network.
```bash
scaden process data.h5ad <bulk_data.txt>
```
*   **Output**: Generates `processed.h5ad`.
*   **Requirement**: The bulk data should be a tab-delimited text file with genes as rows and samples as columns.

### 3. Model Training
Train the Scaden model ensemble on the processed data.
```bash
scaden train processed.h5ad --steps 5000 --model_dir <model_output_directory>
```
*   **Steps**: 5000 steps per model is the standard recommendation.
*   **Hardware**: If a GPU is available, ensure `tensorflow-gpu` is installed to significantly reduce training time.

### 4. Prediction
Apply the trained model to your bulk RNA-seq samples to estimate cell type compositions.
```bash
scaden predict --model_dir <model_output_directory> <bulk_data.txt>
```
*   **Output**: Results are saved to `scaden_predictions.txt`.

## Expert Tips and Best Practices

*   **Memory Management**: Scaden recommends at least 16 GB of RAM, especially during the simulation and processing of large scRNA-seq datasets.
*   **Input Formats**: While text files are supported, using `.h5ad` (AnnData) format for input data is more efficient for large-scale single-cell datasets.
*   **Example Data**: To verify an installation or test the environment, use `scaden example --out <directory>` to generate a small synthetic dataset.
*   **Cell Type Naming**: Ensure cell type names in your reference data do not consist solely of numbers; adding a text prefix (e.g., "Type1" instead of "1") prevents potential indexing errors during simulation.
*   **GPU Usage**: Scaden automatically detects and uses a GPU if `tensorflow-gpu` is installed and configured in the environment.

## Reference documentation
- [Scaden GitHub Repository](./references/github_com_KevinMenden_scaden.md)
- [Scaden Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_scaden_overview.md)