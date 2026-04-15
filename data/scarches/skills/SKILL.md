---
name: scarches
description: scArches is a deep learning tool for integrating single-cell datasets by mapping query data onto pre-trained reference atlases. Use when user asks to map query datasets to a reference, perform automated cell-type annotation, or integrate new scRNA-seq data while preserving a reference latent space.
homepage: https://github.com/theislab/scarches
metadata:
  docker_image: "quay.io/biocontainers/scarches:0.6.1--pyh7e72e81_0"
---

# scarches

## Overview
scArches (Single-cell Architecture Surgery) is a deep learning strategy for the decentralized integration of single-cell data. It allows users to map query datasets onto a pre-trained reference atlas by adding and training only a small set of query-specific parameters (the "surgery"). This approach preserves the reference latent space, enables fast mapping of new data, and facilitates automated cell-type annotation and batch effect correction. Use this skill when you need to leverage large-scale reference maps (like the Human Cell Atlas) to interpret smaller, private, or newly generated scRNA-seq datasets.

## Installation and Environment
The package is primarily distributed via Bioconda and PyPI. For stability in bioinformatics workflows, Python 3.10 is the recommended version.

```bash
# Installation via Conda
conda install -c bioconda scarches

# Installation via Pip
pip install scarches
```

## Core Workflow Patterns
scArches is typically used as a Python library. The general workflow involves loading a reference model, preparing the query AnnData object, and performing the surgery.

### 1. Model Selection
Choose the model architecture based on the task:
- **scPoli**: Best for multi-sample integration and large-scale label transfer.
- **scANVI**: Ideal for semi-supervised cell-type annotation when some query labels are missing.
- **trVAE**: Used for batch correction and data translation across different conditions.
- **expiMap**: Useful for incorporating biological priors (gene sets) into the integration.

### 2. Reference Mapping (Surgery)
The "surgery" step involves loading a pre-trained model and adapting it to the query data's batch/condition.

```python
import scarches as sca
import scanpy as sc

# Load query data (AnnData object)
query_adata = sc.read("query_data.h5ad")

# Load the reference model and perform surgery
# Example using scPoli
model = sca.models.scPoli.load_query_data(
    adata=query_adata,
    reference_model="path/to/reference_model/",
    transformation_batch="batch_column_name"
)

# Train only the query-specific parameters
model.train(n_epochs=100)
```

### 3. Latent Space and Label Transfer
After training, project the query into the reference latent space to visualize integration or transfer annotations.

```python
# Get latent representation
latent_query = model.get_latent(query_adata)

# Transfer labels (if using a model with a classifier like scPoli or scANVI)
preds = model.predict(query_adata)
query_adata.obs['predicted_cell_type'] = preds
```

## Expert Tips and Best Practices
- **Gene Matching**: The query dataset must be subsetted to the exact same genes used in the reference model before performing surgery. Use `adata = adata[:, reference_genes].copy()`.
- **Normalization**: Ensure the query data is normalized in the same way as the reference (e.g., log-normalization or raw counts depending on the specific model requirements).
- **GPU Acceleration**: scArches models are built on PyTorch. Always use a GPU for training (`use_gpu=True`) to avoid significant performance bottlenecks.
- **Unlabeled Cells**: When using scANVI for label transfer, ensure that unknown or new cell types in the query are marked appropriately (e.g., as "Unknown") so the model doesn't force-map them to incorrect reference categories.
- **Batch Keys**: The `condition_key` or `batch_key` used during query training should represent the technical variation you wish to remove (e.g., "sample_id" or "sequencing_run").

## Reference documentation
- [scarches - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_scarches_overview.md)
- [theislab/scarches: Reference mapping for single-cell genomics](./references/github_com_theislab_scarches.md)
- [Issues · theislab/scarches](./references/github_com_theislab_scarches_issues.md)
- [Commits · theislab/scarches](./references/github_com_theislab_scarches_commits_master.md)