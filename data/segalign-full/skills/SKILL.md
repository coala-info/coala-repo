---
name: segalign-full
description: SegAlign is a high-performance genomic alignment tool designed to leverage NVIDIA GPUs to accelerate the comparison of whole genomes.
homepage: https://github.com/gsneha26/SegAlign
---

# segalign-full

## Overview
SegAlign is a high-performance genomic alignment tool designed to leverage NVIDIA GPUs to accelerate the comparison of whole genomes. It implements the seed-filter-extend paradigm used by LASTZ but provides significant speedups through parallelization on GPU architectures. This skill should be used when you need to perform pairwise alignments or repeat masking on large genomic datasets where traditional CPU-based tools like LASTZ are too slow.

## Installation
The most reliable way to install the tool is via Bioconda:
```bash
conda install bioconda::segalign-full
```

## Core Workflows

### 1. Pairwise Whole Genome Alignment
The primary command for alignment is `run_segalign`. It requires a target genome and a query genome in FASTA format.

**Basic Pattern:**
```bash
run_segalign target.fa query.fa --output=alignments.maf
```

**Common Options:**
- `--output`: Specify the output file (defaults to MAF format).
- `--help`: View all available scoring and filtering parameters.

### 2. Repeat Masking
Before alignment, it is often necessary to identify and mask repetitive elements using `run_segalign_repeat_masker`.

**Basic Pattern:**
```bash
run_segalign_repeat_masker sequence.fa --output=masked_intervals.seg
```

## Expert Tips and Best Practices

### Data Preparation
SegAlign often works alongside `kentUtils`. If your source data is in `.2bit` format, convert it to FASTA first:
```bash
twoBitToFa genome.2bit genome.fa
```

### GPU Execution via Docker
When running SegAlign in a Docker container, specific flags are required to ensure the container can access the GPU and shared memory:
- Use `--gpus all` to enable CUDA support.
- Use `--ipc=host` to prevent memory allocation errors during the "extend" phase.

**Example Docker Command:**
```bash
docker run --ipc=host --gpus all -v $(pwd):/data gsneha/segalign:v0.1.2 \
run_segalign /data/target.fa /data/query.fa --output=/data/output.maf
```

### Hardware Requirements
- **GPU**: Tested on AWS G3 and P3 instances (NVIDIA Tesla M60, V100).
- **CUDA**: Requires CUDA 10.2 or compatible drivers.
- **Memory**: Ensure sufficient system RAM for the Intel TBB library to manage parallel tasks effectively.

### Troubleshooting
- **Command Not Found**: If installed via Conda, ensure the environment is active. If using the source build, ensure the `scripts` directory is in your `$PATH`.
- **Segmentation Faults**: Often caused by insufficient GPU memory or missing `--ipc=host` flag in containerized environments.

## Reference documentation
- [SegAlign Overview](./references/anaconda_org_channels_bioconda_packages_segalign-full_overview.md)
- [SegAlign GitHub Documentation](./references/github_com_gsneha26_SegAlign.md)