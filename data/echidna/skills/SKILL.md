---
name: echidna
description: Echidna is a Bayesian framework that maps genotype to phenotype by integrating transcriptomic and genomic data to quantify how chromosomal alterations drive phenotypic plasticity. Use when user asks to infer gene dosage, track clonal evolution across longitudinal single-cell datasets, or integrate scRNA-seq and WGS data to analyze chromosomal amplifications and deletions.
homepage: https://github.com/azizilab/echidna
---


# echidna

## Overview
Echidna is a Bayesian framework designed to map genotype to phenotype by integrating transcriptomic and genomic data. It allows researchers to quantify how chromosomal alterations (amplifications and deletions) drive phenotypic plasticity. The tool is built on Pyro and PyTorch, supporting stochastic variational inference (SVI) to handle complex, high-dimensional single-cell datasets across longitudinal studies.

## Installation and Environment Setup
Echidna requires a specific Python environment and PyTorch configuration.

```bash
# Recommended environment setup
conda create -n "echidna-env" python=3.10
conda activate echidna-env

# Install via Bioconda (preferred for bioinformatics)
conda install bioconda::echidna

# Alternatively, install via PyPI
pip install sc-echidna
```

**Note**: Ensure the `torch` version matches your hardware (CPU vs. CUDA) by following instructions at pytorch.org before installing echidna.

## Data Configuration
Echidna expects input data (typically in AnnData format) to have specific metadata labels. Configure these in your script or environment before running the model:

| Setting | Default | Description |
|---------|---------|-------------|
| `timepoint_label` | "timepoint" | Column in `.obs` identifying the sample timepoint. |
| `counts_layer` | "counts" | The layer in the AnnData object containing raw counts. |
| `clusters` | "leiden" | Cell type or cluster annotations in `.obs`. |

## Training Best Practices
The model uses Stochastic Variational Inference (SVI). Use the following parameters to balance speed and accuracy:

- **Step Count**: Start with `n_steps=10000`.
- **Early Stopping**: Set `patience` > 0 (e.g., 30) to enable early stopping based on validation loss.
- **Learning Rate**: The default is `0.1` for the Adam optimizer; decrease this if the loss curve is unstable.
- **Device Selection**: The tool automatically detects CUDA. Force CPU usage if memory is an issue by setting `device="cpu"`.

## Model Hyperparameters and Tuning
Adjust these parameters based on the noise profile of your single-cell data:

- **Noisy Data**: Set `inverse_gamma=True` if your expression data has high technical noise.
- **Covariance Structure**: Increase `lkj_concentration` (> 1.0) to favor more diagonal covariance matrices, which can help with convergence in smaller datasets.
- **Correlation Scale**: `q_corr_init` (default 0.01) controls the initial scale of variational correlation.

## Standard Workflow
1. **Single Timepoint Analysis**: Prepare data, set hyperparameters, and perform posterior predictive checks to validate the model fit.
2. **Multi-Timepoint Integration**: Use paired scRNA-seq and WGS data collected over time to track clonal evolution and dosage shifts.
3. **Gene Dosage Inference**: Infer amplifications and deletions by gene clusters across the genome.
4. **Custom Modeling**: For experiments not covered by the standard API, interface directly with the underlying Pyro model (requires Pyro knowledge).

## Reference documentation
- [Echidna Overview - Anaconda](./references/anaconda_org_channels_bioconda_packages_echidna_overview.md)
- [Echidna GitHub Repository](./references/github_com_azizilab_echidna.md)