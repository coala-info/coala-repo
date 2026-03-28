---
name: neat
description: NEAT is a high-fidelity read simulator that generates genomic data and ground-truth files by learning empirical models from existing datasets. Use when user asks to simulate sequencing reads, generate fragment length or error models, or compare variant calling results against a golden VCF.
homepage: https://github.com/ncsa/NEAT/
---

# neat

## Overview

NEAT (NExt-generation Analysis Toolkit) is a high-fidelity read simulator that produces genomic data mimicking real-world sequencing runs. Unlike simulators that use static error profiles, NEAT can learn empirical models—including fragment length distributions, sequencing errors, and quality scores—directly from existing datasets. It supports both short-read and long-read simulation and outputs "golden" BAM and VCF files, providing an absolute ground truth for testing alignment and variant calling accuracy.

## Native CLI Usage

NEAT is invoked using the `neat` executable followed by specific subcommands. Use `neat --help` to see the full list of available modules.

### Core Simulation
- **read-simulator**: The primary engine for generating simulated reads. It processes a reference FASTA and applies mutation and sequencing models to produce FASTQ, BAM, and VCF outputs.
- **vcf_compare**: A specialized utility to compare a "query" VCF (from a variant caller) against the "golden" VCF produced by NEAT to calculate sensitivity and precision.

### Model Generation Utilities
Before running a simulation, use these tools to create models from real data:
- **model-fraglen**: Extracts fragment length distributions from an existing BAM file.
- **gen-mut-model**: Generates a mutation model based on provided genomic data.
- **model-seq-err**: Learns sequencing error rates and patterns from a BAM file.
- **model-qual-score**: Learns binned quality score distributions from a FASTQ or BAM file.

## Best Practices and Expert Tips

### Performance Optimization
- **Parallelization**: NEAT 4.3+ supports multi-threading. Ensure the `threads` parameter is utilized to significantly speed up the `read-simulator` and VCF processing stages.
- **Logging**: If the output is too verbose, use the `--log-level ERROR` flag to suppress non-critical messages and improve terminal performance.

### Environment and Dependencies
- **Linux Requirement**: NEAT is designed for Linux (tested on Ubuntu). Windows users should use WSL, and MacOS users must remove `libgcc` from the `environment.yml` before installation.
- **VCF Requirements**: `bcftools` must be installed and available in the system PATH if you require NEAT to generate or process VCF files.
- **Data Preparation**: Always ensure the reference FASTA is unzipped (e.g., `gunzip data/H1N1.fa.gz`) before starting a simulation to avoid file-read errors.

### Workflow Pattern
1. **Learn**: Use `model-fraglen` and `model-seq-err` on a high-quality BAM from your target sequencing platform.
2. **Simulate**: Run `read-simulator` using the learned models and a reference genome.
3. **Validate**: Align the resulting FASTQs and call variants, then use `vcf_compare` to measure the pipeline's performance against the NEAT-generated golden VCF.



## Subcommands

| Command | Description |
|---------|-------------|
| neat model-seq-err | Generate sequencing error model from a FASTQ, BAM, or SAM file_list. |
| neat_gen-mut-model | Generate mutation model from a pickle or BED file and user input. |
| neat_model-fraglen | Generate fragment length model from a BAM or SAM file_list. |
| neat_read-simulator | NEAT read simulator |

## Reference documentation
- [The NEAT Project README](./references/github_com_ncsa_NEAT_blob_main_README.md)
- [NEAT ChangeLog and Version History](./references/github_com_ncsa_NEAT_blob_main_ChangeLog.md)
- [Contributing and Testing Guide](./references/github_com_ncsa_NEAT_blob_main_CONTRIBUTING.md)