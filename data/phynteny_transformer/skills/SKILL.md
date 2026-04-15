---
name: phynteny_transformer
description: Phynteny transformer performs functional annotation of bacteriophage genes by leveraging gene synteny and transformer-based deep learning. Use when user asks to annotate phage genomes, predict functions for dark matter genes, or incorporate gene order into functional predictions.
homepage: https://github.com/susiegriggo/Phynteny_transformer
metadata:
  docker_image: "quay.io/biocontainers/phynteny_transformer:0.1.3--pyhdfd78af_0"
---

# phynteny_transformer

## Overview

Phynteny is a specialized tool for the functional annotation of bacteriophage genomes. Unlike traditional homology-based methods that rely solely on sequence similarity, Phynteny utilizes a transformer architecture with attention mechanisms and LSTM layers to incorporate gene synteny—the physical co-localization of genes on a chromosome. By analyzing the positional context of genes, it can predict functions for "dark matter" genes that lack clear homologs. This skill provides the necessary procedures to install models, run predictions on GenBank files, and interpret the resulting confidence scores.

## Installation and Setup

Before running predictions, you must install the pre-trained transformer models.

```bash
# Install models to the default location
install_models

# Install models to a specific directory
install_models -o /path/to/database_dir
```

If the automated script fails, models can be manually downloaded from Zenodo and specified during runtime using the `-m` flag.

## Core Workflow

### Input Requirements
Phynteny requires a GenBank (.gbk) file that has already been annotated with PHROG (Prokaryotic Virus Remote Homologous Groups) categories. For best results, follow this upstream workflow:
1. Annotate with **Pharokka** (HMM-based).
2. Refine with **Phold** (Structure-based).
3. Finalize with **Phynteny** (Synteny-based).

### Basic Usage
Run the transformer on your annotated GenBank file:

```bash
phynteny_transformer input_phage.gbk -o output_directory
```

### Advanced Usage
To use custom-trained models or adjust specific transformer parameters:

```bash
phynteny_transformer input_phage.gbk -o output_directory --advanced
```

## Interpreting Outputs

The tool generates two primary files in the output directory:

1.  **phynteny_transformer.gbk**: An updated GenBank file. Each CDS (Coding Sequence) feature is updated with:
    *   `phynteny_score`: The numerical prediction score.
    *   `confidence`: The qualitative confidence level of the annotation.
2.  **phynteny_per_cds_functions.tsv**: A tabular summary of all annotations, useful for downstream bioinformatics pipelines and bulk analysis.

## Best Practices and Tips

*   **Context Matters**: Phynteny's strength lies in gene order. Ensure your input GenBank file maintains the correct relative positions of CDS features.
*   **Model Paths**: If you installed models to a non-standard location, always use the `-m` or `--models` flag to point to the directory containing the `.pt` model files.
*   **Training**: If you have a large, manually curated dataset, consider training a custom model using the scripts in the `train_transformer` directory of the source repository.

## Reference documentation

- [Phynteny Transformer GitHub Repository](./references/github_com_susiegriggo_Phynteny_transformer.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_phynteny_transformer_overview.md)