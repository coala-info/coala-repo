---
name: noise2read
description: noise2read is a machine learning-based tool designed to denoise and correct errors in short-read sequencing data. Use when user asks to correct sequencing reads, denoise FASTA or FASTQ files, or evaluate the accuracy of read correction results.
homepage: https://github.com/Jappy0/noise2read
---


# noise2read

## Overview
noise2read is a specialized tool for denoising sequencing data. It operates on the principle that rare sequences are often erroneous versions of high-abundance sequences. By applying graph learning on edit distances and utilizing machine learning (XGBoost with Optuna for hyperparameter tuning), it restores erroneous reads to their true state without introducing synthetic sequences. This skill provides the necessary CLI patterns to perform read correction and evaluate the accuracy of the results.

## Installation
The tool is available via Bioconda:
```bash
conda install bioconda::noise2read
```

## Core Workflows

### 1. Read Correction
The primary function of noise2read is to correct errors in FASTA/FASTQ files. You can run correction using a configuration file or by specifying input parameters directly.

**Using a configuration file:**
```bash
noise2read -m correction -c path/to/config.ini -a True -g gpu_hist
```

**Direct input correction:**
```bash
noise2read -m correction -i input_reads.fasta -a False -d ./output_directory/
```

### 2. Performance Evaluation
If you have a "true" reference set (e.g., from simulated data), use the evaluation mode to benchmark the correction quality.
```bash
noise2read -m evaluation -i raw_reads.fa -t true_reads.fa -r corrected_reads.fasta -d ./eval_results
```

## CLI Parameter Guide
- `-m`: Mode selection (`correction` or `evaluation`).
- `-c`: Path to a `.ini` configuration file containing tool parameters.
- `-i`: Path to the input sequence file.
- `-a`: High ambiguous errors correction (`True` or `False`). Enable this for complex datasets where errors might map to multiple potential origins.
- `-g`: Training method. Use `gpu_hist` to enable GPU acceleration for faster model training.
- `-d`: Output directory for results and logs.

## Best Practices and Expert Tips
- **GPU Acceleration**: Training the underlying classifiers is computationally intensive. Always use `-g gpu_hist` if a compatible GPU is available to reduce runtime significantly (e.g., from hours to minutes).
- **Config Files**: For reproducible research, prefer using `.ini` configuration files. This allows you to fine-tune XGBoost estimators and Optuna trial counts.
- **Read Length**: Ensure your reads are shorter than 300bp, as the tool is optimized for short-read sequencing technologies.
- **Stability**: Note that because the tool uses automatic hyperparameter tuning, results may vary slightly between runs. However, the final predicted sequences remain stable within a narrow range.
- **High Ambiguity**: Use `-a True` when dealing with datasets known to have high sequence similarity or complex error profiles, such as certain UMI or miRNA datasets.

## Reference documentation
- [noise2read GitHub Repository](./references/github_com_JappyPing_noise2read.md)
- [noise2read Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_noise2read_overview.md)