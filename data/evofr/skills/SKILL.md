---
name: evofr
description: evofr is a Python toolkit for estimating growth advantages and forecasting the future frequencies of genetic variants using genomic surveillance data. Use when user asks to estimate variant fitness, predict lineage frequencies, or fit multinomial logistic regression models to evolutionary data.
homepage: https://github.com/blab/evofr
---


# evofr

## Overview
`evofr` is a specialized Python toolkit developed for evolutionary forecasting of genetic variants. It provides researchers with the statistical machinery to estimate growth advantages (fitness) of different genetic lineages and predict their future frequencies based on genomic surveillance data. The tool streamlines the process of moving from raw variant counts to sophisticated probabilistic models that capture the dynamics of viral or bacterial evolution.

## Installation
The package can be installed via standard Python package managers:
- **Pip**: `pip install evofr`
- **Conda**: `conda install bioconda::evofr`

## Core CLI Workflow
The tool is primarily interacted with through a set of native command-line entry points that handle data processing and model fitting.

### 1. Data Preparation
The `prepare-data` command is used to preprocess raw variant data into a format compatible with the modeling engine.
```bash
evofr prepare-data [OPTIONS]
```
This command typically handles the aggregation of variant counts over specific time intervals and prepares the metadata required for hierarchical modeling.

### 2. Model Execution
The `run-model` command fits evolutionary models to the prepared data.
```bash
evofr run-model [OPTIONS]
```
**Key Model Types:**
- **innovationMLR**: A Multinomial Logistic Regression model designed to handle innovations in variant emergence.
- **Hierarchical MLR**: Supports complex population structures; includes a `dirichlet-multinomial` option to account for overdispersion in surveillance data.
- **HSGP**: Implements Hilbert Space Gaussian Process models for capturing non-linear evolutionary dynamics.
- **Latent Factor Models**: Used for identifying underlying drivers of variant fitness.

### 3. Exporting Results
- **Posterior Samples**: Use CLI arguments to save model posteriors as pickle files for detailed downstream Bayesian analysis.
- **Point Estimates**: The tool can export summaries using different point estimator functions (e.g., Mean or MAP estimates) as defined in the model configuration.

## Expert Tips and Best Practices
- **Handling Overdispersion**: When working with real-world genomic data which is often "noisier" than a standard multinomial distribution allows, prefer the `dirichlet-multinomial` option in hierarchical models to avoid overconfident fitness estimates.
- **Fitness Parameters**: When utilizing `RelativeFitnessDR` models, pay close attention to the `tau` parameter, which scales the fitness estimates relative to the generation time of the pathogen.
- **Forecast Horizons**: Ensure your input data has consistent date intervals. The tool can infer intervals for forecasting, but performance is most reliable when the input time-series is regular.
- **Optimization Errors**: If you encounter optimization errors with `innovationMLR`, check for extreme sparsity in the variant counts for specific time-bins, which can lead to instability during model fitting.

## Reference documentation
- [evofr GitHub Repository](./references/github_com_blab_evofr.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_evofr_overview.md)
- [CLI and Model Issues](./references/github_com_blab_evofr_issues.md)
- [Development Commits and CLI History](./references/github_com_blab_evofr_commits_main.md)