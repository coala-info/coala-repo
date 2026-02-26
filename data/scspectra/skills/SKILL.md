---
name: scspectra
description: scspectra decomposes single-cell gene expression matrices into biologically interpretable factors by incorporating prior knowledge from gene sets. Use when user asks to perform factor analysis on single-cell data, decompose gene expression into global or cell-type-specific programs, or link latent variables to known biological pathways.
homepage: https://github.com/dpeerlab/spectra
---


# scspectra

## Overview
scspectra (SPECTRA) is a factor analysis tool designed to decompose single-cell gene expression matrices into biologically interpretable programs. Unlike unsupervised methods like PCA or NMF, scspectra incorporates prior knowledge from gene sets (pathways) to guide the discovery of factors. It allows for the simultaneous estimation of "global" factors shared across all cells and "cell-type-specific" factors, providing a clearer link between latent variables and known biological mechanisms.

## Installation
Install the package via pip or conda:
```bash
pip install scSpectra
# OR
conda install bioconda::scspectra
```

## Core Workflow
The standard implementation involves preparing an AnnData object and a nested dictionary of gene sets.

### 1. Prepare Input Data
Ensure the `AnnData` object contains log-normalized counts (e.g., log1p transformed) and cell type annotations in `adata.obs`.
* **Leukocyte data**: Use scran normalization for better results.
* **Memory**: Ensure at least 12GB of RAM is available for standard datasets.

### 2. Define Gene Sets
The `gene_set_dictionary` must follow a specific structure:
- A "global" key for processes occurring across all cell types.
- Keys for each unique cell type matching `adata.obs[cell_type_key]`.
```python
# Example structure
gene_sets = {
    "global": {"pathway_1": ["GENE1", "GENE2"], "pathway_2": [...]},
    "T_cell": {"activation": ["GENE3", "GENE4"], ...},
    "B_cell": {...}
}
```

### 3. Estimate Number of Factors (L)
While `est_spectra` can default to the number of gene sets + 1, it is often better to estimate L from the data using bulk eigenvalue matching analysis.
```python
from Spectra import K_est as kst
L = kst.estimate_L(adata, attribute="cell_type_annotations", highly_variable=True)
```

### 4. Run the Model
Use `est_spectra` to fit the model. This is the primary entry point for most analyses.
```python
import Spectra
model = Spectra.est_spectra(
    adata=adata,
    gene_set_dictionary=gene_sets,
    cell_type_key="cell_type_annotations",
    use_highly_variable=True,
    lam=0.1,        # Weight of prior knowledge (try 0.001 to 0.5)
    delta=0.001,    # Lower bound for gene scaling
    rho=0.001,      # Background rate of non-edges
    use_weights=True,
    label_factors=True
)
```

## Accessing Results
The model populates the `AnnData` object with several key attributes:
* `adata.uns['SPECTRA_factors']`: Factor-to-gene weights (interpretability matrix).
* `adata.uns['SPECTRA_markers']`: Top `n_top_vals` genes per factor.
* `adata.obsm['SPECTRA_cell_scores']`: Activity of each factor per cell.
* `adata.var['spectra_vocab']`: Boolean mask of genes used in the model.

## Expert Tips and Best Practices
* **Parameter Tuning**: The `lam` parameter is critical. If the resulting factors are too similar to the input gene sets, decrease `lam`. If they ignore the gene sets, increase it.
* **Background Rates**: Setting `rho=None` or `kappa=None` allows the model to estimate background rates of non-edges and edges from the data, which can improve fit in complex datasets.
* **Gene Set Cleaning**: Set `clean_gs=True` and `min_gs_num=3` to automatically filter out gene sets that are too small or contain genes not present in the dataset.
* **Interpretability**: Use `model.return_eta_diag()` to check how much each factor was influenced by prior information. High values indicate strong alignment with the provided gene sets.
* **Small Datasets**: For small problems where memory is not a constraint, consider using `Spectra.SPECTRA_EM` for a more intensive Expectation-Maximization approach.

## Reference documentation
- [SPECTRA GitHub Repository](./references/github_com_dpeerlab_spectra.md)
- [Bioconda scspectra Overview](./references/anaconda_org_channels_bioconda_packages_scspectra_overview.md)