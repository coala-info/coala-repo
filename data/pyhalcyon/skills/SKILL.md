---
name: pyhalcyon
description: Pyhalcyon is a deep learning basecaller that translates raw nanopore sequencing signals into nucleotide sequences. Use when user asks to basecall nanopore reads, convert fast5 signal data to FASTQ format, or perform sequence translation using an encoder-decoder model with monotonic attention.
homepage: https://pypi.org/project/pyhalcyon
metadata:
  docker_image: "quay.io/biocontainers/pyhalcyon:0.1.1--py_0"
---

# pyhalcyon

## Overview
Pyhalcyon is a specialized basecalling tool that utilizes a deep learning architecture (encoder-decoder with monotonic attention) to translate raw electrical signals from nanopore sequencing into nucleotide sequences. It serves as an alternative to standard basecallers like Guppy or Bonito, focusing on high accuracy through its specific attention mechanism.

## Usage Guidelines

### Environment Setup
Ensure the tool is installed via bioconda to manage dependencies effectively:
```bash
conda install -c bioconda pyhalcyon
```

### Core Workflow
The primary function of pyhalcyon is to process raw signal data. While specific CLI flags may vary by version, the standard execution pattern involves:

1.  **Input Preparation**: Ensure your raw signal data (typically in `.fast5` format) is organized in a single directory.
2.  **Model Selection**: Identify the appropriate pre-trained model compatible with your flowcell and kit type (e.g., R9.4.1).
3.  **Execution**: Run the basecaller pointing to your input directory and specifying an output path for the resulting FASTQ files.

### Best Practices
*   **GPU Acceleration**: Like most deep-learning basecallers, pyhalcyon is computationally intensive. Always run on a system with a compatible NVIDIA GPU and updated CUDA drivers to ensure viable processing speeds.
*   **Batch Processing**: If dealing with large datasets, process in batches to manage memory overhead.
*   **Data Integrity**: Verify that input fast5 files are not corrupted and contain the raw signal slot, as the encoder-decoder model relies entirely on the signal trace.

## Reference documentation
- [PyPI Project Page](./references/pypi_org_project_pyhalcyon.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_pyhalcyon_overview.md)