---
name: fgpyo
description: The `fgpyo` toolkit provides a suite of utilities designed for high-performance genomic data manipulation.
homepage: https://pypi.org/project/fgpyo/
---

# fgpyo

## Overview
The `fgpyo` toolkit provides a suite of utilities designed for high-performance genomic data manipulation. It bridges the gap between general-purpose Python scripting and specialized bioinformatics needs, offering robust handling of common file formats and sequence processing workflows. It is particularly useful for developers and bioinformaticians building pipelines that require precise control over read metadata, molecular identifiers (UMIs), and genomic intervals.

## Core Capabilities and Usage

### Sequence and FASTQ Manipulation
Use `fgpyo` for tasks involving FASTQ file transformation and quality control:
- **UMI Extraction**: Extracting molecular tags from read sequences or headers.
- **Demultiplexing**: Handling complex indexing schemes.
- **Read Filtering**: Applying custom logic to filter or trim reads based on sequence content or quality.

### SAM/BAM/VCF Processing
The library provides high-level abstractions for interacting with alignment and variant files:
- **Metadata Management**: Efficiently reading and writing SAM headers and record attributes.
- **Interval Operations**: Performing set operations (intersection, union) on genomic intervals (BED/Interval lists).
- **VCF Utilities**: Parsing and manipulating variant calls and their associated annotations.

### Command Line Patterns
While `fgpyo` is often used as a library, it includes CLI utilities for common tasks. General syntax follows:
```bash
fgpyo [subcommand] [options]
```
Common subcommands include:
- `filter-bam`: Filter alignments based on specific criteria.
- `extract-umis`: Pull UMI sequences into tags for downstream consensus calling.

## Best Practices
- **Memory Efficiency**: When processing large BAM or VCF files, utilize the library's streaming iterators rather than loading entire datasets into memory.
- **Type Hinting**: Leverage the library's strong typing for genomic coordinates to avoid "off-by-one" errors common in interval arithmetic (0-based vs 1-based coordinate systems).
- **Integration**: Use `fgpyo` in conjunction with `pysam` for low-level record access while using `fgpyo` for higher-level logic and specialized genomic algorithms.

## Reference documentation
- [fgpyo Project Overview](./references/pypi_org_project_fgpyo.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_fgpyo_overview.md)