---
name: ampd-up
description: AMPd-Up is a bioinformatics tool that uses recurrent neural networks for the de novo generation of synthetic antimicrobial peptide sequences. Use when user asks to generate antimicrobial peptides, train models on custom peptide data, or sample sequences from pre-trained model weights.
homepage: https://github.com/bcgsc/AMPd-Up
---


# ampd-up

## Overview

AMPd-Up is a specialized bioinformatics tool for the de novo generation of antimicrobial peptide sequences. It utilizes a recurrent neural network architecture to learn the underlying grammar of known antimicrobial peptides and produce synthetic sequences that mimic these properties. The tool is highly flexible, allowing users to either generate sequences by training new models on the fly or by utilizing pre-trained model weights for rapid sampling. It is a key resource for researchers in computational biology and drug discovery focused on overcoming antibiotic resistance through synthetic peptide design.

## Installation and Environment

AMPd-Up is primarily distributed via Bioconda. It requires a specific environment to handle its dependencies (Python 3.6 and PyTorch 1.7.1).

```bash
# Recommended setup
conda create -n ampd-up python=3.6
conda activate ampd-up
conda install -c bioconda ampd-up
```

## Command Line Usage

The primary command is `AMPd-Up`. You must always specify the number of sequences to generate.

### Basic Sequence Generation
To generate sequences by training a new model instance using the default internal training set:
```bash
AMPd-Up -n 100
```

### Sampling from Pre-trained Models
If you have downloaded pre-trained model instances (e.g., from the Zenodo repository associated with the publication), point the tool to that directory:
```bash
AMPd-Up -fm ./models/ -n 500
```

### Training with Custom Data
To train the RNN on your own specific set of peptide sequences (must be in FASTA format):
```bash
AMPd-Up -tr my_peptides.fasta -n 100 -sm my_custom_model
```

### Output Configuration
By default, the tool outputs a TSV file. You can change the format and specify an output directory:
```bash
AMPd-Up -n 100 -od ./output_results -of fasta
```

## Argument Reference

| Argument | Description |
| :--- | :--- |
| `-n`, `--num_seq` | **Required.** Number of sequences to sample/generate. |
| `-fm`, `--from_model` | Directory containing existing models to sample from. |
| `-tr`, `--amp_train` | Path to a FASTA file containing custom training data. |
| `-sm`, `--save_model` | Prefix for saving the models generated during the session. |
| `-od`, `--out_dir` | Directory where results will be saved. |
| `-of` | Output format: `tsv` (default) or `fasta`. |

## Expert Tips

*   **Model Diversity**: The publication utilized 1,000 model instances. When sampling for high-quality candidates, it is often better to sample smaller amounts from many different model instances rather than a large amount from a single model to ensure sequence diversity.
*   **Data Preparation**: If using the `-tr` flag for custom training, ensure your FASTA file is clean and contains only valid amino acid characters. The RNN is sensitive to the quality and consistency of the input training set.
*   **Resource Management**: Training new models on the fly (the default behavior when `-fm` is not provided) is computationally more intensive than sampling from existing models. For large-scale generation, use pre-trained models.

## Reference documentation
- [AMPd-Up GitHub Repository](./references/github_com_bcgsc_AMPd-Up.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_ampd-up_overview.md)