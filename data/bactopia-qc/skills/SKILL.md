---
name: bactopia-qc
description: Bactopia-qc performs quality assessment, adapter trimming, and filtering of raw sequencing reads for bacterial genomics. Use when user asks to process raw reads, perform quality control, or prepare sequencing data for assembly.
homepage: https://bactopia.github.io/
metadata:
  docker_image: "quay.io/biocontainers/bactopia-qc:1.0.3--hdfd78af_0"
---

# bactopia-qc

## Overview
The `bactopia-qc` skill focuses on the initial processing and quality assessment of raw sequencing reads. This tool is a specialized component of the Bactopia pipeline designed to ensure that only high-quality data proceeds to assembly. It automates tasks such as adapter trimming, quality filtering, and generating summary statistics, providing a standardized foundation for bacterial comparative genomics.

## Common CLI Patterns
The tool is typically invoked as part of the broader Bactopia environment or as a standalone utility from Bioconda.

### Basic Quality Control
To run the standard QC workflow on a set of paired-end reads:
```bash
bactopia --samples samples.txt --check_fastqc
```
*Note: While `bactopia-qc` provides the methods, it is most commonly executed via the main `bactopia` entry point using the `gather` and `qc` steps.*

### Installation via Conda
If the tool is not present, it can be installed using:
```bash
conda install -c bioconda bactopia-qc
```

## Expert Tips and Best Practices
- **Input Validation**: Always use a `samples.txt` file (tab-delimited) to manage multiple datasets. This ensures the QC process maps correctly to sample identifiers.
- **Resource Management**: Since QC involves compute-intensive tasks like FastQC and trimming, utilize Nextflow's profile support (e.g., `-profile docker` or `-profile conda`) to manage dependencies and memory allocation.
- **Reviewing Outputs**: After execution, prioritize checking the `bactopia-report.html`. This file aggregates the `bactopia-qc` results, allowing you to quickly identify samples with high adapter content or low base quality scores that might require re-sequencing.
- **Integration**: Use `bactopia-qc` as the first step before moving to `bactopia-assembler`. High-quality reads significantly reduce the complexity of the de Bruijn graphs used in assembly.

## Reference documentation
- [Bactopia Introduction](./references/bactopia_github_io_index.md)
- [Anaconda Bioconda bactopia-qc Overview](./references/anaconda_org_channels_bioconda_packages_bactopia-qc_overview.md)