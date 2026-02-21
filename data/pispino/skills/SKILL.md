---
name: pispino
description: PISPINO (PIpits SPIN-Off tools) is a specialized bioinformatics toolkit designed to streamline the initial handling of demultiplexed Illumina FASTQ files.
homepage: https://github.com/hsgweon/pispino
---

# pispino

## Overview

PISPINO (PIpits SPIN-Off tools) is a specialized bioinformatics toolkit designed to streamline the initial handling of demultiplexed Illumina FASTQ files. It automates the creation of sample-to-file mappings and executes sequence preparation tasks including quality control and read joining. This tool is essential for researchers needing to transform raw sequencer output into a clean, merged format ready for downstream taxonomic assignment or OTU clustering.

## Installation and Environment

PISPINO is designed for Linux and macOS and requires Python 3. It is best managed via Conda to ensure all dependencies are correctly resolved.

```bash
# Setup channels (if not already configured)
conda config --add channels defaults
conda config --add channels conda-forge
conda config --add channels bioconda

# Create and activate environment
conda create -n pispino_env python=3.6 pispino
source activate pispino_env
```

## Core Workflow

The PISPINO workflow consists of two primary steps: generating a metadata list and processing the sequences.

### 1. Generate Read Pairs List
Use `pispino_createreadpairslist` to scan a directory of raw FASTQ files and automatically generate a tab-delimited mapping file.

```bash
pispino_createreadpairslist -i <input_directory> -o readpairslist.txt
```
*   **Input (`-i`)**: A directory containing demultiplexed FASTQ files (supports `.gz`, `.bzip2`, or uncompressed).
*   **Output (`-o`)**: A text file specifying sample names and their corresponding forward/reverse read files.

### 2. Sequence Preparation
Use `pispino_seqprep` to perform quality filtering and join paired-end reads based on the list generated in the previous step.

```bash
pispino_seqprep -i <input_directory> -o <output_directory> -l readpairslist.txt
```
*   **List (`-l`)**: The mapping file created in step 1.
*   **Output (`-o`)**: The directory where processed, merged sequences will be stored.

## Expert Tips and Best Practices

*   **Manual Verification**: Always inspect the `readpairslist.txt` file before running `pispino_seqprep`. Ensure that the tool has correctly identified the forward and reverse pairs, especially if your file naming convention is non-standard.
*   **Help Documentation**: Access specific parameter options for the preparation tool by running `pispino_seqprep -h`.
*   **Downstream Compatibility**: The output of PISPINO is formatted to be directly compatible with PIPITS and QIIME, making it an ideal "drop-in" preprocessing layer for these pipelines.
*   **Cleanup**: After processing is complete, you can exit the environment using `source deactivate`.

## Reference documentation
- [PISPINO Overview](./references/anaconda_org_channels_bioconda_packages_pispino_overview.md)
- [PISPINO GitHub Repository](./references/github_com_hsgweon_pispino.md)