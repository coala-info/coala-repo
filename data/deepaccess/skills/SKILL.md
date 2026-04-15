---
name: deepaccess
description: DeepAccess is a deep learning framework for predicting chromatin accessibility and interpreting genomic sequence patterns using ensemble convolutional neural networks. Use when user asks to train models on genomic coordinates or sequences, identify influential DNA motifs, analyze sequence pattern spacing, or generate nucleotide-level saliency maps.
homepage: https://github.com/gifford-lab/deepaccess-package
metadata:
  docker_image: "quay.io/biocontainers/deepaccess:0.1.3--pyhdfd78af_0"
---

# deepaccess

## Overview

DeepAccess is a specialized deep learning framework designed for the analysis of genomic sequence data. It enables the training of ensemble convolutional neural networks (CNNs) to predict chromatin accessibility across multiple tasks or cell types. Beyond prediction, the tool provides robust interpretation modules to extract biological insights, such as identifying influential DNA motifs, analyzing the spacing between sequence patterns, and generating base-pair resolution saliency maps to visualize nucleotide importance.

## Core Workflows

### 1. Model Training

DeepAccess supports training from either genomic coordinates (BED files) or raw sequences (FASTA files).

**Training from BED files (Requires reference genome):**
Use this when you have peak calls for different conditions.
```bash
deepaccess train \
  -beds cell1.bed cell2.bed \
  -l CellType1 CellType2 \
  -ref hg38.fa \
  -g hg38.chrom.sizes \
  -out ./output_model \
  -nepochs 10 \
  -ho chrX
```
*   **Note**: `-ho` specifies a holdout chromosome for validation to prevent overfitting.
*   **Note**: Requires `bedtools` to be installed and in your PATH.

**Training from FASTA files:**
Use this if sequences are already extracted and labeled.
```bash
deepaccess train \
  -fa sequences.fa \
  -fasta_labels labels.txt \
  -l LabelA LabelB \
  -out ./output_model
```

### 2. Model Interpretation

Once a model is trained, use the `interpret` command to understand what the model has learned.

**Motif Activity Analysis:**
Evaluate the Expected Predicted Effect (EPE) of known motifs.
```bash
deepaccess interpret \
  -trainDir ./output_model \
  -l CellType1 CellType2 \
  -c CellType1vsCellType2 \
  -evalMotifs motifs_database.txt
```

**Pattern Spacing and Interaction:**
Test how the spacing between specific DNA patterns affects predicted accessibility.
```bash
deepaccess interpret \
  -trainDir ./output_model \
  -evalPatterns patterns.fa \
  -bg background_sequences.fa
```

**Saliency Mapping:**
Generate nucleotide-level importance scores for specific sequences.
```bash
deepaccess interpret \
  -trainDir ./output_model \
  -fastas interesting_regions.fa \
  -saliency -vis
```

## Expert Tips and Best Practices

*   **Differential Analysis**: Use the `-c` (comparisons) flag during interpretation to perform differential EPE analysis (e.g., `GroupAvsGroupB`). This highlights motifs that are specifically important for one condition over another.
*   **Background Selection**: When evaluating patterns, providing a relevant background FASTA (`-bg`) is critical for accurate enrichment calculations.
*   **Outgroup Regions**: When training from BED files, use `-f` (frac_random) to include random genomic regions as an "inactive" outgroup, which helps the model learn to distinguish accessible peaks from the genomic background.
*   **Ensemble Reliability**: DeepAccess trains an ensemble of models; ensure the `-trainDir` contains the full output of the training process to allow the interpretation module to aggregate results across the ensemble.



## Subcommands

| Command | Description |
|---------|-------------|
| deepaccess | Interpret deep learning models for DNA sequence analysis. |
| deepaccess | Train a deep learning model for variant calling. |

## Reference documentation

- [DeepAccess Package README](./references/github_com_gifford-lab_deepaccess-package_blob_main_README.md)
- [Example Execution Script](./references/github_com_gifford-lab_deepaccess-package_blob_main_run_ASCL1vsCTCF_DeepAccess.sh.md)