---
name: flexynesis
description: Flexynesis is a deep learning suite designed to integrate multi-omics data for predicting clinical outcomes through various neural network architectures. Use when user asks to integrate multiple types of biological data, predict clinical outcomes such as survival or classification, implement specialized architectures like supervised VAEs or GNNs, and perform automated feature selection or model interpretation.
homepage: https://github.com/BIMSBbioinfo/flexynesis
metadata:
  docker_image: "quay.io/biocontainers/flexynesis:1.1.7--pyhdfd78af_0"
---

# flexynesis

## Overview
Flexynesis is a specialized deep learning suite designed to integrate multiple types of omics data (e.g., RNA-seq, proteomics, methylation) to predict (pre-)clinical outcomes. It transforms complex, high-dimensional biological data into actionable predictions for regression, classification, and survival tasks. You should use this skill to guide the selection of neural architectures—ranging from simple fully connected networks to advanced supervised variational autoencoders (VAEs) and graph convolutional networks (GNNs)—and to implement workflows for automated feature selection and hyperparameter optimization.

## Installation and Setup
Flexynesis requires Python 3.11 or higher. It can be installed via PyPI or Conda:

```bash
# Via pip
pip install flexynesis

# Via conda
conda install bioconda::flexynesis
```

## Core Functional Components
When using Flexynesis, focus on these primary modeling approaches:
- **Supervised VAEs**: Best for dimensionality reduction that preserves label-relevant information.
- **Multi-triplet Models**: Useful for learning embeddings that cluster similar biological samples together.
- **Graph Convolutional Networks (GNNs)**: Ideal when you have prior knowledge of biological networks (e.g., protein-protein interactions) to guide the learning process.
- **Inference Mode**: Use `DataImporterInference` to apply trained models to new datasets, ensuring consistent feature scaling and handling of missing covariates.

## Expert Tips and Best Practices
- **Interpretability**: Always leverage the integrated gradients (via the Captum library) included in the suite to identify which omics features (markers) are driving the model's predictions.
- **GPU Acceleration**: If working on macOS, Flexynesis supports Apple Silicon (MPS) for GPU-accelerated training. Ensure your environment is configured to utilize `device='mps'`.
- **Data Handling**:
    - Use the built-in automated feature selection to reduce noise before training complex models.
    - When dealing with missing values in labels, ensure you use the latest version (v1.1.7+) which includes improved handling for NA values.
- **Model Selection**: Start with a Fully Connected Network (FCN) as a baseline before moving to more complex architectures like GNNs or VAEs.

## Reference documentation
- [Flexynesis GitHub Repository](./references/github_com_BIMSBbioinfo_flexynesis.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_flexynesis_overview.md)
- [Flexynesis Discussions and New Features](./references/github_com_BIMSBbioinfo_flexynesis_discussions.md)