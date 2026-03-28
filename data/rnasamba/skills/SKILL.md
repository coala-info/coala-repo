---
name: rnasamba
description: RNAsamba is a deep learning tool that classifies RNA sequences as coding or non-coding and identifies their protein-coding potential. Use when user asks to evaluate transcript coding potential, classify RNA sequences, translate predicted open reading frames into proteins, or train custom classification models.
homepage: https://github.com/apcamargo/RNAsamba
---

# rnasamba

## Overview

RNAsamba is a deep learning tool designed to evaluate the protein-coding potential of RNA sequences. By utilizing a neural network architecture, it classifies transcripts as coding or non-coding without relying on external homology searches or database alignments. It is highly effective for processing large-scale transcriptomic datasets and supports both the training of custom models and the use of pre-trained weights optimized for different transcript qualities (full-length vs. partial/fragmented).

## Usage Instructions

### Classification Patterns

The `classify` command is the primary tool for identifying coding sequences in an input FASTA file.

**Standard Classification**
Use this to generate a TSV file containing coding probabilities and classifications.
```bash
rnasamba classify output.tsv input.fasta weights.hdf5
```

**Classification with Protein Extraction**
Use the `-p` flag to automatically translate predicted coding ORFs into a protein FASTA file.
```bash
rnasamba classify output.tsv input.fasta weights.hdf5 -p predicted_proteins.fasta
```

**Ensemble Classification**
Improve prediction robustness by providing multiple weight files. RNAsamba will ensemble the results.
```bash
rnasamba classify output.tsv input.fasta model_v1.hdf5 model_v2.hdf5
```

### Training Patterns

The `train` command allows you to build a species-specific or dataset-specific model.

**Basic Training**
Requires a set of known coding and non-coding sequences.
```bash
rnasamba train output_model.hdf5 coding_sequences.fasta noncoding_sequences.fasta
```

**Optimized Training with Early Stopping**
Use `-s` to stop training after a specific number of epochs without improvement in validation loss. This prevents overfitting.
```bash
rnasamba train output_model.hdf5 coding.fasta noncoding.fasta -s 5 -e 100 -b 128
```

## Expert Tips and Best Practices

*   **Model Selection**: 
    *   Use `full_length_weights.hdf5` for high-quality datasets consisting of complete transcripts (e.g., curated reference genomes).
    *   Use `partial_length_weights.hdf5` for *de novo* assemblies or fragmented sequences where transcripts may be truncated.
*   **Early Stopping**: Always set the `--early_stopping` (or `-s`) parameter during training. A value between 3 and 10 is generally recommended to ensure the model saved is the one with the lowest validation loss.
*   **Batch Size**: The default batch size is 128. If you encounter memory issues on smaller GPUs or systems, reduce this using `-b`.
*   **Input Format**: Ensure your FASTA headers do not contain complex characters that might interfere with TSV parsing. RNAsamba identifies sequences by the first string in the FASTA header.



## Subcommands

| Command | Description |
|---------|-------------|
| rnasamba classify | Classify sequences from a input FASTA file. |
| rnasamba_train | Train a new classification model. |

## Reference documentation
- [RNAsamba GitHub Repository](./references/github_com_apcamargo_RNAsamba.md)
- [RNAsamba README](./references/github_com_apcamargo_RNAsamba_blob_master_README.md)