---
name: scanorama
description: Scanorama is a tool designed for the "panoramic stitching" of single-cell transcriptomes.
homepage: https://github.com/brianhie/scanorama/
---

# scanorama

## Overview

Scanorama is a tool designed for the "panoramic stitching" of single-cell transcriptomes. It is particularly effective at integrating datasets that are highly heterogeneous, such as those coming from different technologies, laboratories, or biological conditions. By identifying mutual nearest neighbors across datasets, Scanorama aligns cells into a shared space while preserving biological variation. Use this skill to perform batch correction, merge gene lists across disparate datasets, and prepare integrated data for downstream tasks like clustering and visualization.

## Installation

Scanorama can be installed via pip or conda:

```bash
# Via pip
pip install scanorama

# Via bioconda
conda install bioconda::scanorama
```

## Core Python API Usage

Scanorama is primarily used as a Python library. It expects data as a list of matrices (cells-by-genes) and a corresponding list of gene names.

### Base Integration and Correction

Use `integrate()` to find low-dimensional embeddings and `correct()` to obtain batch-corrected expression matrices.

```python
import scanorama

# datasets: list of scipy.sparse.csr_matrix or numpy.ndarray
# genes_list: list of list of strings (gene names for each dataset)

# 1. Integration (returns low-dimensional embeddings)
integrated, genes = scanorama.integrate(datasets, genes_list)

# 2. Batch Correction (returns corrected expression matrices)
corrected, genes = scanorama.correct(datasets, genes_list)

# 3. Combined (returns both embeddings and corrected matrices)
integrated, corrected, genes = scanorama.correct(datasets, genes_list, return_dimred=True)
```

### Scanpy Integration

If working with `AnnData` objects, Scanorama provides wrappers that integrate directly with the Scanpy ecosystem.

```python
import scanorama

# adatas: list of scanpy.AnnData objects

# Integration: Adds 'X_scanorama' to each adata.obsm
scanorama.integrate_scanpy(adatas)

# Correction: Returns a list of new AnnData objects with corrected .X
corrected_adatas = scanorama.correct_scanpy(adatas, return_dimred=True)
```

## Data Processing CLI

Scanorama includes a utility script `bin/process.py` for converting raw data into the `.npz` format used by its internal examples.

```bash
# Process tab-delimited tables (genes as rows, cells as columns)
python bin/process.py data/my_dataset.txt

# Process 10X Genomics sparse matrix directories (containing matrix.mtx and genes.tsv)
python bin/process.py data/10x_directory/
```

## Best Practices and Expert Tips

- **Upstream Processing**: Scanorama should be used downstream of noise-reduction steps. Ensure your data has undergone imputation and highly-variable gene (HVG) filtering before integration for the best results.
- **Memory Management**: For large-scale datasets, always prefer `scipy.sparse.csr_matrix` over dense numpy arrays. If using R via `reticulate`, be aware that `return_dense=True` is often required but significantly increases memory consumption.
- **Gene Matching**: Scanorama automatically finds the intersection of genes across all provided datasets. Ensure your `genes_list` uses consistent nomenclature (e.g., all Gene Symbols or all Ensembl IDs).
- **Downstream Analysis**: The embeddings produced by `integrate_scanpy` (stored in `X_scanorama`) are optimized for KNN graph construction. Use them as input for `sc.pp.neighbors(adata, use_rep='X_scanorama')` in Scanpy.
- **Acceleration**: For extremely large datasets, consider using data sketching (e.g., geometric sketching) to summarize the landscape before running Scanorama to significantly reduce computation time.

## Reference documentation

- [Scanorama GitHub Repository](./references/github_com_brianhie_scanorama.md)
- [Bioconda Scanorama Package Overview](./references/anaconda_org_channels_bioconda_packages_scanorama_overview.md)