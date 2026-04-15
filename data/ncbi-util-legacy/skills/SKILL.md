---
name: ncbi-util-legacy
description: The ncbi-util-legacy package provides foundational C-based libraries and utilities for sequence manipulation and bioinformatics data processing. Use when user asks to process or validate ASN.1 data, convert NCBI Gene records to XML, or prepare sequence databases for legacy BLAST searches.
homepage: ftp://ftp.ncbi.nih.gov/toolbox/ncbi_tools/
metadata:
  docker_image: "quay.io/biocontainers/ncbi-util-legacy:6.1--h0e27e84_3"
---

# ncbi-util-legacy

## Overview
The `ncbi-util-legacy` package provides the foundational C-based programming libraries and applications developed by the National Center for Biotechnology Information. While many functions have been superseded by the C++ Toolkit (NCBI-plus), this legacy version remains critical for maintaining older bioinformatics pipelines, executing specific sequence manipulation tasks, and utilizing classic utilities that are not present in newer distributions.

## Core Utilities and Usage
The legacy toolkit includes several high-utility binaries. Common patterns include:

- **asntool**: Used for processing, validating, and converting ASN.1 (Abstract Syntax Notation One) data, which is the internal data format used by NCBI.
  - Validate an ASN.1 file: `asntool -m <module_file> -v <data_file>`
- **errhdr**: Generates C/C++ error header files from message files.
- **gene2xml**: Converts NCBI Gene records into XML format for easier parsing in modern scripts.
- **formatdb**: (Legacy version) Prepares sequence files for BLAST searches. Note: Use `makeblastdb` for modern BLAST+, but use `formatdb` for legacy compatibility.
  - `formatdb -i sequences.fasta -p F -o T`

## Best Practices
- **Environment Pathing**: Ensure the toolkit binaries are in your PATH after installation via Conda. The legacy tools often share names with newer versions; always verify you are calling the intended version using `which <tool>`.
- **Data Formats**: This toolkit is optimized for ASN.1. When working with large-scale NCBI data dumps, converting to ASN.1 first using these utilities can often speed up downstream processing.
- **Memory Management**: These legacy C tools are generally lightweight but may have fixed buffer sizes. Monitor memory when processing exceptionally large genomic scaffolds.



## Subcommands

| Command | Description |
|---------|-------------|
| asntool | AsnTool 7 arguments |
| errhdr | Prints error header information. |
| gene2xml | Converts NCBI gene information files to XML format. |

## Reference documentation
- [NCBI-util-legacy Overview](./references/anaconda_org_channels_bioconda_packages_ncbi-util-legacy_overview.md)