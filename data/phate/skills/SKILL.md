---
name: phate
description: PHATE (Potential of Heat-diffusion for Affinity-based Transition Embedding) is a dimensionality reduction and visualization method designed to capture the underlying structure of complex, high-dimensional data.
homepage: https://github.com/KrishnaswamyLab/PHATE
---

# phate

## Overview

PHATE (Potential of Heat-diffusion for Affinity-based Transition Embedding) is a dimensionality reduction and visualization method designed to capture the underlying structure of complex, high-dimensional data. Unlike t-SNE or UMAP, which often prioritize local clusters at the expense of global relationships, PHATE uses heat diffusion to learn the manifold. This makes it particularly effective for visualizing continuous transitions, branching trajectories, and global data geometry in biological systems.

## Installation

PHATE is available for Python, R, and MATLAB.

### Python
Install via pip or conda:
```bash
pip install --user phate
# OR
conda install -c bioconda phate
```

### R
PHATE in R requires the Python package to be installed first.
```R
install.packages("phateR")
```

## Usage Patterns

### Python API
PHATE integrates with the Scikit-Learn API and supports `numpy.array`, `scipy.spmatrix`, `pandas.DataFrame`, and `anndata.AnnData`.

```python
import phate

# Initialize the operator
# n_components: Number of dimensions (usually 2 or 3)
# knn: Number of nearest neighbors
# t: Diffusion time (auto-selected if 'auto')
# n_jobs: Number of processors to use
phate_op = phate.PHATE(n_components=2, knn=5, t='auto', n_jobs=-1)

# Fit and transform the data
# Input: (n_samples, n_features)
data_phate = phate_op.fit_transform(data)
```

### R API
The R implementation (`phateR`) accepts matrices, data frames, and sparse matrices.

```R
library(phateR)

# Run PHATE
data_phate <- phate(data, knn = 5, t = "auto", n_jobs = -1)

# Plotting
plot(data_phate)
```

## Expert Tips and Best Practices

### Parameter Tuning
- **Diffusion Time (t)**: This is the most critical parameter. It determines the scale of the structure preserved. A small `t` preserves local structure (similar to t-SNE), while a large `t` emphasizes global structure. Use `t='auto'` as a starting point, but manually increase it if the visualization appears too "noisy" or decrease it if the data looks too "collapsed."
- **K-Nearest Neighbors (knn)**: Controls the local neighborhood size. For very large datasets, increasing `knn` can help smooth the manifold.
- **Decay**: Controls the rate of alpha-decay for the kernel. Lower values can help in capturing finer details in the local structure.

### Data Preprocessing
- **Normalization**: Always normalize your data (e.g., library size normalization for scRNA-seq) before running PHATE.
- **Transformation**: For biological data, a square root or log transformation is recommended to stabilize variance.
- **Dimensionality Reduction**: For extremely high-dimensional data (e.g., >50,000 genes), it is common practice to run PCA first (e.g., to 50-100 components) and then pass the PCA matrix to PHATE to reduce noise and computation time.

### Handling Large Datasets
- **Landmarking**: PHATE uses a landmarking approach to scale to millions of cells. If memory is an issue, ensure the `n_landmarks` parameter is set appropriately (default is 2000).
- **Sparse Matrices**: Use `scipy.sparse` matrices in Python to significantly reduce memory overhead when working with sparse genomic data.

## Reference documentation
- [PHATE GitHub Repository](./references/github_com_KrishnaswamyLab_PHATE.md)
- [Bioconda PHATE Overview](./references/anaconda_org_channels_bioconda_packages_phate_overview.md)