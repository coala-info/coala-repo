---
name: deepchopper-cli
description: DeepChopper is a genomic language model specifically designed to mitigate chimera artifacts in Nanopore direct RNA sequencing.
homepage: https://github.com/ylab-hi/DeepChopper
---

# deepchopper-cli

## Overview

DeepChopper is a genomic language model specifically designed to mitigate chimera artifacts in Nanopore direct RNA sequencing. Chimeras are artificial sequences created during the sequencing process that can lead to incorrect biological interpretations. This skill enables a streamlined two-step workflow—prediction and chopping—to transform raw FASTQ data into high-quality, artifact-free sequences. It supports modern genomic data formats, including compressed FASTQ files, and leverages GPU acceleration for high-throughput processing.

## Installation and Setup

DeepChopper requires Python 3.10 or later. It can be installed via pip or Conda:

```bash
# Via pip
pip install deepchopper

# Via Conda
conda install bioconda::deepchopper-cli
```

## Core Workflow

Starting with version 1.3.0, DeepChopper processes FASTQ files directly. The legacy `encode` step has been removed.

### 1. Prediction
The `predict` command analyzes the FASTQ file and identifies potential chimeric regions.

```bash
deepchopper predict input.fastq.gz --output predictions_dir
```

**Expert Tips for Prediction:**
- **GPU Acceleration**: For large datasets, always use the `--gpus` flag to specify the number of GPUs.
  ```bash
  deepchopper predict input.fastq --output predictions --gpus 2
  ```
- **Format Support**: The tool automatically detects `.fastq`, `.fq`, `.fastq.gz`, and `.fq.gz`.

### 2. Chopping
The `chop` command uses the output from the prediction step to physically trim or split the original sequences.

```bash
deepchopper chop predictions_dir/0 input.fastq.gz --output chopped_output.fastq
```

## Command Reference

- `deepchopper predict`: Runs the genomic language model to detect artifacts.
- `deepchopper chop`: Applies prediction results to the source FASTQ to produce cleaned reads.
- `deepchopper web`: Launches a local web-based GUI for small-scale testing (limited to one FASTQ record at a time).

## Best Practices

- **Workflow Continuity**: Ensure the input FASTQ file used in the `chop` command is identical to the one used in the `predict` command to maintain coordinate consistency.
- **Resource Management**: When running on clusters, ensure the environment has access to the `yangliz5/deepchopper` pre-trained model, which is typically downloaded automatically on the first run.
- **Large Scale Processing**: For production pipelines, use the CLI over the Web GUI, as the GUI is intended for demonstration and single-record inspection.

## Reference documentation
- [DeepChopper GitHub Repository](./references/github_com_ylab-hi_DeepChopper.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_deepchopper-cli_overview.md)