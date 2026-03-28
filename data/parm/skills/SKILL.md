---
name: parm
description: PARM is a deep learning framework that predicts cell-type-specific promoter activity and identifies regulatory motifs through in-silico mutagenesis. Use when user asks to predict promoter activity from DNA sequences, perform in-silico mutagenesis to identify transcription factor binding sites, visualize mutation effect matrices, or train custom models on MPRA data.
homepage: https://github.com/vansteensellab/PARM
---

# parm

## Overview
PARM (Promoter Activity Regulatory Model) is a deep learning framework designed to predict cell-type-specific promoter activity directly from DNA sequences. It utilizes a convolutional neural network (CNN) architecture trained on MPRA data to provide lightweight, high-throughput predictions. Beyond simple activity scoring, PARM enables "in-silico mutagenesis," which simulates the effect of every possible single-nucleotide mutation across a sequence. This allows researchers to identify critical regulatory motifs and the specific transcription factors (TFs) likely to bind and regulate a given promoter.

## Core Workflows

### 1. Predicting Promoter Activity
Use `parm predict` to estimate the activity of sequences provided in a FASTA file.

```bash
parm predict \
  --input sequences.fasta \
  --output predictions.txt \
  --model path/to/pretrained_model/
```

*   **Model Selection**: Ensure the model path points to a directory containing the five `.parm` fold files for the specific cell type (e.g., AGS, HAP1, K562).
*   **Output**: A tab-separated file containing the sequence, header, and the predicted activity score.

### 2. In-Silico Mutagenesis
Use `parm mutagenesis` to generate a mutation effect matrix and scan for TF binding sites.

```bash
parm mutagenesis \
  --input sequences.fasta \
  --output mutagenesis_results_dir \
  --model path/to/pretrained_model/ \
  --motif_database HOCOMOCOv11_core_HUMAN_mono_happe_format.pwms
```

*   **Mechanism**: For every base in the input, PARM predicts the effect of changing it to A, C, G, or T.
*   **TF Scanning**: By default, it uses HOCOMOCOv11 to identify which TF motifs are disrupted or created by mutations.

### 3. Visualizing Results
Use `parm plot` to create a visual representation of the mutagenesis matrix and TF hits.

```bash
parm plot \
  --input mutagenesis_results_dir/sequence_id/
```

*   **Output**: Generates a PDF (by default) showing the sequence logo, the mutation effect heat map, and overlapping TF motifs.

### 4. Training Custom Models
If you have your own MPRA data, you can train a new PARM model. This requires five-fold cross-validation.

```bash
# Example for training Fold 0
parm train \
  --input training_data/fold[1234].hdf5 \
  --validation training_data/fold0.hdf5 \
  --output model_fold0 \
  --cell_type MY_CELL_LINE
```

*   **Best Practice**: After training all five folds (0-4), move all `.parm` files into a single directory to use them with the `predict` or `mutagenesis` commands.

## Expert Tips
*   **Cell-Type Specificity**: PARM predictions are highly specific to the training data. Always use the model corresponding to the cell line most relevant to your biological context.
*   **Input Formatting**: Input FASTA headers should be unique and descriptive, as they are used to name output directories in mutagenesis workflows.
*   **Resource Management**: While lightweight, running mutagenesis on very long sequences or large FASTA files can be computationally intensive due to the $4 \times L$ predictions required per sequence.



## Subcommands

| Command | Description |
|---------|-------------|
| parm plot | Promoter Activity Regulatory Model |
| parm predict | Promoter Activity Regulatory Model |
| parm train | Promoter Activity Regulatory Model |
| parm_mutagenesis | Promoter Activity Regulatory Model |

## Reference documentation
- [PARM Main Documentation](./references/github_com_vansteensellab_PARM_blob_main_README.md)
- [PARM Setup and Dependencies](./references/github_com_vansteensellab_PARM_blob_main_setup.py.md)