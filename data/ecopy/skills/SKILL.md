---
name: ecopy
description: The ecopy library provides specialized tools for multivariate ecological data analysis and ordination. Use when user asks to transform site-by-species matrices, calculate dissimilarity measures, perform PCA or CCA, or conduct Bio-Env analysis.
homepage: https://github.com/Auerilas/ecopy
---


# ecopy

## Overview
The `ecopy` library provides a suite of tools tailored for community ecologists working with multivariate data. It simplifies the transition from raw field data to statistical insights by offering specialized functions for matrix transformations, dissimilarity calculations, and ordination. This skill helps users navigate the library's specific syntax for ecological workflows, ensuring data is correctly formatted and analyzed according to standard ecological practices.

## Installation and Setup
Install the package via Conda (Bioconda channel) or Pip:
```bash
conda install bioconda::ecopy
# OR
pip install ecopy
```

## Core Workflows

### 1. Data Loading and Transformation
Ecological datasets (site x species matrices) often require normalization before analysis to account for varying sampling efforts or dominant species.
- **Load Data**: Use `ep.load_data('dataset_name')` for built-in examples like 'varespec' or 'USArrests'.
- **Transformations**: Use `ep.transform()` to modify matrices.
  - `method='total'`: Divide by site totals (relative abundance).
  - `method='max'`: Divide by species maxima.
  - `method='pa'`: Convert to presence/absence (1/0).
  - **Note**: Set `axis=1` for site-based transformations or `axis=0` for species-based.

### 2. Calculating Dissimilarity Matrices
Distance matrices are the foundation for many ecological analyses.
- **Bray-Curtis**: The standard for abundance data. Use `ep.distance(matrix, method='bray')`.
- **Ochiai**: Useful for binary (presence/absence) data. Use `ep.distance(matrix, method='ochiai')`.
- **Euclidean**: Standard geometric distance, often used after specific transformations (e.g., Hellinger).

### 3. Ordination and Visualization
- **Principal Component Analysis (PCA)**:
  - Use `ep.pca(data, scale=True)` to run PCA. Scaling is recommended if species are measured in different units.
  - **Biplots**: Generate biplots directly from the PCA object:
    - `prcomp.biplot(type='distance')`: Focuses on site relationships.
    - `prcomp.biplot(type='correlation')`: Focuses on species correlations.
- **Canonical Correspondence Analysis (CCA)**: Use `ep.cca(site_species_matrix, environmental_matrix)` for constrained ordination.

## Expert Tips and Troubleshooting
- **Scipy Compatibility**: If you encounter errors regarding `scipy.misc.comb`, manually update the import in the source code to `from scipy.special import comb`, as newer Scipy versions moved this function.
- **Matrix Orientation**: Ensure your input is a standard site-by-species matrix (sites as rows, species as columns). Most `ecopy` functions expect this format by default.
- **Bio-Env Analysis**: Use `ep.bioenv()` to find the subset of environmental variables that best correlates with community dissimilarity.

## Reference documentation
- [EcoPy: Ecological Data Analysis in Python](./references/anaconda_org_channels_bioconda_packages_ecopy_overview.md)
- [Auerilas/ecopy: Python tools for ecological data analyses](./references/github_com_Auerilas_ecopy.md)