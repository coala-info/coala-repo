---
name: deepnog
description: DeepNOG uses deep convolutional neural networks to assign protein sequences to orthologous groups. Use when user asks to infer orthologous groups for protein sequences, train custom protein classification models, or target specific taxonomic levels for protein annotation.
homepage: https://github.com/univieCUBE/deepnog
---

# deepnog

## Overview

DeepNOG is a specialized bioinformatics tool that leverages deep convolutional neural networks to assign protein sequences to orthologous groups (OGs). It serves as a high-performance alternative to alignment-based methods like HMMER, offering comparable accuracy with significantly faster processing speeds. This skill provides the procedural knowledge required to perform inference on FASTA files, manage taxonomic levels, and train custom models for specific protein databases.

## Core Workflows

### Protein Orthologous Group Inference

The primary use case for DeepNOG is predicting the orthologous group for a set of protein sequences.

*   **Basic Inference**: Run prediction on a FASTA file using the default eggNOG 5 bacteria level.
    ```bash
    deepnog infer proteins.faa --out prediction.csv
    ```
*   **Taxonomic Specificity**: Target a specific taxonomic level using the `-t` (tax) and `-db` flags.
    ```bash
    # Example: Target Gammaproteobacteria (TaxID 1236)
    deepnog infer proteins.faa -db eggNOG5 -t 1236
    ```
*   **Confidence Filtering**: Use the `-c` flag to discard predictions that fall below a specific probability threshold.
    ```bash
    deepnog infer proteins.faa -c 0.95
    ```

### Model Training

DeepNOG allows for the creation of custom models if the pre-computed ones do not meet your specific taxonomic or database needs.

*   **Standard Training**: Requires training/validation sequences (FASTA) and their corresponding group assignments (CSV).
    ```bash
    deepnog train train.fa val.fa train.csv val.csv -e 15 --shuffle -db eggNOG5 -t 3 -o ./output_models
    ```
*   **Reproducibility**: Always set a random seed (`-r`) when training to ensure consistent results across runs.

## Expert Tips and Best Practices

*   **Data Management**: DeepNOG downloads models automatically to `~/deepnog_data/`. If working in a restricted environment or a cluster with shared storage, redirect this using the `DEEPNOG_DATA` environment variable.
*   **Performance Tuning**: Use the `-V` flag (verbosity) to monitor progress during long-running inference tasks. `-V 3` provides a detailed report.
*   **File Formats**: While DeepNOG supports various formats via Biopython's SeqIO, FASTA (raw, .gz, or .xz) is the only format officially tested and preferred for stability.
*   **Hardware Acceleration**: DeepNOG automatically detects and utilizes GPUs via PyTorch. Ensure your environment has the appropriate CUDA drivers if performance is a bottleneck.



## Subcommands

| Command | Description |
|---------|-------------|
| deepnog train | Train a DeepNOG model. |
| deepnog_infer | Infer orthologous groups for protein sequences. |

## Reference documentation

- [DeepNOG GitHub Repository](./references/github_com_univieCUBE_deepnog_blob_master_README.md)
- [DeepNOG Bioconda Package](./references/anaconda_org_channels_bioconda_packages_deepnog_overview.md)