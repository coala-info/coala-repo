---
name: tiberius
description: Tiberius is an end-to-end gene prediction tool that integrates convolutional and long short-term memory (LSTM) layers with a differentiable Hidden Markov Model (HMM) layer.
homepage: https://github.com/Gaius-Augustus/Tiberius
---

# tiberius

## Overview

Tiberius is an end-to-end gene prediction tool that integrates convolutional and long short-term memory (LSTM) layers with a differentiable Hidden Markov Model (HMM) layer. It is designed to predict gene structures from genomic sequences with high accuracy, rivaling tools that require extrinsic evidence. It supports multiple execution modes, including a standard ab initio mode, an evidence-based pipeline for integrating RNA-Seq or protein data, and a mode utilizing evolutionary information via ClaMSA.

## Installation and Setup

Tiberius requires a local launcher script even when using containers.

1.  **Clone and Install Launcher**:
    ```bash
    git clone https://github.com/Gaius-Augustus/Tiberius
    cd Tiberius
    pip install .
    ```
2.  **Container Execution (Recommended)**: Use the `--singularity` flag to automatically manage dependencies like TensorFlow and CUDA.

## Command Line Usage

### Basic Ab Initio Prediction
To predict genes from a FASTA file using a pre-trained model:
```bash
python tiberius.py --singularity --genome input.fasta --model_cfg mammalia_softmasking_v2 --out output.gtf
```

### Model Management
View all available pre-trained models for different clades:
```bash
python tiberius.py --list_cfg
```
Common clades include: `mammalia`, `vertebrates`, `insecta`, `eudicotyledons`, `monocotyledonae`, `fungi`, `diatoms`, and `chlorophyta`.

### Generating Sequences
To extract coding and protein sequences along with the GTF annotation:
```bash
python tiberius.py --genome input.fasta --model_cfg <model> --out output.gtf --codingseq cds.fasta --protseq protein.fasta
```

## Expert Tips and Best Practices

*   **GPU Acceleration**: A GPU with at least 8 GB of VRAM is strongly recommended. While Tiberius runs on CPU, performance will be significantly slower.
*   **TensorFlow Versioning**: Tiberius is optimized for TensorFlow 2.10. If running locally with TensorFlow > 2.10, the default sequence length may trigger warnings or reduce accuracy. To mitigate this, explicitly set the sequence length:
    ```bash
    python tiberius.py --seq_len 259992 ...
    ```
*   **Soft-masking**: Ensure your genome assembly is soft-masked if using a model configuration that specifies soft-masking (e.g., `mammalia_softmasking_v2`) to achieve optimal prediction results.
*   **Parallelization**: For large-scale genomic data or HPC environments, use the Nextflow integration by providing a configuration file:
    ```bash
    python tiberius.py --nf_config hpc.config --genome input.fasta --model_cfg <model>
    ```

## Reference documentation
- [Tiberius Overview](./references/anaconda_org_channels_bioconda_packages_tiberius_overview.md)
- [Tiberius GitHub Repository](./references/github_com_Gaius-Augustus_Tiberius.md)