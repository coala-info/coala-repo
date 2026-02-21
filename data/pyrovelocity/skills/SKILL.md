---
name: pyrovelocity
description: Pyro-Velocity is a Bayesian generative framework designed to estimate the future states of cells while providing a rigorous measure of uncertainty.
homepage: https://github.com/pinellolab/pyrovelocity
---

# pyrovelocity

## Overview
Pyro-Velocity is a Bayesian generative framework designed to estimate the future states of cells while providing a rigorous measure of uncertainty. By modeling raw spliced and unspliced sequencing counts and estimating a synchronized cell time across all genes, it moves beyond deterministic velocity estimates. This tool is particularly useful for identifying branching points in cell differentiation where trajectory predictions may be less certain.

## Installation and Environment
The tool requires specific versions of PyTorch and Pyro. It is recommended to use a dedicated Conda environment.

```bash
# Recommended environment setup
mamba create -n pyrovelocity_release python==3.8.8
conda activate pyrovelocity_release
pip install pyro-ppl==1.6.0 scvelo scvi-tools==0.13.0 pytorch_lightning==1.3.0
pip install torch==1.8.1+cu111 -f https://download.pytorch.org/whl/torch_stable.html
pip install git+https://github.com/pinellolab/pyrovelocity.git
```

## Core Workflow

### 1. Data Preprocessing
Pyro-Velocity expects an `AnnData` object with `spliced` and `unspliced` layers. You must preserve raw counts before normalization.

```python
import scvelo as scv
import pyrovelocity as pv

adata = scv.read("data.h5ad")

# Preserve raw counts for the model
adata.layers['raw_spliced'] = adata.layers['spliced'].copy()
adata.layers['raw_unspliced'] = adata.layers['unspliced'].copy()

# Standard scVelo preprocessing for feature selection
scv.pp.filter_and_normalize(adata, min_shared_counts=30, n_top_genes=2000)
scv.pp.moments(adata, n_pcs=30, n_neighbors=30)
```

### 2. Model Training
The `train_model` function is the primary interface. There are two common configurations:

*   **Model 1 (Constraint-based):** Uses `guide_type='auto_t0_constraint'`. Good for standard developmental trajectories.
*   **Model 2 (Flexible):** Uses `guide_type='auto'` and `offset=True`. Better for complex datasets with varying kinetics.

```python
from pyrovelocity.api import train_model

# Training parameters
num_epochs = 4000 # Use ~1000 for large datasets, ~4000 for small
batch_size = 4000

adata_model_pos = train_model(
    adata,
    max_epochs=num_epochs,
    svi_train=True,
    batch_size=batch_size,
    use_gpu=0, # Set to GPU index if available
    model_type='auto',
    guide_type='auto_t0_constraint',
    train_size=1.0
)

# adata_model_pos[0] is the trained model
# adata_model_pos[1] contains posterior samples
```

### 3. Uncertainty Estimation and Visualization
The power of Pyro-Velocity lies in its ability to project vector field uncertainty onto embeddings (UMAP/t-SNE).

```python
from pyrovelocity.plot import vector_field_uncertainty, plot_vector_field_uncertain

# Calculate vector field uncertainty using Rayleigh test
v_map_all, embeds_radian, fdri = vector_field_uncertainty(
    adata, 
    adata_model_pos[1], 
    basis='umap', 
    n_jobs=16
)

# Plotting the uncertainty
import matplotlib.pyplot as plt
fig, ax = plt.subplots(1, 2, figsize=(12, 5))
plot_vector_field_uncertain(
    adata, 
    embed_mean, # Posterior mean of vector field
    embeds_radian, 
    ax=ax, 
    basis='umap'
)
```

## Best Practices
- **Library Size:** Ensure `library_size=True` is set in `train_model` to account for sequencing depth variation across cells.
- **GPU Usage:** For datasets exceeding 10,000 cells, always use `use_gpu=True` to keep training times manageable.
- **Persistence:** Always save the posterior samples (`adata_model_pos[1]`) using `pickle`, as re-generating them is computationally expensive.
- **Gene Selection:** While the model is multivariate, using the top 2,000 highly variable genes (HVGs) is typically sufficient for capturing the primary developmental signal.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_pinellolab_pyrovelocity.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_pyrovelocity_overview.md)