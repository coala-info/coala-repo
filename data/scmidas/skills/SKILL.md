---
name: scmidas
description: scmidas is a deep generative model for the mosaic integration and imputation of single-cell multimodal data. Use when user asks to integrate fragmented single-cell datasets, perform cross-modality knowledge transfer, or impute missing data across RNA, ADT, and ATAC modalities.
homepage: https://github.com/labomics/midas
metadata:
  docker_image: "quay.io/biocontainers/scmidas:0.1.15--pyhdfd78af_0"
---

# scmidas

## Overview

scmidas is a PyTorch-based implementation of the MIDAS algorithm, a deep generative model for the mosaic integration and knowledge transfer of single-cell multimodal data. It addresses the challenge of "fragmented" data—where some cells may only have RNA-seq data while others have a mix of RNA, ADT (proteomics), or ATAC-seq (chromatin accessibility). By leveraging self-supervised alignment and latent disentanglement, scmidas produces batch-corrected latent representations and fills in missing data through high-accuracy imputation, enabling unified downstream analysis of complex, multi-source datasets.

## Installation

Install the package via PyPI or Conda:

```bash
# Via PyPI
pip install scmidas==0.1.15

# Via Conda
conda install bioconda::scmidas
```

## Core Workflow

The standard workflow involves configuring the model, loading AnnData-formatted mosaic datasets, and training via PyTorch Lightning.

```python
from scmidas.config import load_config
from scmidas.model import MIDAS
import lightning as L

# 1. Load default configuration
configs = load_config()

# 2. Initialize model and load data
# Input should be a directory containing AnnData objects
model = MIDAS.configure_data_from_dir(
    configs, 
    'path/to/data_dir', 
    transform={'atac': 'binarize'}
)

# 3. Train the model
# Uses PyTorch Lightning Trainer for scalability
trainer = L.Trainer(max_epochs=2000)
trainer.fit(model=model)

# 4. Generate integrated results and imputed data
pred = model.predict()

# 5. Generate UMAP embeddings for visualization
model.get_emb_umap()
```

## Best Practices and Tips

- **ATAC-seq Preprocessing**: Always use the `transform={'atac': 'binarize'}` argument when working with chromatin accessibility data. Binarization is a standard practice for ATAC-seq that improves the stability of the generative model.
- **Mosaic Handling**: Ensure your input directory contains AnnData files where the `.var` names are consistent across batches for the same modalities, even if specific batches are missing entire modalities.
- **Training Monitoring**: Since scmidas is built on PyTorch Lightning, you can use TensorBoard to monitor training loss and visualize UMAPs in real-time to ensure the model is converging and batch effects are being effectively removed.
- **Knowledge Transfer**: For query-to-reference mapping, ensure the query data is preprocessed using the same feature space as the reference atlas to allow the model to project the query into the established latent space accurately.
- **Hardware Acceleration**: Use `L.Trainer(accelerator="gpu", devices=1)` if a GPU is available to significantly speed up the training of the deep generative model.

## Reference documentation
- [scmidas Overview](./references/anaconda_org_channels_bioconda_packages_scmidas_overview.md)
- [MIDAS GitHub Repository](./references/github_com_labomics_midas.md)