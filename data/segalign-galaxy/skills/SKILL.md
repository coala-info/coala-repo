---
name: segalign-galaxy
description: SegAlign is a GPU-accelerated genomic alignment tool that performs large-scale pairwise whole-genome alignments and repeat masking. Use when user asks to perform pairwise whole-genome alignments, identify repetitive elements, or accelerate the LASTZ algorithm using GPUs.
homepage: https://github.com/gsneha26/SegAlign
---


# segalign-galaxy

## Overview

SegAlign is a high-performance genomic alignment tool designed to leverage GPU acceleration for the LASTZ seed-filter-extend algorithm. It is optimized for large-scale comparative genomics, providing a scalable solution for whole-genome alignments that would otherwise be computationally prohibitive on CPU-only systems. The tool includes two primary components: a core aligner for pairwise comparisons and a specialized repeat masker for identifying repetitive elements.

## Command Line Usage

### Pairwise Whole Genome Alignment
Use `run_segalign` to perform alignments between a target and query genome.

```bash
run_segalign target.fa query.fa --output=output_filename.maf [options]
```

### Repeat Masking
Use `run_segalign_repeat_masker` to identify and mask repetitive sequences in a genome.

```bash
run_segalign_repeat_masker sequence.fa --output=output_filename.seg [options]
```

## Best Practices and Expert Tips

### Input Preparation
* **Format Conversion**: SegAlign typically operates on FASTA files. If your source data is in `.2bit` format, use `twoBitToFa` from the kentUtils suite to convert it before running SegAlign.
* **Sequence Masking**: For better alignment quality and performance, run the `run_segalign_repeat_masker` on your sequences before performing the final alignment.

### GPU Optimization and Docker
* **Shared Memory**: When running via Docker, always include the `--ipc=host` flag. This prevents "out of memory" errors related to GPU-host communication and shared memory segments.
* **GPU Access**: Ensure the `--gpus all` flag is passed to the Docker container to allow the tool to utilize the available hardware acceleration.
* **Environment**: SegAlign is optimized for NVIDIA CUDA 10.2. If running natively, ensure the CUDA toolkit binaries are in your `$PATH`.

### Performance Tuning
* **Batching**: If encountering memory issues on smaller GPU instances, consider breaking large genomes into smaller scaffolds or chromosomes, though SegAlign is designed to handle whole genomes.
* **Help Documentation**: Access the full list of heuristic parameters (similar to LASTZ) by running the commands with the `--help` flag.

## Reference documentation
- [SegAlign Main Repository and Usage](./references/github_com_gsneha26_SegAlign.md)
- [SegAlign Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_segalign-galaxy_overview.md)