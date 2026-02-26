---
name: parm
description: PARM is a convolutional neural network that predicts cell-type-specific promoter activity and identifies transcription factor binding sites from DNA sequences. Use when user asks to predict promoter activity from FASTA files, perform in-silico mutagenesis, visualize motif hits, or train custom models on MPRA data.
homepage: https://github.com/vansteensellab/PARM
---


# parm

## Overview

PARM (Promoter Activity Regulatory Model) is a lightweight convolutional neural network designed to predict cell-type-specific promoter activity directly from DNA sequences. It is primarily used to analyze Massively Parallel Reporter Assay (MPRA) data, allowing researchers to estimate the regulatory potential of sequences and identify specific transcription factor (TF) binding sites through in-silico mutagenesis. The tool supports several human cell lines and provides utilities for training new models on custom experimental data.

## Installation

Install PARM via bioconda:

```bash
conda create -n parm_env -c conda-forge -c bioconda -c pytorch parm
conda activate parm_env
```

## Core CLI Usage

### Predicting Promoter Activity
Predict the activity of sequences in a FASTA file for a specific cell type.

```bash
parm predict \
  --input sequences.fasta \
  --output predictions.txt \
  --model path/to/pre_trained_models/K562/
```

**Note**: The `--model` argument must point to a directory containing the five fold files (`.parm`), as PARM averages predictions across these folds.

### In-silico Mutagenesis
Compute the predicted effect of every possible single-nucleotide mutation for sequences in a FASTA file.

```bash
parm mutagenesis \
  --input sequences.fasta \
  --output mutagenesis_results_dir \
  --model path/to/pre_trained_models/K562/ \
  --motif_database HOCOOMOCOv11_core_HUMAN_mono_hocomoco_format.motif
```

This command generates:
1. A mutagenesis matrix (`mutagenesis_*.txt.gz`) for each sequence.
2. A list of scanned TF motif hits (`hits_*.txt.gz`).

### Visualizing Results
Generate a PDF plot showing the mutagenesis matrix and associated TF motif hits.

```bash
parm plot --input mutagenesis_results_dir/sequence_header_id/
```

### Training Custom Models
Train a new PARM model using processed MPRA data (HDF5 format). PARM requires training five independent folds for a complete model.

```bash
# Example for Fold 0
parm train \
  --input data/fold1.hdf5 data/fold2.hdf5 data/fold3.hdf5 data/fold4.hdf5 \
  --validation data/fold0.hdf5 \
  --output model_fold0 \
  --cell_type MY_CELL_LINE
```

## Expert Tips and Best Practices

- **Model Directory Structure**: Never rename the `.parm` files within a model directory. The `predict` and `mutagenesis` tools expect a specific naming convention to load all five folds correctly.
- **Batch Processing**: For large FASTA files, use the `--n_seqs_per_batch` parameter in `parm predict` to optimize memory usage and speed.
- **Motif Filtering**: When plotting, use `--min_relative_attribution` to filter out low-confidence motif hits by defining a minimum percentage threshold relative to the highest attribution score.
- **Training Data**: Ensure MPRA counts are pre-processed into one-hot encoded HDF5 files using the official pre-processing pipeline before attempting `parm train`.
- **Cell Type Support**: Pre-trained models are available for AGS, HAP1, HCT116, HEK116, HepG2, K562, LNCaP, MCF7, and U2OS.

## Reference documentation

- [PARM GitHub Repository](./references/github_com_vansteensellab_PARM.md)
- [Bioconda PARM Package](./references/anaconda_org_channels_bioconda_packages_parm_overview.md)