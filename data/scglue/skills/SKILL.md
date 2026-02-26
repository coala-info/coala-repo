---
name: scglue
description: scglue is a framework for integrating multi-omics data by learning a shared latent space through a guidance graph. Use when user asks to integrate single-cell RNA and ATAC data, construct genomic guidance graphs, or infer gene regulatory networks.
homepage: https://github.com/gao-lab/GLUE
---


# scglue

## Overview
scglue (Graph-Linked Unified Embedding) is a specialized framework for multi-omics data integration. Unlike simple concatenation methods, it uses a "guidance graph" to link different feature spaces (like genes in RNA and peaks in ATAC). This allows the model to learn a shared latent space for cells even when they were not measured simultaneously in the same physical cell. Use this skill to set up the environment, construct guidance graphs, and execute the integration model.

## Installation and Environment Setup

The package is available via Conda and Pip. Using a dedicated Conda environment is highly recommended due to specific dependencies like PyTorch and AnnData.

### Standard Installation
```bash
# CPU-only version
conda install -c conda-forge -c bioconda scglue

# GPU-accelerated version (recommended for large datasets)
conda install -c conda-forge -c bioconda scglue pytorch-gpu
```

### Development Setup
If you need to modify the source or run the latest experimental features:
```bash
git clone https://github.com/gao-lab/GLUE.git
cd GLUE
flit install -s
```

## Core Workflow Patterns

### 1. Guidance Graph Construction
The strength of scglue lies in the guidance graph. You must typically link RNA features (genes) to ATAC features (peaks/loci).

*   **Gene Annotation**: Use `scglue.data.get_gene_annotation` to fetch genomic coordinates.
*   **Graph Generation**: Use `scglue.genomics.rna_anchored_guidance_graph` to create links based on genomic distance.

### 2. Model Training (fit_SCGLUE)
The primary entry point for training is `scglue.models.fit_SCGLUE`. 

*   **Balancing**: If your modalities have significantly different cell counts, ensure you check the `skip_balance` parameter (added in v0.4.0) if you want to override default sampling behavior.
*   **Device Selection**: The tool automatically detects CUDA. To force a specific device, set the `CUDA_VISIBLE_DEVICES` environment variable before execution.

### 3. Regulatory Inference
Beyond integration, scglue can infer Gene Regulatory Networks (GRN).
*   Use the wrapper functions for TF-target GRN inference to identify regulatory links between transcription factors and target genes based on the learned embeddings.

## Expert Tips and Troubleshooting

### Common Pitfalls
*   **Feature Mismatch**: A common error is `ValueError: Not all modality features exist in the graph!`. Ensure that the feature names (index) in your AnnData objects exactly match the node names in your guidance graph.
*   **Sparse Data**: If encountering `AttributeError` related to `SparseDataset`, ensure your `anndata` version is compatible (typically < 0.10.0 for older scglue versions, or update scglue to >= 0.4.0).
*   **NaN Values**: If `get_gene_annotation` returns many NaNs, verify that your input gene symbols match the database (e.g., Ensembl vs. Symbol) and that the correct `species` parameter is set.

### Performance Optimization
*   **GPU Memory**: For large-scale ATAC-seq data, ensure peaks are filtered for accessibility across a minimum percentage of cells to reduce the graph size.
*   **Checkpoints**: Training can be intensive. Use the built-in logging to monitor the VAE (Variational Autoencoder) and Discriminator loss to ensure convergence.

## Reference documentation
- [scglue GitHub Repository](./references/github_com_gao-lab_GLUE.md)
- [scglue Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_scglue_overview.md)
- [Known Issues and Troubleshooting](./references/github_com_gao-lab_GLUE_issues.md)