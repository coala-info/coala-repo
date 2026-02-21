---
name: autogenes
description: The `autogenes` tool automates the selection of informative genes required for the deconvolution of bulk RNA-seq data.
homepage: https://github.com/theislab/AutoGeneS
---

# autogenes

---

## Overview
The `autogenes` tool automates the selection of informative genes required for the deconvolution of bulk RNA-seq data. It eliminates the need for manual marker gene curation by using a multi-objective optimization strategy. The tool identifies gene sets that simultaneously minimize correlation and maximize the distance between different cell types. This process results in a set of Pareto-optimal solutions, allowing researchers to choose the most appropriate gene signatures for their specific biological context.

## Installation and Setup
`autogenes` can be installed via Conda (recommended for bioinformatics workflows) or PyPI.

```bash
# Install via Bioconda
conda install bioconda::autogenes

# Install via PyPI
pip install autogenes
```

## Core Workflow and Best Practices

### 1. Data Preparation
`autogenes` is built to work with `anndata` objects. Ensure your reference data (single-cell or sorted cells) is formatted correctly.
- Input should be an `AnnData` object containing gene expression values.
- Cell type labels must be present in the metadata (usually `adata.obs`).

### 2. Initialization
The tool typically requires an initialization step to prepare the reference profile.
- Use `ag.init(adata)` to transfer relevant variable information.
- It is a best practice to filter for highly variable genes before running the optimization to reduce the search space and computational load.

### 3. Multi-Objective Optimization
The core functionality relies on the DEAP (Distributed Evolutionary Algorithms in Python) framework to find Pareto-optimal gene sets.
- **Objectives**: The algorithm optimizes for two conflicting goals:
    1. **Minimizing correlation** between cell type profiles.
    2. **Maximizing distance** between cell type profiles.
- **Pareto Solutions**: Because these objectives conflict, the tool provides a "Pareto front" of solutions. No single solution is "best"; you must select one based on the trade-off between the two objectives.

### 4. Deconvolution Methods
`autogenes` supports various deconvolution algorithms to validate or apply the selected genes, including:
- **NuSVR**: Support Vector Regression is a common choice for robust deconvolution.
- **Linear Regression**: For simpler, faster estimates.

## Expert Tips
- **Dense vs. Sparse**: Recent updates have improved compatibility with dense matrices in `AnnData` objects. If you encounter memory issues with large sparse matrices, consider converting the relevant subset to a dense format during the optimization phase.
- **Gene Filtering**: Always perform standard preprocessing (normalization, log transformation) on your reference data before using `autogenes`.
- **Solution Selection**: When picking a solution from the Pareto front, look for the "elbow" of the curve where you achieve a significant gain in one objective without a massive loss in the other.

## Reference documentation
- [autogenes - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_autogenes_overview.md)
- [GitHub - theislab/AutoGeneS](./references/github_com_theislab_AutoGeneS.md)