---
name: segalign-full
description: SegAlign is a GPU-accelerated system designed for high-performance pairwise whole-genome alignments and repeat masking. Use when user asks to perform pairwise genome alignment, identify repetitive sequences, or run GPU-accelerated sequence comparisons.
homepage: https://github.com/gsneha26/SegAlign
---

# segalign-full

## Overview

SegAlign is a high-performance, GPU-accelerated system designed for pairwise whole-genome alignments. It implements the seed-filter-extend paradigm used by LASTZ but leverages GPU parallelization to significantly reduce processing time. This skill provides the necessary command-line patterns to execute both the primary alignment tool (`run_segalign`) and the specialized repeat masking tool (`run_segalign_repeat_masker`). It is particularly effective on AWS G3 and P3 instances or any environment equipped with NVIDIA CUDA-enabled GPUs.

## Core Workflows

### 1. Preparing Genomic Data
SegAlign requires input sequences in FASTA format. If your data is in `.2bit` format, use the included `kentUtils` to convert them first.

```bash
# Convert 2bit to FASTA
twoBitToFa target.2bit target.fa
twoBitToFa query.2bit query.fa
```

### 2. Pairwise Genome Alignment
Use `run_segalign` to align a query genome against a target genome.

```bash
# Basic alignment
run_segalign target.fa query.fa --output=alignment_results.maf

# View all available parameters
run_segalign --help
```

### 3. GPU-Accelerated Repeat Masking
Use `run_segalign_repeat_masker` to identify and mask repetitive sequences within a single genome.

```bash
# Basic repeat masking
run_segalign_repeat_masker sequence.fa --output=masked_output.seg

# View all available parameters
run_segalign_repeat_masker --help
```

## Expert Tips and Best Practices

*   **GPU Environment**: Ensure the environment has NVIDIA CUDA 10.2+ installed. If using Docker, always include the `--gpus all` and `--ipc=host` flags to allow the container to access the hardware and shared memory correctly.
*   **Output Formats**: The default output for alignments is often MAF (Multiple Alignment Format). Ensure you have sufficient disk space as whole-genome MAF files can become quite large.
*   **Performance Tuning**: SegAlign is optimized for AWS G3 and P3 instances. If running on custom hardware, ensure the `arch` flag in the build configuration matches your GPU architecture (default is `sm_52`).
*   **Dependency Management**: If running natively, ensure `LASTZ`, `parallel`, and `zlib` are in your system PATH, as `run_segalign` acts as a wrapper that coordinates these components.



## Subcommands

| Command | Description |
|---------|-------------|
| run_segalign | You must specify a target file and a query file |
| segalign_repeat_masker | You must specify a sequence file |

## Reference documentation
- [SegAlign GitHub README](./references/github_com_gsneha26_SegAlign_blob_main_README.md)
- [SegAlign Docker Configuration](./references/github_com_gsneha26_SegAlign_blob_main_Dockerfile.md)
- [SegAlign Build Configuration](./references/github_com_gsneha26_SegAlign_blob_main_CMakeLists.txt.md)