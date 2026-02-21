---
name: cuna
description: CUNA (Cytosine Uracil Neural Algorithm) is a specialized deep learning framework designed to identify chemical damage in ancient DNA.
homepage: https://github.com/iris1901/CUNA
---

# cuna

## Overview

CUNA (Cytosine Uracil Neural Algorithm) is a specialized deep learning framework designed to identify chemical damage in ancient DNA. Specifically, it targets the spontaneous deamination of cytosine to uracil, which is a hallmark of aged biological samples. By processing raw nanopore signals (POD5) alongside aligned sequences (BAM), CUNA can distinguish damaged bases from standard thymine, allowing researchers to authenticate and analyze ancient genomic data more accurately.

## Environment Setup

CUNA has specific dependency requirements, particularly for signal processing.

*   **Installation**: Install via Bioconda: `conda install bioconda::cuna`
*   **Critical Dependency**: Ensure `pod5==0.3.23` is installed to maintain compatibility with the signal extraction modules.
*   **Basecalling**: Use **Dorado (v0.9.1)** for signal-to-sequence conversion before running CUNA.

## Core CLI Workflows

### 1. Feature Extraction
Extract features from raw signals to prepare for training or detection.

```bash
cuna features \
  --bam path/to/aligned_data.bam \
  --input path/to/signals.pod5 \
  --ref path/to/reference.fa \
  --file_type pod5 \
  --threads 4 \
  --output ./features_output/ \
  --pos_list path/to/positions.txt \
  --window 10 \
  --seq_type dna
```

*   **--pos_list**: A text file containing the positions of interest with labels (for training).
*   **--window**: Defines the number of bases before and after the target position to include (default is 10).

### 2. Model Training
CUNA supports two primary neural network architectures.

*   **BiLSTM**: Best for capturing temporal dependencies in the raw signal.
*   **Transformer**: Best for learning long-range interactions within the sequence context.

```bash
cuna train \
  --mixed_training_dataset ./features_output/ \
  --model_type [bilstm|transformer] \
  --model_save_path ./models/ \
  --epochs 40 \
  --batch_size 512 \
  --validation_fraction 0.2
```

### 3. Damage Detection
Apply a trained model to detect deamination events in new samples.

```bash
cuna detect \
  --input path/to/test.pod5 \
  --bam path/to/test.bam \
  --model path/to/saved_model.ckpt \
  --output ./results/
```

## Expert Tips and Best Practices

*   **Reference Indexing**: Always ensure your reference FASTA is indexed (`samtools faidx reference.fa`) before running the features command.
*   **Signal Alignment**: For best results, use the same reference genome for both the initial BAM alignment and the CUNA feature extraction step.
*   **Hardware Acceleration**: Training is computationally intensive; ensure your environment has access to a GPU if using large datasets, though the CLI supports CPU execution via standard Python threading.
*   **Data Preparation**: When creating a `pos_list` for training, ensure a balanced representation of modified (U) and unmodified (T) sites to prevent model bias.

## Reference documentation
- [CUNA Overview - Bioconda](./references/anaconda_org_channels_bioconda_packages_cuna_overview.md)
- [CUNA GitHub Repository](./references/github_com_iris1901_CUNA.md)