---
name: seqnado
description: Seqnado is a bioinformatics wrapper that simplifies the execution of diverse sequencing pipelines for epigenetic and transcriptomic data. Use when user asks to process RNA-seq, ATAC-seq, ChIP-seq, CUT&RUN, WGS, methylation, CRISPR, or Micro-Capture-C datasets.
homepage: https://alsmith151.github.io/SeqNado/
---


# seqnado

## Overview
seqnado is a comprehensive bioinformatics wrapper designed to simplify the execution of various sequencing pipelines. It provides a standardized interface for processing raw sequencing reads into analysis-ready files across multiple modalities. It is particularly useful for researchers looking for a "one-stop" tool to handle diverse epigenetic and transcriptomic datasets without managing individual pipeline dependencies manually.

## Usage Guidelines

### Core Command Structure
The primary entry point for the tool is the `seqnado` command followed by the specific pipeline name and required arguments.

```bash
seqnado <pipeline> [options]
```

### Supported Pipelines
- **RNA-seq**: Transcriptome profiling and quantification.
- **ATAC-seq / ChIP-seq**: Chromatin accessibility and protein-DNA interaction mapping.
- **CUT&RUN / CUT&TAG**: Low-input chromatin profiling.
- **WGS**: Whole genome sequencing analysis.
- **Methylation**: Support for Bisulphite and TAPS (TET-assisted pyridine borane sequencing).
- **CRISPR**: Analysis of CRISPR screens.
- **Micro-Capture-C**: High-resolution chromosome conformation capture.

### Common CLI Patterns
- **Installation**: Ensure the environment is ready using Conda:
  `conda install -c bioconda seqnado`
- **Help**: Access specific pipeline options using the help flag:
  `seqnado <pipeline> --help`

### Best Practices
- **Environment Management**: Always run seqnado within a dedicated Conda environment to avoid dependency conflicts with other bioinformatics tools.
- **Resource Allocation**: When running on a cluster or high-performance computing (HPC) system, ensure you specify thread counts and memory limits compatible with the specific pipeline's requirements.
- **Reference Genomes**: Ensure that paths to reference genomes and indices are correctly mapped before initiating long-running pipelines.

## Reference documentation
- [seqnado Overview](./references/anaconda_org_channels_bioconda_packages_seqnado_overview.md)