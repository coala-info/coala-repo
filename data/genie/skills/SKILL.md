---
name: genie
description: Genie is a specialized bioinformatics suite designed for high-performance manipulation of next-generation sequencing data.
homepage: https://github.com/sakkayaphab/genie
---

# genie

## Overview
Genie is a specialized bioinformatics suite designed for high-performance manipulation of next-generation sequencing data. It serves as a versatile utility for researchers needing to bridge gaps between different genomic data formats or perform rapid filtering and transformation of sequence files. This skill provides the necessary command-line patterns to leverage genie's capabilities for efficient data handling within genomic pipelines.

## Command Line Usage
Genie follows a standard subcommand-based CLI structure. Use the following patterns for common genomic tasks:

### Data Transformation
- **Format Conversion**: Use genie to convert between common sequencing formats (e.g., FASTQ, FASTA, SAM).
- **Filtering**: Apply quality or length filters to raw reads before downstream assembly or mapping.
- **Manipulation**: Perform header modifications or sequence trimming.

### Common Patterns
- **Help Access**: To see all available subcommands, run:
  `genie --help`
- **Subcommand Help**: To see specific options for a tool (e.g., `read-filter`), run:
  `genie [subcommand] --help`

## Best Practices
- **Piping**: Genie is designed to work within Unix pipes. Stream data into and out of genie to avoid unnecessary disk I/O and save storage space.
- **Version Consistency**: Ensure you are using version 0.7.0 or higher for the most stable feature set and performance optimizations.
- **Resource Management**: When processing large NGS datasets, monitor memory usage, although genie is optimized for fast processing.

## Reference documentation
- [Genie Overview](./references/anaconda_org_channels_bioconda_packages_genie_overview.md)