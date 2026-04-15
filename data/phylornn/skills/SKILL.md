---
name: phylornn
description: PhyloRNN is a machine learning framework that uses recurrent neural networks to estimate evolutionary rates from phylogenetic data. Use when user asks to simulate synthetic alignments, train RNN models on phylogenetic data, or predict evolutionary rates for empirical sequences.
homepage: https://github.com/phyloRNN/phyloRNN
metadata:
  docker_image: "quay.io/biocontainers/phylornn:1.1--pyhdfd78af_0"
---

# phylornn

## Overview
PhyloRNN is a specialized machine learning framework that applies Recurrent Neural Networks to the problem of evolutionary rate estimation. By training on simulated phylogenetic data, the tool can predict rates for empirical alignments, offering a deep-learning alternative to traditional maximum likelihood or Bayesian inference methods. It is designed to handle both standard sequence data and specific integrations with the RevBayes environment.

## Installation
The most reliable way to install phylornn is via the Bioconda channel:

```bash
mamba install -c conda-forge -c bioconda phylornn
```

## Core Workflow and CLI Patterns

The phylornn package consists of several Python scripts that follow a standard machine learning pipeline: simulation, training, and prediction.

### 1. Data Simulation
Before training a model, you must generate synthetic data that mimics the evolutionary process you are studying.
*   **Script**: `simulate_data.py`
*   **Requirement**: Ensure `Seq-gen` and `PHYML` are installed and available in your system PATH, as the simulation engine relies on these external tools to generate alignments and reference trees.
*   **RevBayes Variant**: Use `simulate_train_data_revb.py` if you are preparing data specifically for a RevBayes-linked analysis.

### 2. Model Training
Once the training data is generated, use the training scripts to build the RNN model.
*   **Script**: `train_model.py`
*   **RevBayes Variant**: Use `train_model_revb.py` for models intended to work with RevBayes outputs.
*   **Tip**: Training deep learning models for phylogenetics is computationally intensive; ensure you have appropriate hardware (GPU) support configured in your Python environment if possible.

### 3. Rate Prediction
Apply your trained model to your target sequence alignments to estimate evolutionary rates.
*   **Script**: `run_predictions.py`
*   **RevBayes Variant**: Use `run_predictions_revb.py` for RevBayes-compatible prediction workflows.

### 4. Sequence Encoding
For tasks involving the transformation of raw sequence data into formats suitable for the RNN, the tool provides an autoencoder utility.
*   **Script**: `sequencoder.py`

## Expert Tips
*   **Dependency Management**: If you encounter errors during simulation, verify that `Seq-gen` and `PHYML` are correctly installed. These are not always bundled automatically and are critical for the simulation scripts.
*   **Data Consistency**: Ensure that the parameters used in `simulate_data.py` (such as sequence length and taxon count) match the characteristics of the empirical data you intend to analyze with `run_predictions.py`.
*   **Version Check**: As of version 1.1, the tool has improved support for RevBayes scripts. Always check the latest tags if you are working with complex Bayesian pipelines.

## Reference documentation
- [PhyloRNN Overview](./references/anaconda_org_channels_bioconda_packages_phylornn_overview.md)
- [PhyloRNN GitHub Repository](./references/github_com_phyloRNN_phyloRNN.md)
- [PhyloRNN Issues (Dependencies)](./references/github_com_phyloRNN_phyloRNN_issues.md)