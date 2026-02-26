---
name: scprep
description: scprep is a Python framework for preprocessing single-cell data using standard data structures like Pandas and SciPy. Use when user asks to load 10X Genomics data, filter cells by library size or mitochondrial expression, and normalize or transform gene expression matrices.
homepage: https://github.com/KrishnaswamyLab/scprep
---


# scprep

## Overview

scprep (Single-Cell Preparation) is a specialized Python framework designed to streamline the transition from raw biological matrices to analysis-ready data. Its core philosophy is data-agnosticism; it avoids complex, bespoke class objects in favor of standard Python data structures. This ensures that your preprocessing pipeline remains compatible with the broader scientific ecosystem (e.g., scikit-learn, matplotlib). Use this skill to implement robust quality control workflows, including mitochondrial gene filtering and library size normalization, without the overhead of heavy genomic suites.

## Core Workflow

### 1. Data Loading
Load 10X Genomics data or other matrix formats directly into a format compatible with Pandas or SciPy.
```python
import scprep
# Load 10X data from a directory
data = scprep.io.load_10X("~/path/to/data")
```

### 2. Quality Control and Filtering
Clean the dataset by removing uninformative rows/columns and filtering based on biological metrics.

*   **Remove Empty Features:** Always start by removing cells and genes with zero expression.
    ```python
    data = scprep.filter.remove_empty_cells(data)
    data = scprep.filter.remove_empty_genes(data)
    ```
*   **Library Size Filtering:** Identify and remove cells with abnormally low or high read counts.
    ```python
    # Visualize first to determine cutoff
    scprep.plot.plot_library_size(data, cutoff=500)
    # Apply filter
    data = scprep.filter.filter_library_size(data, cutoff=500)
    ```
*   **Mitochondrial Filtering:** Remove dying cells by filtering for high mitochondrial gene expression.
    ```python
    # Identify MT genes (usually start with 'MT-' in human or 'mt-' in mouse)
    mt_genes = scprep.select.get_gene_set(data, starts_with="MT")
    # Plot and filter
    scprep.plot.plot_gene_set_expression(data, genes=mt_genes, percentile=90)
    data = scprep.filter.filter_gene_set_expression(data, genes=mt_genes, percentile=90)
    ```

### 3. Normalization and Transformation
Prepare the data for downstream analysis by accounting for technical variance.

*   **Library Size Normalization:** Scales each cell so the total counts are equal.
    ```python
    data = scprep.normalize.library_size_normalize(data)
    ```
*   **Data Transformation:** Apply a square root or log transform to stabilize variance.
    ```python
    data = scprep.transform.sqrt(data)
    ```

## Expert Tips

*   **Data Agnosticism:** Because scprep works on standard matrices, you can use `data.index` (for cell names) and `data.columns` (for gene names) directly if your data is in a Pandas DataFrame.
*   **Sparse Matrix Support:** scprep is optimized for SciPy sparse matrices. If memory is an issue, ensure your data is loaded or converted to a sparse format (`scipy.sparse.csr_matrix`).
*   **Visualization Defaults:** scprep plotting functions are built on Matplotlib and provide sensible defaults for single-cell data, such as `plot_gene_set_expression`, which is useful for identifying specific cell populations or quality issues.

## Reference documentation
- [scprep GitHub Repository](./references/github_com_KrishnaswamyLab_scprep.md)
- [scprep Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_scprep_overview.md)