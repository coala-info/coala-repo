---
name: magic-impute
description: MAGIC (Markov Affinity-based Graph Imputation of Cells) is a computational tool designed to recover the underlying structure of large-scale biological datasets.
homepage: https://github.com/KrishnaswamyLab/MAGIC
---

# magic-impute

## Overview

MAGIC (Markov Affinity-based Graph Imputation of Cells) is a computational tool designed to recover the underlying structure of large-scale biological datasets. In single-cell genomics, technical noise often results in "dropout" events where gene expression is incorrectly recorded as zero. MAGIC addresses this by building a cell-cell affinity graph and using data diffusion to smooth gene expression values across similar cells. This process restores gene-gene correlations and enables the identification of biological trends that are otherwise obscured by noise.

## Installation and Setup

MAGIC is available for Python, R, and MATLAB. The Python implementation is the most common for modern bioinformatics pipelines.

**Python (via pip or conda):**
```bash
pip install --user magic-impute
# OR
conda install -c bioconda magic-impute
```

**R (via CRAN):**
```R
install.packages("Rmagic")
# Note: Rmagic requires the python package 'magic-impute' to be installed on the system.
```

## Core Python Usage Pattern

The standard workflow involves initializing a MAGIC operator and applying it to a feature matrix (cells x genes).

```python
import magic
import pandas as pd

# Load your data (rows = cells, columns = genes)
df = pd.read_csv("expression_data.csv")

# Initialize the MAGIC operator
# Default parameters are usually sufficient for most scRNA-seq datasets
magic_op = magic.MAGIC()

# Run imputation
# You can impute all genes or a specific subset to save time/memory
df_imputed = magic_op.fit_transform(df, genes=['VIM', 'CDH1', 'ZEB1'])
```

## Best Practices and Expert Tips

### 1. Pre-processing Requirements
MAGIC expects data that has been filtered and normalized.
*   **Filtering:** Remove low-quality cells and genes with extremely low counts before running the algorithm.
*   **Normalization:** Perform library-size normalization (e.g., counts per 10,000) and log-transformation (log1p) prior to imputation.
*   **Input Format:** Ensure the input matrix has cells as rows and genes as columns.

### 2. Parameter Tuning
While the defaults are robust, two parameters significantly impact results:
*   **`t` (Diffusion Time):** Controls the amount of smoothing. A larger `t` results in more smoothing. If the output looks too "blob-like" or loses all heterogeneity, decrease `t`.
*   **`knn` (Number of Neighbors):** Defines the graph locality. Default is 5. Increase this for very large datasets to ensure a connected manifold.

### 3. Memory Management
For very large datasets (e.g., >50,000 cells), running MAGIC on the full genome can be memory-intensive.
*   Use the `genes` parameter in `fit_transform()` to only impute the specific markers or transcription factors relevant to your analysis.
*   The underlying graph is computed on the PCA of the data, so the manifold learning itself is efficient even if the output is restricted to a few genes.

### 4. Visualizing the Imputation Process
Use the built-in animation tool to verify that the diffusion process is uncovering expected biological structures without over-smoothing.

```python
# Visualize the transition of gene-gene relationships
magic.plot.animate_magic(df, gene_x='VIM', gene_y='CDH1', gene_color='ZEB1', operator=magic_op)
```

## Reference documentation
- [MAGIC Overview](./references/anaconda_org_channels_bioconda_packages_magic-impute_overview.md)
- [MAGIC GitHub Repository](./references/github_com_KrishnaswamyLab_MAGIC.md)