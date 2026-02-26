---
name: deepbgc
description: DeepBGC identifies biosynthetic gene clusters in genomic sequences using deep learning and protein domain embeddings. Use when user asks to detect secondary metabolite clusters, predict BGC product classes, or train custom genome mining models.
homepage: https://github.com/Merck/DeepBGC
---


# deepbgc

## Overview
DeepBGC is a specialized tool for genome mining that identifies Biosynthetic Gene Clusters (BGCs) using deep learning. Unlike traditional rule-based systems, it employs a Bidirectional Long Short-Term Memory (LSTM) network and Pfam protein domain embeddings to detect novel clusters. It also includes a Random Forest classifier to predict the specific product class and biological activity of detected clusters. Use this skill to automate the identification of secondary metabolite clusters in FASTA or GenBank files.

## Core Workflows

### 1. Initial Setup
Before running any analysis, you must download the trained models and the Pfam database.
```bash
deepbgc download
```
Verify the installation and see available models:
```bash
deepbgc info
```

### 2. Running the Detection Pipeline
The `pipeline` command is the primary entry point for analysis. It automatically handles protein prediction (Prodigal) and Pfam domain identification (HMMER) if they are not already present in the input.

**Standard analysis:**
```bash
deepbgc pipeline my_sequence.fa
```

**Using a custom detector:**
If you have trained a specific model for a particular organism or BGC type:
```bash
deepbgc pipeline --detector /path/to/my_detector.pkl input.fa
```

### 3. Data Preparation and Training
To train custom models, you must convert sequences into the Pfam TSV format.

**Prepare Pfam TSV from protein sequences:**
```bash
deepbgc prepare --protein input_proteins.fa
```

**Training requirements:**
When preparing data for the `deepbgc train` command, ensure your TSV files include:
- `in_cluster`: Binary column (1 for Pfams inside a BGC, 0 outside).
- `sequence_id`: Unique identifier for continuous Pfam sequences to keep samples together during shuffling.

## Expert Tips and Best Practices
- **Python Version**: DeepBGC requires Python 3.6 or 3.7 due to its dependency on TensorFlow < 2.0. It will not run on Python 3.8+.
- **antiSMASH Integration**: DeepBGC generates an `antismash.json` file in the output folder. You can upload this file to the antiSMASH web server using the "Upload extra annotations" feature to visualize DeepBGC predictions alongside antiSMASH results.
- **Input Formats**: While FASTA is common, providing GenBank files with pre-existing annotations can significantly speed up the pipeline by skipping the Prodigal/HMMER steps.
- **Memory Management**: For large metagenomic assemblies, ensure the environment has sufficient RAM for the LSTM state processing, especially when using large batch sizes in custom training.

## Reference documentation
- [DeepBGC GitHub Repository](./references/github_com_Merck_deepbgc.md)