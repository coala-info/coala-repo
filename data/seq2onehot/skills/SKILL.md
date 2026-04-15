---
name: seq2onehot
description: seq2onehot converts biological sequences from FASTA files into one-hot encoded NumPy arrays for use in deep learning models. Use when user asks to transform DNA, RNA, or protein sequences into 3D arrays, encode sequences for TensorFlow or PyTorch, or convert FASTA files to one-hot format.
homepage: https://github.com/akikuno/seq2onehot
metadata:
  docker_image: "quay.io/biocontainers/seq2onehot:0.0.1--pyhfa5458b_0"
---

# seq2onehot

## Overview

The `seq2onehot` tool provides a streamlined way to transform biological sequence data into a format compatible with deep learning frameworks like TensorFlow or PyTorch. It converts standard FASTA files into 3D NumPy arrays where each character is represented by a one-hot vector. This tool is specifically designed for scenarios where sequences are already aligned or naturally of equal length, as it requires uniform sequence lengths across the input file.

## Installation

Install the tool via pip or bioconda:

```bash
pip install seq2onehot
# OR
conda install -c bioconda seq2onehot
```

## Command Line Usage

The basic syntax requires specifying the sequence type, the input FASTA file, and the output destination for the `.npy` file.

### Basic Patterns

**DNA Sequences:**
```bash
seq2onehot -t dna -i sequences.fasta -o data.npy
```

**RNA Sequences:**
```bash
seq2onehot -t rna -i sequences.fasta -o data.npy
```

**Protein Sequences:**
```bash
seq2onehot -t protein -i sequences.fasta -o data.npy
```

### Handling Ambiguous Characters
By default, the tool uses a standard alphabet (4 for DNA/RNA, 20 for Protein). To include ambiguous characters (like `N` in DNA or `X` in Protein), use the `-a` flag.

```bash
seq2onehot -t dna -a -i sequences.fasta -o data.npy
```

## Expert Tips and Best Practices

### 1. Sequence Length Constraint
The most common cause of failure is variable sequence lengths. Before running `seq2onehot`, ensure all sequences in your FASTA file are the same length. If they are not, you must pre-process them by padding or trimming.

### 2. Understanding Output Dimensions
The output `.npy` file contains a 3D array with the shape `(Number of Reads, Sequence Length, Alphabet Size)`.
- **DNA/RNA Alphabet Size:** 4 (Standard: ACGT/U) or 15 (Ambiguous: ACGT/U + NVHDBMRWSYK).
- **Protein Alphabet Size:** 20 (Standard) or 24 (Ambiguous: + XBZJ).

### 3. Alphabet Ordering
When loading the resulting array into a model, remember the specific bit-order used by the tool:
- **DNA:** A, C, G, T
- **RNA:** A, C, G, U
- **Protein:** A, C, D, E, F, G, H, I, K, L, M, N, P, Q, R, S, T, V, W, Y

### 4. Memory Management
Since one-hot encoding significantly expands the data size (e.g., a DNA sequence of length 1000 becomes a 1000x4 matrix), ensure your environment has enough RAM to hold the resulting NumPy array before writing to disk, especially for large protein datasets.

### 5. Decoding
If you need to convert the NumPy arrays back into sequences after model processing, use the companion tool `onehot2seq`.

## Reference documentation
- [seq2onehot GitHub Repository](./references/github_com_akikuno_seq2onehot.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_seq2onehot_overview.md)