---
name: flagx
description: FLAG-X is a Python toolbox that automates the end-to-end processing, machine learning-based gating, and visualization of flow cytometry data. Use when user asks to train classification models, perform automated gating on new samples, align channels, or generate dimensionality reduction visualizations like UMAP and t-SNE.
homepage: https://github.com/bionetslab/FLAG-X
metadata:
  docker_image: "quay.io/biocontainers/flagx:0.2.0--pyhdfd78af_0"
---

# flagx

## Overview
FLAG-X (FLow cytometry Automated Gating toolboX) is a specialized Python toolbox designed to automate the end-to-end processing of cytometry data. It bridges the gap between raw data acquisition and biological insight by providing a structured pipeline for data loading, channel alignment, preprocessing, and machine learning-based gating. Use this skill to execute command-line workflows for training classification models or performing inference on new samples to predict cell types and generate dimensionality reduction visualizations like UMAP or t-SNE.

## Installation and Environment Setup
To ensure all dependencies (including PyTorch for MLP functionality) are handled correctly, use the following configuration:

- **Conda Installation**: `conda install bioconda::flagx`
- **Channel Priority**: Ensure `strict` priority with `conda-forge` at the top, followed by `bioconda`.
- **Deep Learning Support**: If using the `MLPClassifier`, manually install the version of PyTorch that matches your hardware (CPU or specific CUDA version) after the initial flagx installation.

## Core CLI Workflows
FLAG-X operates primarily through two main command-line execution patterns. Both require a configuration file to define pipeline parameters.

### 1. Training Pipeline
Use this command to initialize a new gating pipeline, train a model (SOM or MLP), and save the state for future use.
- **Command**: `flagx init-train-save --config <path_to_config.yml>`
- **Key Actions**: Data loading, channel alignment, sample-wise preprocessing, and model training.

### 2. Inference Pipeline
Use this command to apply a previously trained model to new, unseen data.
- **Command**: `flagx load-infer-save --config <path_to_config.yml>`
- **Key Actions**: Automated gating (cell type prediction), dimensionality reduction (PCA, SOM, UMAP, t-SNE), and exporting annotated samples to FCS format.

## Expert Tips and Best Practices
- **Data Preparation**: Convert FCS or CSV files into the AnnData format internally for efficient handling. Ensure channel names are aligned across different samples to prevent feature mismatch during training.
- **Downsampling**: When working with massive datasets, utilize the sample-wise downsampling feature during the training phase to reduce computational load without losing population diversity.
- **Model Selection**:
    - **SOM (Self-Organizing Maps)**: Best for both supervised and unsupervised clustering and visualization.
    - **MLP (Multi-Layer Perceptron)**: Best for high-accuracy supervised classification when labeled training data is available.
- **Interoperability**: Always use the export feature to generate annotated FCS files if you need to perform final validation or manual inspection in standard tools like FlowJo or Cytobank.
- **GPU Acceleration**: For large-scale MLP training, ensure a CUDA-enabled build of PyTorch is installed; the default Bioconda environment may default to CPU-only.

## Reference documentation
- [FLAG-X Overview](./references/anaconda_org_channels_bioconda_packages_flagx_overview.md)
- [FLAG-X Repository and Usage](./references/github_com_bionetslab_FLAG-X.md)