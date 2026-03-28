---
name: segalign-galaxy
description: SegAlign is a GPU-accelerated system for performing pairwise whole genome alignments and repeat masking. Use when user asks to perform pairwise genome alignments, mask repetitive sequences using GPUs, or run SegAlign via Docker.
homepage: https://github.com/gsneha26/SegAlign
---


# segalign-galaxy

## Overview
SegAlign is a scalable GPU-based system designed for pairwise whole genome alignments. It implements the seed-filter-extend paradigm popularized by LASTZ, offloading computationally intensive steps to the GPU to significantly reduce processing time. The skill covers the primary alignment workflow and the specialized repeat masking utility, focusing on command-line execution and data preparation.

## Data Preparation
SegAlign requires input sequences in FASTA format. If your genomic data is in `.2bit` format, you must convert it using `twoBitToFa` (from kentUtils) before running the alignment.

```bash
# Convert 2bit to FASTA
twoBitToFa target.2bit target.fa
twoBitToFa query.2bit query.fa
```

## Pairwise Whole Genome Alignment
The primary command for alignment is `run_segalign`. It requires a target and a query file.

**Basic Syntax:**
```bash
run_segalign target.fa query.fa [options]
```

**Common Pattern:**
```bash
run_segalign human_chr1.fa mouse_chr1.fa --output=alignment_results.maf
```

**Key Options:**
- `--output`: Specify the output file path (typically .maf).
- `--help`: View all available parameters, including scoring matrices and filtering thresholds.

## Repeat Masking
For identifying and masking repetitive sequences using GPU acceleration, use the `run_segalign_repeat_masker` utility.

**Basic Syntax:**
```bash
run_segalign_repeat_masker sequence.fa --output=masked_output.seg
```

## Docker and Container Usage
When running SegAlign via Docker, you must ensure the container has access to the host GPU.

**Alignment via Docker:**
```bash
docker run --ipc=host --gpus all -v $(pwd):/data -it gsneha/segalign:v0.1.2 \
           run_segalign \
           /data/target.fa \
           /data/query.fa \
           --output=/data/output.maf
```

**Repeat Masking via Docker:**
```bash
docker run --ipc=host --gpus all -v $(pwd):/data -it gsneha/segalign:v0.1.2 \
           run_segalign_repeat_masker \
           /data/sequence.fa \
           --output=/data/output.seg
```

## Expert Tips and Best Practices
- **GPU Requirements**: Ensure NVIDIA CUDA 10.2 toolkit is installed and the GPU is accessible. On AWS, use G3 or P3 instances for optimal performance.
- **Memory Management**: Use `--ipc=host` when running in Docker to prevent shared memory issues during large-scale alignments.
- **Input Validation**: Always verify that your FASTA headers are clean and that the files are not corrupted, as GPU kernels are sensitive to input formatting.
- **Parallelization**: SegAlign is designed to be scalable; for multiple pairwise alignments, consider using `parallel` to manage multiple `run_segalign` instances across available GPUs.



## Subcommands

| Command | Description |
|---------|-------------|
| run_segalign | Run segalign with specified target and query files. |
| segalign_repeat_masker | You must specify a sequence file |

## Reference documentation
- [SegAlign GitHub Repository](./references/github_com_gsneha26_SegAlign.md)
- [SegAlign README](./references/github_com_gsneha26_SegAlign_blob_main_README.md)
- [SegAlign Dockerfile](./references/github_com_gsneha26_SegAlign_blob_main_Dockerfile.md)