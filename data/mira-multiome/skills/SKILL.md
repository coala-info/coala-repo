---
name: mira-multiome
description: MIRA is a Python framework for the integrated regulatory analysis of single-cell gene expression and chromatin accessibility data. Use when user asks to perform topic modeling, construct joint representations of multi-modal data, model regulatory potential, or disentangle biological signals from technical batch effects.
homepage: https://mira-multiome.readthedocs.io/en/latest/
---


# mira-multiome

## Overview

MIRA (Multimodal models for Integrated Regulatory Analysis) is a specialized Python framework designed to uncover the regulatory mechanisms driving cellular states and transitions. By leveraging both gene expression and chromatin accessibility data, MIRA provides a more comprehensive view of the "regulatory state" than single-mode analyses. It is particularly effective for disentangling biological signals from technical batch effects using the CODAL (Comparative Optimization for Disentangled Atlas Learning) objective. Use this skill to move beyond simple clustering into high-resolution manifold learning and functional enrichment.

## Installation and Environment Setup

MIRA relies on Scanpy, AnnData, and PyTorch. For optimal performance, especially during topic model training, a CUDA-enabled GPU is highly recommended.

```bash
# Recommended environment setup
conda create --name mira-env -c conda-forge -c bioconda scanpy jupyter leidenalg
conda activate mira-env
pip3 install mira-multiome
```

## Core Workflow Patterns

MIRA is primarily used as a Python library. The workflow typically follows these stages:

### 1. Topic Modeling
MIRA uses probabilistic topic modeling to reduce the dimensionality of RNA and ATAC data.
- **ExpressionTopicModel**: For scRNA-seq data.
- **AccessibilityTopicModel**: For scATAC-seq data.

**Expert Tip**: When training models, use the `BayesianTuner` to find the optimal number of topics, as this significantly impacts the resolution of the resulting manifold.

### 2. Joint Representation
After modeling each modality, MIRA constructs a joint representation that captures the shared information between expression and accessibility.
- Use `mira.utils.make_joint_representation` to merge the latent spaces.
- This joint manifold is used for downstream clustering and visualization (UMAP/TSNE).

### 3. Regulatory Potential (RP) Modeling
MIRA models how chromatin accessibility near a gene's Transcription Start Site (TSS) predicts its expression.
- **LITE Models**: Standard regulatory potential modeling.
- **NITE Models**: Used to find "Non-Interacting Tissue-specific Expression," identifying genes where expression is decoupled from local accessibility.

## Tool-Specific Best Practices

- **Peak Calling**: Avoid using CellRanger's default ATAC-seq peak-calling. Use **MACS2** instead; it produces more specific peaks, which leads to higher-resolution manifolds during topic modeling.
- **Batch Correction**: MIRA’s topic models (v2.1+) use the CODAL objective. This is the preferred method for integrating batched datasets as it disentangles biological variation from technical noise without the need for explicit "alignment" that can sometimes erase biological signals.
- **GPU Acceleration**: Always check if PyTorch can see your GPU. Training topic models on a CPU is significantly slower and may limit the number of iterations or topics you can practically test.
- **Scanpy Integration**: MIRA is designed to work "on top" of Scanpy. You can seamlessly use `sc.pl.umap` or `sc.tl.leiden` on the AnnData objects modified by MIRA.

## Common API Entry Points

- `mira.topics.make_model`: Initialize topic models.
- `mira.topics.gradient_tune`: Optimize hyperparameters.
- `mira.time.trace_differentiation`: Perform pseudotime trajectory inference.
- `mira.pl.plot_topic_contributions`: Visualize which topics drive specific cell clusters.

## Reference documentation
- [MIRA Documentation Overview](./references/mira-multiome_readthedocs_io_en_latest.md)
- [Getting Started with MIRA](./references/mira-multiome_readthedocs_io_en_latest_getting_started.html.md)
- [MIRA API Index](./references/mira-multiome_readthedocs_io_en_latest_genindex.html.md)