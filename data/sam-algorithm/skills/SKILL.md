---
name: sam-algorithm
description: The Self-Assembling-Manifold algorithm identifies topologically significant features to reconstruct the manifold of cellular states in single-cell transcriptomics data. Use when user asks to analyze scRNA-seq data, perform manifold learning, visualize cellular states, or apply batch correction using the samalg package.
homepage: https://github.com/atarashansky/self-assembling-manifold
---


# sam-algorithm

## Overview
The Self-Assembling-Manifold (SAM) algorithm is a specialized tool for single-cell transcriptomics that identifies topologically significant features to reconstruct the underlying manifold of cellular states. Unlike standard linear methods, SAM excels at capturing complex, non-linear relationships in high-dimensional scRNA-seq data. This skill provides the procedural knowledge to load data, preprocess it, execute the manifold learning process, and visualize results using the `samalg` Python package.

## Installation and Setup
Install the algorithm via Bioconda or PIP:

```bash
# Via Conda
conda install bioconda::sam-algorithm

# Via PIP
pip install sc-sam
```

For interactive visualization, ensure `matplotlib` and `plotly` are installed.

## Core Workflow Patterns

### Standard Analysis Pipeline
The most common workflow involves initializing the SAM object with a count matrix, preprocessing, and running the manifold assembly.

```python
from samalg import SAM

# Initialize with a DataFrame (cells x genes) or AnnData object
sam = SAM(counts=data_source)

# Preprocess: log-transforms and filters the data
sam.preprocess_data()

# Run the algorithm with default parameters
sam.run()

# Generate a scatter plot of the manifold
sam.scatter()
```

### Data Loading Strategies
SAM supports multiple input formats. Use the `load_data` method for tabular files to benefit from automatic sparse matrix conversion.

*   **Tabular Files (CSV/TXT):** `sam.load_data('data.csv')`
*   **AnnData (h5ad):** `sam.load_data('data.h5ad')`
*   **Note:** When loading CSVs, SAM automatically saves a `.h5ad` file in the same directory for significantly faster loading in future sessions.

### Batch Correction
SAM integrates with Harmony for batch effect removal. This is essential when merging datasets from different experiments or sequencing runs.

```python
# Assuming 'batch_labels' is a list or array of batch identifiers
sam.run(batch_key=batch_labels)
```

## Expert Tips and Best Practices

*   **Memory Efficiency:** For very large datasets, always prefer loading from `.h5ad` files or passing `scipy.sparse` matrices to the constructor to minimize memory overhead.
*   **Parameter Tuning:** While `sam.run()` uses robust defaults, you can adjust the `weight_mode` (e.g., 'combined') if the default manifold reconstruction does not capture expected biological variance.
*   **Interactive Exploration:** If working in a Jupyter environment, use the `SAMGUI` module for dynamic data exploration:
    ```python
    from samalg.gui import SAMGUI
    sam_gui = SAMGUI(sam)
    sam_gui.SamPlot
    ```
*   **Data Orientation:** Ensure your input matrix is oriented correctly. By default, SAM expects cells as rows and genes as columns. If your data is transposed, use the `transpose=True` argument in `load_data`.
*   **Saving Progress:** Save the processed manifold and metadata by exporting the underlying AnnData object: `sam.save_anndata('output.h5ad')`.

## Reference documentation
- [sam-algorithm - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_sam-algorithm_overview.md)
- [The Self-Assembling-Manifold (SAM) algorithm - GitHub](./references/github_com_atarashansky_self-assembling-manifold.md)