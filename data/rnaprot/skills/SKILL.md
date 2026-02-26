---
name: rnaprot
description: RNAProt is a computational framework that models the binding preferences of RNA-binding proteins using deep learning. Use when user asks to generate datasets for RBP studies, train custom models for specific proteins, or predict potential binding sites on genomic regions or transcript sequences.
homepage: https://github.com/BackofenLab/RNAProt
---


# rnaprot

## Overview
RNAProt is a computational framework designed to model the binding preferences of RNA-binding proteins. It utilizes deep learning (specifically RNNs) to learn from experimental data like CLIP-seq. You should use this skill when you need to generate datasets for RBP studies, train custom models for specific proteins, or predict potential binding sites on new genomic regions or transcript sequences. It supports both sequence-only inputs and the integration of additional structural or genomic features.

## Installation and Setup
RNAProt is best managed via Conda within a dedicated environment.

```bash
# Create and activate environment
conda create -n rnaprotenv python=3.8 -c conda-forge -c bioconda
conda activate rnaprotenv

# Install RNAProt (CPU version)
conda install -c bioconda rnaprot

# Optional: Add GPU support (highly recommended for training)
conda install -c conda-forge pytorch-gpu=1.8
```

## Core Program Modes
The `rnaprot` command operates through several primary modes. Use `rnaprot -h` to see the full list of global options.

*   **Dataset Generation**: Preparing positive and negative sets from CLIP-seq data.
*   **Training**: Building the RNN model based on provided binding sites.
*   **Prediction**: Applying a trained model to new sequences to find binding sites.
*   **Evaluation**: Assessing model performance and binding preferences.

## Common CLI Patterns

### Training a Model
To train a model, you typically provide a set of positive (binding) and negative (non-binding) sequences.

```bash
rnaprot train -p positive_sites.fasta -n negative_sites.fasta -out my_model_dir
```

### Predicting Binding Sites
Once a model is trained, use the `predict` mode on target sequences.

```bash
rnaprot predict -i target_sequences.fasta -m my_model_dir/model.pt -out predictions.tsv
```

### Working with Genomic Regions (BED)
When using BED files, RNAProt requires a 2bit genomic sequence file and GTF annotations to extract the relevant sequences.

```bash
rnaprot train -p binding_sites.bed -n non_binding_sites.bed -g genome.2bit -a annotation.gtf -out bed_model_dir
```

## Expert Tips and Best Practices
*   **GPU Acceleration**: Training RNNs on large CLIP-seq datasets is computationally intensive. Always verify if CUDA is available using `python -c "import torch; print(torch.cuda.is_available())"`.
*   **Input Formats**: While FASTA is simpler for transcript-level analysis, BED format is preferred for genomic-scale studies as it allows RNAProt to handle genomic context and annotations automatically.
*   **Feature Selection**: RNAProt can incorporate additional features beyond raw sequence. If your data includes structural information or specific genomic landmarks, ensure these are formatted correctly according to the documentation in the `docs/` folder of the repository.
*   **Memory Management**: For large-scale predictions or training with high-resolution genomic data, ensure the system has at least 8 GB of RAM.

## Reference documentation
- [RNAProt GitHub Repository](./references/github_com_BackofenLab_RNAProt.md)
- [RNAProt Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_rnaprot_overview.md)