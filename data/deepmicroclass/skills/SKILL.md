---
name: deepmicroclass
description: DeepMicroClass is a specialized tool designed to sort metagenomic contigs into distinct biological categories using deep learning models.
homepage: https://github.com/chengsly/DeepMicroClass
---

# deepmicroclass

## Overview
DeepMicroClass is a specialized tool designed to sort metagenomic contigs into distinct biological categories using deep learning models. It is particularly effective for identifying viruses infecting prokaryotic or eukaryotic hosts, as well as distinguishing between eukaryotic and prokaryotic chromosomal DNA. The tool provides a complete workflow from raw FASTA sequences to classified outputs and allows for the extraction of specific sequence subsets based on their predicted labels.

## Installation and Setup
The tool is available via Bioconda and Pip. For GPU acceleration, ensure PyTorch is compatible with your CUDA version.

```bash
# Installation via Conda
conda install bioconda::deepmicroclass

# Installation via Pip (requires manual PyTorch setup for GPU)
pip install DeepMicroClass
```

## Core CLI Usage

### 1. Testing the Installation
Verify the environment and tool functionality using the built-in test suite.
```bash
DeepMicroClass test
```

### 2. Predicting Contig Classes
The `predict` command is the primary entry point for classification.

```bash
DeepMicroClass predict -i <input.fasta> -o <output_dir> --device <cpu|cuda>
```

**Key Arguments:**
- `--input`, `-i`: Path to the input FASTA file.
- `--output_dir`, `-o`: Directory where results will be saved.
- `--mode`, `-md`: Choose between `hybrid` (default) or `single`.
- `--encoding`, `-e`: Choose `onehot` or `embedding`.
- `--device`, `-d`: Specify `cpu` or `cuda`. Use `cuda` for significantly faster processing if a GPU is available.

### 3. Extracting Specific Sequences
After prediction, use the `extract` command to isolate contigs belonging to a specific class of interest.

```bash
DeepMicroClass extract --tsv <output.tsv> --fasta <input.fa> --class <class_name> --output <filtered.fa>
```

**Valid Class Names:**
- `Eukaryote`
- `EukaryoteVirus`
- `Plasmid`
- `Prokaryote`
- `ProkaryoteVirus`

## Interpreting Results
The output TSV file contains probability scores for each of the five classes.
- **Label Assignment**: The sequence is assigned to the class with the highest score.
- **Score Range**: Scores typically range from 0 to 1 (or higher depending on the model version); higher scores indicate higher confidence in the classification.

## Expert Tips
- **GPU Utilization**: If processing large metagenomes, always prefer `--device cuda`. Ensure your environment has `nvidia-smi` showing a valid driver before running.
- **Memory Management**: For very large FASTA files, monitor system RAM if using CPU mode, as the model loading and sequence encoding can be memory-intensive.
- **Hybrid vs Single Mode**: Use `hybrid` mode for standard metagenomic assemblies to leverage the best performance across varying contig lengths.

## Reference documentation
- [DeepMicroClass GitHub Repository](./references/github_com_chengsly_DeepMicroClass.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_deepmicroclass_overview.md)