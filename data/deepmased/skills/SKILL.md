---
name: deepmased
description: DeepMAsED is a deep learning toolset designed to identify structural misassemblies in metagenomic contigs by analyzing read alignment features. Use when user asks to validate metagenome assemblies, detect assembly errors, extract read-level features for misassembly prediction, or train custom models for assembly quality assessment.
homepage: https://github.com/leylabmpi/DeepMAsED
---


# deepmased

## Overview

DeepMAsED (Deep learning for Metagenome Assembly Error Detection) is a specialized toolset designed to validate the structural integrity of metagenomic assemblies. By analyzing the alignment of reads back to contigs, it identifies patterns indicative of misassemblies—such as chimeric joins or incorrect scaffolding—that traditional assembly metrics often overlook. The tool is divided into a Snakemake pipeline for dataset generation and a deep learning package for feature extraction and prediction.

## Installation and Setup

The most reliable way to install DeepMAsED is via Bioconda:

```bash
conda create -n deepmased bioconda::deepmased
conda activate deepmased
```

## Core Workflow: Misassembly Detection

To classify contigs as correctly assembled or misassembled, follow this multi-step procedure.

### 1. Input Preparation
You must provide:
- **FASTA file**: The metagenome assembly contigs (uncompressed).
- **BAM file**: Metagenome reads mapped to the contigs. **Note**: BAM files should be sorted and indexed.

### 2. Create the Mapping Table
If processing multiple samples or MAGs, create a tab-delimited file (e.g., `mapping.tsv`) that links BAM files to their corresponding FASTA files. A header is required.

| bam | fasta |
| :--- | :--- |
| sample1.bam | sample1.fasta |
| sample2.bam | sample2.fasta |

### 3. Feature Generation
Extract read-level features (coverage, discordant reads, SNPs, secondary alignments) into a format suitable for the neural network.

```bash
DeepMAsED features mapping.tsv
```
This command generates feature tables and a `feature_file_table` (a list of paths to the generated features), which serves as the input for the prediction step.

### 4. Prediction
Run the classifier using the feature files generated in the previous step.

```bash
DeepMAsED predict feature_file_table.tsv --save-path ./results --force-overwrite
```

**Key Arguments:**
- `--save-path`: Directory where predictions will be stored.
- `--cpu-only`: Use this flag if a GPU is not available; otherwise, the tool attempts to use CUDA.
- `--force-overwrite`: Re-creates intermediate `.pkl` files to ensure data consistency.

## Interpreting Results

The primary output is `deepmased_predictions.tsv`. It contains a `Deepmased_score` for each contig:
- **Scores near 1.0**: High probability of misassembly.
- **Scores near 0.0**: High probability of a correct assembly.

Users should determine a prudent score cutoff based on their specific biome or the stringency required for their analysis (refer to Mineeva et al., 2020 for benchmarked thresholds).

## Advanced Usage: Training and Evaluation

If the pre-trained models are not performing well on specific biomes (e.g., extreme environments), you can train a custom model.

- **Training**: `DeepMAsED train -h`
- **Evaluation**: `DeepMAsED evaluate -h`

For training data generation, use the `DeepMAsED-SM` Snakemake pipeline located in the repository to simulate metagenomes and assemblies with known "true" errors.

## Expert Tips

- **Memory Management**: Feature generation can be memory-intensive for large metagenomes. Ensure your environment has sufficient RAM or process samples individually.
- **BAM Requirements**: Ensure your read mapper (e.g., Bowtie2) is configured to report discordant and supplementary alignments, as these are critical features for the deep learning model.
- **GPU Acceleration**: While `--cpu-only` is supported, prediction and training are significantly faster on systems with NVIDIA GPUs and properly configured TensorFlow/CUDA environments.

## Reference documentation

- [DeepMAsED GitHub Repository](./references/github_com_leylabmpi_DeepMAsED.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_deepmased_overview.md)