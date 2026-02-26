---
name: feems
description: "FEEMS infers and visualizes migration patterns and long-range gene flow from spatial population genetic data. Use when user asks to estimate effective migration surfaces, fit spatial graphs to genotype data, or perform admixture analysis using FEEMSmix."
homepage: https://github.com/NovembreLab/feems
---


# feems

## Overview

FEEMS (Fast Estimation of Effective Migration Surfaces) is a statistical framework designed to infer and visualize migration patterns from spatial population genetic data. It models the relationship between genetic covariance and geographic distance by fitting a migration surface on a spatial graph. The tool includes FEEMSmix, an extension that allows for the representation of long-range gene flow (admixture) on top of the estimated migration background. Use this skill to set up the environment, prepare spatial graphs, and execute migration surface fits.

## Installation and Environment Setup

Install FEEMS using conda/mamba via the Bioconda channel:

```bash
conda install -c bioconda feems -c conda-forge
```

For a dedicated environment with all dependencies (including plotting utilities like `cartopy` and `geos`):

```bash
conda create -n feems_e python=3.12
conda activate feems_e
conda install -c conda-forge geos scikit-sparse suitesparse cartopy
pip install git+https://github.com/NovembreLab/feems
```

## Core Workflow Patterns

### 1. Data Preparation
*   Ensure input files consist of genotype data (PLINK format) and sample locations (latitude/longitude).
*   Note: PLINK v2.0 format is currently untested; stick to PLINK v1.9 files (.bed, .bim, .fam).
*   Use the provided grid files (e.g., `grid_500.sh*`) for continental-scale analyses to maintain computational efficiency.

### 2. Model Fitting (FEEMS)
*   **Select Lambda ($\lambda$):** Always use a cross-validation procedure to estimate the appropriate regularization parameter $\lambda$. This prevents overfitting the migration surface.
*   **Node-Specific Parameters:** In version 2.0+, the default behavior fits node-specific variance parameters (proportional to heterozygosities). This improves model fit but increases runtime.
*   **Legacy Mode:** To revert to the original behavior (fixed node parameters), use:
    `sp_graph.fit(..., optimize_q=None)`

### 3. Admixture Analysis (FEEMSmix)
*   Run FEEMSmix only after an initial FEEMS fit has established the background migration surface.
*   Use FEEMSmix to identify specific long-range gene flow events that deviate from the continuous migration model.

### 4. Cluster Execution
For non-interactive environments or high-performance computing (HPC) clusters, use the `run.py` script provided in the repository. 
*   **Caution:** Be mindful of default flags in `run.py` as they automate several analysis steps.
*   Use this script when Jupyter notebooks are not feasible for long-running cross-validation tasks.

## Expert Tips and Best Practices

*   **Spatial Resolution:** If samples span a large geographic area, use a coarser grid resolution to reduce the number of parameters and speed up convergence.
*   **Visualization:** Use the deme-specific variance maps to identify areas of high or low effective population size ($N_e$), which are roughly proportional to the fitted variance values.
*   **Windows Compatibility:** FEEMS has dependencies that lack native Windows ports. Always run FEEMS in a Linux environment or via WSL (Windows Subsystem for Linux).
*   **Shapely Errors:** If encountering compatibility errors with `shapely` during installation, install it without binaries:
    `pip install shapely --no-binary shapely`

## Reference documentation
- [feems - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_feems_overview.md)
- [NovembreLab/feems: Fast Estimation of Effective Migration Surfaces](./references/github_com_NovembreLab_feems.md)