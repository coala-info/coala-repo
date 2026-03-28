---
name: scvis
description: "scvis performs dimension reduction on high-dimensional biological data. Use when user asks to reduce dimensionality of scRNA-seq data or other high-dimensional biological datasets."
homepage: https://bitbucket.org/jerry00/scvis-dev/commits/all
---

# scvis

yaml
name: scvis
description: A Python package for dimension reduction of high-dimensional biological data, specifically single-cell RNA-sequencing (scRNA-seq) data. Use when Claude needs to perform dimensionality reduction on scRNA-seq datasets or other high-dimensional biological data.
```

## Overview
The `scvis` tool is a Python package designed for dimensionality reduction of complex biological datasets, with a particular focus on single-cell RNA-sequencing (scRNA-seq) data. It helps visualize and analyze the underlying structure of high-dimensional data by projecting it into a lower-dimensional space.

## Usage Instructions

`scvis` is primarily used as a Python library. While direct command-line execution might be possible for specific functions, the most common and flexible way to use it is within a Python script.

### Core Functionality: Dimensionality Reduction

The main purpose of `scvis` is to perform dimensionality reduction. This typically involves:

1.  **Loading Data**: Your high-dimensional data (e.g., gene expression counts for scRNA-seq) needs to be loaded into a suitable format, often a NumPy array or a Pandas DataFrame.
2.  **Model Initialization**: Instantiate a `scvis` model.
3.  **Training/Fitting**: Train the model on your data to learn the lower-dimensional representation.
4.  **Obtaining Embeddings**: Extract the resulting low-dimensional embeddings (e.g., 2D or 3D coordinates for visualization).

### Example Workflow (Conceptual Python Usage)

```python
import scvis
import numpy as np

# Assume 'high_dim_data' is your loaded data, e.g., a NumPy array
# Shape: (n_samples, n_features)
# Example: n_samples = number of cells, n_features = number of genes
high_dim_data = np.random.rand(1000, 5000) # Replace with your actual data

# Initialize the scvis model
# Refer to scvis documentation for available model types and parameters
# Example: model = scvis.SCVIS(n_components=2, ...)
model = scvis.SCVIS(n_components=2) # Example: reduce to 2 dimensions

# Train the model on your data
# This step might involve various parameters for optimization, epochs, etc.
model.fit(high_dim_data)

# Get the low-dimensional embeddings
# These are the coordinates for visualization
low_dim_embeddings = model.transform()

# 'low_dim_embeddings' can now be used for plotting (e.g., with matplotlib, seaborn)
print(f"Shape of embeddings: {low_dim_embeddings.shape}")
```

### Expert Tips

*   **Data Preprocessing**: Ensure your input data is appropriately preprocessed. For scRNA-seq, this often includes normalization, log-transformation, and feature selection (e.g., highly variable genes).
*   **Parameter Tuning**: Experiment with `scvis` model parameters (e.g., `n_components`, learning rates, regularization) to achieve optimal results for your specific dataset. Consult the official `scvis` documentation for a full list of configurable options.
*   **Visualization**: The output embeddings are typically used for creating scatter plots. Consider coloring points by known metadata (e.g., cell type, experimental condition) to reveal biological insights.
*   **Integration with other tools**: `scvis` is often used in conjunction with other bioinformatics tools and visualization libraries in Python.



## Subcommands

| Command | Description |
|---------|-------------|
| scvis | Learning a parametric mapping for high-dimensional single cell data or mapping high-dimensional single cell data to a low-dimensional space given a pretrained mapping |
| scvis train | Train a scVIS model. |
| scvis_map | Map new data to a pretrained scvis model. |

## Reference documentation
- [scvis Overview (Anaconda.org)](./references/anaconda_org_channels_bioconda_packages_scvis_overview.md)