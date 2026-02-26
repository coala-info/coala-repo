---
name: cgecore
description: This module provides standardized utility functions and genomic data processing tools for the Center for Genomic Epidemiology software suite. Use when user asks to validate FASTA or FASTQ inputs, parse CGE tool outputs, or manage database directories for tools like ResFinder and VirulenceFinder.
homepage: https://bitbucket.org/genomicepidemiology/cge_core_module
---


# cgecore

## Overview
The `cgecore` module serves as the foundational library for tools developed by the Center for Genomic Epidemiology. It provides standardized functions for genomic data processing, including input validation, result formatting, and common utility functions used across various CGE tools like ResFinder, VirulenceFinder, and PlasmidFinder. Use this skill to ensure consistency with CGE standards when developing or executing genomic pipelines.

## Implementation Patterns

### Environment Setup
Install the core module via bioconda to ensure all dependencies for CGE tools are met:
```bash
conda install -c bioconda cgecore
```

### Core Functionality and Best Practices
- **Standardized Input**: Use `cgecore` utilities to validate FASTA and FASTQ inputs before passing them to specific CGE search engines.
- **Result Parsing**: When automating CGE tool outputs, leverage the core module's parsing logic to maintain compatibility with the CGE web interface formats.
- **Database Management**: Use the core module's directory handling logic to point local installations of ResFinder or PointFinder to their respective database paths.

### Expert Tips
- **Version Consistency**: Ensure `cgecore` is updated alongside specific CGE tools (like ResFinder) to avoid schema mismatches in JSON outputs.
- **Dependency Resolution**: If encountering issues with CGE tools, verify the `cgecore` installation first, as it contains the shared logic for BLAST/KMA execution wrappers.

## Reference documentation
- [cgecore Overview](./references/anaconda_org_channels_bioconda_packages_cgecore_overview.md)