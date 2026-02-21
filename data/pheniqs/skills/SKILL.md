---
name: pheniqs
description: Pheniqs (PHEnotypic iNdexing and Quality Supervision) is a high-performance, multi-threaded C++ toolset designed for the precise manipulation and classification of Next-Generation Sequencing (NGS) data.
homepage: http://biosails.github.io/pheniqs
---

# pheniqs

## Overview

Pheniqs (PHEnotypic iNdexing and Quality Supervision) is a high-performance, multi-threaded C++ toolset designed for the precise manipulation and classification of Next-Generation Sequencing (NGS) data. It specializes in demultiplexing reads by addressing multiple combinatorial index tags located anywhere along a read. Unlike traditional tools that rely solely on edit distance, Pheniqs implements a Bayesian probabilistic classifier that accounts for sequencing noise and base quality, reporting confidence scores directly in SAM auxiliary tags.

## Installation and Setup

Pheniqs is most easily installed via the Bioconda channel.

```bash
conda install -c bioconda -c conda-forge pheniqs
```

For high-performance environments, portable statically linked binaries are available, and the tool scales linearly with the number of available CPU cores.

## Core CLI Usage

The primary interaction with Pheniqs occurs through its command-line interface, which supports autocomplete and POSIX standard streams (piping).

### 1. Barcode Classification and Demultiplexing
The core workflow involves taking a multiplexed input (FASTQ or BAM) and a configuration file to produce demultiplexed outputs. 

*   **Probabilistic Decoding**: Use Pheniqs when you need to distinguish between barcodes that are close in edit distance but distinguishable via quality scores.
*   **Combinatorial Indexing**: Use it for designs with multiple indices (e.g., i5, i7, and molecular identifiers) across different read segments.
*   **Stream Processing**: Pheniqs can read from `stdin` and write to `stdout`, making it ideal for integration into shell-based bioinformatics pipelines.

### 2. Format Interconversion
Pheniqs serves as a rapid utility for converting between standard sequence formats without performing barcode processing.
*   Supported formats: FASTQ, SAM, BAM, CRAM.
*   It interfaces directly with the HTSLib C API for maximum efficiency.

### 3. Configuration Management
Pheniqs uses external configuration files (JSON or YAML) to define experimental designs.
*   **Inheritance**: Configurations can inherit from existing templates, allowing you to reuse barcode sets across different runs.
*   **Tokenization**: Define specific segments of the read (tokens) where barcodes are expected.
*   **Bootstraping**: Use provided helper scripts to generate initial configuration templates based on your experimental setup.

## Best Practices and Expert Tips

*   **Leverage Auxiliary Tags**: Always check the SAM auxiliary tags produced by Pheniqs. These tags contain the classification error probabilities, which can be used to filter low-confidence reads in downstream analysis.
*   **Thread Optimization**: Use the multi-threading capabilities by specifying the appropriate number of threads for your hardware to ensure linear performance scaling.
*   **Validation**: Before running large-scale demultiplexing, validate your configuration file using the built-in validation checks to ensure barcode sets and read segments are correctly defined.
*   **Memory Efficiency**: Because Pheniqs is written in C++11 and optimized for speed, it is often more memory-efficient than Python or Perl-based demultiplexers when handling deep sequencing runs.

## Reference documentation

- [Pheniqs Overview](./references/anaconda_org_channels_bioconda_packages_pheniqs_overview.md)
- [Pheniqs Documentation](./references/biosails_github_io_pheniqs.md)