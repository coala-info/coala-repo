---
name: jaeger-bio
description: Jaeger is a homology-free deep learning tool designed to identify phage genomes and integrated prophages within metagenomic assemblies. Use when user asks to identify viral signals in metagenomes, detect prophages in sequence assemblies, or classify sequences as phage or host without relying on homology.
homepage: https://github.com/Yasas1994/Jaeger
metadata:
  docker_image: "quay.io/biocontainers/jaeger-bio:1.1.30--pyhdfd78af_0"
---

# jaeger-bio

## Overview

Jaeger is a homology-free machine learning tool designed for the rapid and accurate identification of phage genomes hidden in metagenomes. It utilizes deep learning to detect both free-living phages and integrated prophages within sequence assemblies. Use this skill when you need to process .fasta files (compressed or uncompressed) to extract viral signals from complex microbial communities without relying on traditional homology-based searches.

## Installation and Setup

Jaeger can be installed via Conda or Pip. GPU support is highly recommended for performance.

### Conda (Bioconda)
```bash
mamba create -n jaeger -c bioconda jaeger-bio
conda activate jaeger
```

### Pip (Hardware Specific)
- **GPU Support**: `pip install jaeger-bio[gpu]` (Requires CUDA Toolkit and cuDNN)
- **CPU Only**: `pip install jaeger-bio[cpu]`
- **Apple Silicon**: `pip install jaeger-bio[darwin-arm]`

### Verification
Always verify the installation before running large jobs:
```bash
jaeger test
```

## Model Management

Starting with version 1.2.0, models must be managed separately.

1.  **List available models**:
    ```bash
    jaeger download --list
    ```
2.  **Download a specific model**:
    ```bash
    jaeger download --model jaeger_57341_1.5M_fragment --path /path/to/models
    ```
3.  **Register a custom model path**:
    If you store models in a non-default directory, register it so Jaeger can find them:
    ```bash
    jaeger register-models --path /path/to/models
    ```

## Running Predictions

The primary command for phage detection is `predict`.

### Basic Usage
```bash
jaeger predict -i input_assembly.fasta -o output_directory
```

### Advanced Parameters
- **Batch Size**: Control parallel computations. The default is 96.
  - If you encounter Out-of-Memory (OOM) errors, lower the batch size (e.g., `--batch 32`).
  - A batch size of 96 is typically suitable for a GPU with 4GB of VRAM.
- **Model Selection**: Specify a specific model if multiple are registered.
  ```bash
  jaeger predict -i input.fasta -o results --model jaeger_38341_1.4M
```

## Interpreting Results

Output is generated as a TSV file: `output_dir/<input_file>_default.jaeger.tsv`.

Key columns to analyze:
- **prediction**: The classification (e.g., Phage, Prophage, or Host).
- **entropy**: A measure of prediction uncertainty (lower values typically indicate higher confidence).
- **window_summary**: A condensed view of the prediction across the contig.
- **terminal_repeats**: Indicates potential circularity or specific phage packaging.

## Expert Tips

- **Input Formats**: Jaeger accepts both uncompressed `.fasta` and compressed `.fasta.gz` files directly.
- **Prophage Detection**: Jaeger is specifically trained to identify prophage regions within larger bacterial contigs, making it superior to tools that only look for complete viral genomes.
- **Container Usage**: If running on a cluster via Apptainer/Singularity, use the `--nv` flag to ensure the container can access the host GPU:
  ```bash
  apptainer run --nv jaeger.sif jaeger predict -i input.fasta -o output
  ```

## Reference documentation
- [Jaeger GitHub Repository](./references/github_com_Yasas1994_Jaeger.md)
- [Bioconda jaeger-bio Overview](./references/anaconda_org_channels_bioconda_packages_jaeger-bio_overview.md)