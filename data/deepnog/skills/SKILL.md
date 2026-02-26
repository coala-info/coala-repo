---
name: deepnog
description: DeepNOG assigns proteins to orthologous groups using deep neural networks for rapid genomic and metagenomic analysis. Use when user asks to assign proteins to orthologous groups, perform protein group inference, or train custom models for specific taxonomic levels.
homepage: https://github.com/univieCUBE/deepnog
---


# deepnog

## Overview

DeepNOG is a specialized bioinformatics tool for the rapid assignment of proteins to orthologous groups (such as eggNOG 5.0 or COG 2020) using deep neural networks. It is designed to handle large-scale genomic and metagenomic datasets by bypassing the computational overhead of traditional sequence alignment. Use this skill to perform protein group inference on CPUs or GPUs, or to train custom models for specific taxonomic levels.

## Installation and Setup

Install deepnog via bioconda or pip:

```bash
conda install bioconda::deepnog
# OR
pip install deepnog
```

DeepNOG automatically downloads pre-trained models to `~/deepnog_data/`. To change this location, set the environment variable:
`export DEEPNOG_DATA=/path/to/custom/cache`

## Inference Patterns

Perform orthologous group assignment using the `infer` command.

### Basic Inference
Assign proteins in a FASTA file to the default eggNOG5 bacteria level:
`deepnog infer proteins.faa --out predictions.csv`

### Advanced Inference Options
- **Specify Database and Taxonomy**: Use `-db` and `-t` (TaxID) to target specific levels.
  `deepnog infer proteins.faa -db eggNOG5 -t 1236` (Gammaproteobacteria)
- **Confidence Thresholding**: Discard low-confidence assignments using `-c`.
  `deepnog infer proteins.faa -c 0.99`
- **Verbosity**: Increase output detail for progress tracking.
  `deepnog infer proteins.faa -V 3`

## Training Custom Models

Use the `train` command to create models for specific taxonomic levels or custom datasets.

### Training Workflow
Provide training and validation sequences (FASTA) along with their corresponding group assignments (CSV):
`deepnog train train.fa val.fa train.csv val.csv -a deepnog -e 15 --shuffle -o ./output_model_dir`

### Key Training Arguments
- `-a`: Architecture (default is `deepnog`).
- `-e`: Number of epochs.
- `-r`: Set a random seed for reproducibility.
- `-db` / `-t`: Define the database and taxonomic level the model represents.

## Expert Tips

- **Hardware Acceleration**: DeepNOG automatically detects and uses GPUs via PyTorch. Ensure your environment has `cuda` available for significant speedups on large datasets.
- **File Formats**: While FASTA is the primary tested format, DeepNOG supports any format compatible with Biopython's `SeqIO` (including compressed `.gz` or `.xz` files).
- **Memory Management**: For extremely large FASTA files, monitor RAM usage as the tool loads sequences for batch processing.
- **Help Commands**: Access detailed parameter descriptions for specific subcommands:
  `deepnog infer --help`
  `deepnog train --help`

## Reference documentation
- [DeepNOG GitHub Repository](./references/github_com_univieCUBE_deepnog.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_deepnog_overview.md)