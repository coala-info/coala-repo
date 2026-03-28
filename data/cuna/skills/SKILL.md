---
name: cuna
description: CUNA is a deep learning pipeline that distinguishes true thymines from deaminated cytosines in ancient DNA using Nanopore signal data and genomic alignments. Use when user asks to extract signal features from POD5 files, train classification models for ancient DNA, or detect deamination modifications in paleogenomics research.
homepage: https://github.com/iris1901/CUNA
---


# cuna

## Overview
CUNA is a deep learning-based pipeline specifically optimized for ancient DNA research. It addresses the common issue of spontaneous cytosine-to-uracil deamination that occurs as DNA ages. By analyzing the raw ionic current signals from Nanopore sequencing (POD5 files) alongside genomic alignments (BAM files), CUNA can distinguish between true thymines and deaminated cytosines that appear as uracils. This is critical for accurate basecalling and damage pattern analysis in paleogenomics.

## Environment Setup
CUNA requires specific versions of dependencies, particularly the `pod5` library. Use Micromamba or Conda for a clean installation:

```bash
micromamba create -n CUNA -c conda-forge -c bioconda cuna pod5=0.3.23
micromamba activate CUNA
```

## Feature Generation
The first step in the pipeline is extracting signal features from the raw data. This requires a reference genome, a BAM file (aligned to that reference), and the raw POD5 signal data.

```bash
cuna features \
  --bam path/to/alignment.bam \
  --input path/to/signals.pod5 \
  --ref path/to/reference.fa \
  --pos_list path/to/positions.txt \
  --file_type pod5 \
  --window 10 \
  --threads 4 \
  --output path/to/output_dir/
```

### Key Parameters:
- `--window`: Defines the number of bases before and after the target position to include in the feature window (default is 10).
- `--pos_list`: A text file containing the genomic positions of interest with labels for training.
- `--seq_type`: Specify `dna` for standard ancient DNA analysis.

## Model Training
CUNA supports two primary neural network architectures for classification:

1.  **BiLSTM**: Best for capturing temporal dependencies in the raw signal.
2.  **Transformer**: Best for learning long-range interactions and sequence context.

```bash
cuna train \
  --mixed_training_dataset path/to/features.npz \
  --model_type bilstm \
  --batch_size 64 \
  --epochs 20 \
  --output path/to/model_output/
```

## Expert Tips and Best Practices
- **Basecalling Requirement**: Before using CUNA, data must be basecalled using Oxford Nanopore's **Dorado**. It is recommended to use the `hac` (high accuracy) models for the best signal-to-sequence mapping.
- **Reference Indexing**: Ensure your reference FASTA is indexed (`samtools faidx reference.fa`) before running feature extraction.
- **Signal Resampling**: CUNA resamples raw signals to align them with the sequence context. If you encounter alignment errors, verify that your BAM file contains the necessary move table/signal mapping information (standard in Dorado output).
- **Hardware Acceleration**: Training deep learning models (BiLSTM/Transformer) is significantly faster on systems with NVIDIA GPUs and CUDA support.



## Subcommands

| Command | Description |
|---------|-------------|
| cuna detect | Detect modifications using a trained model. |
| cuna_features | Extracts features from sequencing data. |
| cuna_merge | Merge per-read modification calls. |
| cuna_train | Train a CUNA model. |

## Reference documentation
- [CUNA Main Repository](./references/github_com_iris1901_CUNA.md)
- [CUNA README and Workflow Guide](./references/github_com_iris1901_CUNA_blob_main_README.md)