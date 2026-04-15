---
name: mosaik
description: MOSAIKS transforms raw satellite imagery into feature matrices for use with linear models to predict ground-level observations. Use when user asks to extract features from satellite image tiles, create labels for ground-truth data, or train ridge regression models to predict variables like population density and income.
homepage: https://github.com/Global-Policy-Lab/mosaiks-paper
metadata:
  docker_image: "quay.io/biocontainers/mosaik:2.2.26--2"
---

# mosaik

## Overview

MOSAIKS is a generalizable and accessible approach to machine learning with satellite imagery. It transforms complex raw imagery into a set of "features" using random convolutional kernels, which can then be used with simple linear models to predict a wide variety of ground-level observations. This skill assists in navigating the MOSAIKS pipeline, from featurizing 256x256 RGB image tiles to training ridge regression models for tasks like predicting population density, income, or forest cover.

## Core Workflow

The MOSAIKS pipeline is organized into sequential stages. For a full replication of the paper's results, execute the master script:

```bash
bash run.sh
```

### 1. Configuration
Before running analysis, parameters must be set in the configuration files. These control the hyperparameters for both Python and R implementations.
- **Python**: `code/mosaiks/config.py`
- **R**: `code/mosaiks/config.R`

### 2. Feature Extraction
Transform raw satellite imagery into feature matrices.
- **Location**: `code/analysis/1_feature_extraction`
- **Input**: ~1x1km 256x256 pixel RGB images.
- **Grid Centroids**: Use the `.npz` grid files in `data/int/grids` to identify tile locations.
- **Helper Function**: Use `centroidstoSquareVertices(zoom=16, numPix=640)` to map centroids to exact grid cell boundaries.

### 3. Label Creation
Prepare the ground-truth data (labels) for the model to predict.
- **Location**: `code/analysis/2_label_creation`
- **Supported Labels**:
    - **Income/ACS**: Requires a US Census Bureau API key.
    - **Forest Cover**: Uses Global Land Analysis and Discovery Group data.
    - **Elevation**: Uses Mapzen elevation tiles.

### 4. Model Training and Analysis
Train the ridge regression model using the extracted features and created labels.
- **Location**: `code/analysis/`
- **Generalization**: To predict a new variable, modify the label creation script to point to your new data source and update the analysis notebook to load these new labels. The feature extraction step remains the same regardless of the task.

## Expert Tips

- **Memory Management**: Feature matrices can be large. If working with limited RAM, ensure you are using the pre-featurized images provided in `data/int/feature_matrices` when possible.
- **Image Specifications**: MOSAIKS is optimized for 3-channel (RGB) imagery. If using multi-spectral data, it must be pre-processed or the featurization code must be adjusted to handle additional channels.
- **Reproducibility**: All default settings in the `config` files are tuned to match the published Nature Communications results. Only modify these if you are conducting a new analysis or sensitivity test.

## Reference documentation
- [MOSAIKS Paper Repository README](./references/github_com_Global-Policy-Lab_mosaiks-paper.md)
- [Code Directory Structure](./references/github_com_Global-Policy-Lab_mosaiks-paper_tree_master_code.md)