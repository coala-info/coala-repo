---
name: pgx-pipe-helper
description: The pgx-pipe-helper provides a unified interface for standardizing sample barcode handling and genomic loci management within pharmacogenomics pipelines. Use when user asks to validate sample identifiers, ensure consistent barcode naming conventions, or parse and translate genomic coordinate strings.
homepage: https://github.com/lumc/pgx-pipe-helper
---


# pgx-pipe-helper

## Overview
The `pgx-pipe-helper` is a specialized Python utility designed to provide a unified interface for common operations within the Pharmacogenomics (PGx) pipeline developed by LUMC. Its primary purpose is to standardize how different stages of the pipeline interact with sample barcodes and genomic loci, preventing data silos or formatting inconsistencies between disparate processing steps.

## Installation and Setup
The tool is available via Bioconda or directly from the source repository.

### Using Conda (Recommended)
To integrate the helper into a managed environment:
```bash
conda install -c bioconda pgx-pipe-helper
```

### Using Pip
For development or specific git-based versioning:
```bash
pip install git+https://github.com/lumc-pgx/pipe-helper.git
```

## Usage Patterns
The module is typically used as a dependency within other Python-based pipeline stages rather than as a standalone CLI tool.

### Consistent Barcode Handling
When developing a new pipeline stage, import the helper to ensure barcode parsing matches the rest of the suite:
- Use the internal methods to validate sample identifiers.
- Ensure that output filenames follow the standardized barcode naming convention enforced by the module.

### Loci Management
The helper provides logic for handling genomic coordinates (loci).
- Use the module to parse loci strings consistently.
- Rely on the helper to translate between different coordinate representations if required by specific PGx tools.

## Best Practices
- **Version Consistency**: Ensure all stages of your PGx pipeline are using the same version of `pgx-pipe-helper` to avoid "version skew" in how barcodes or loci are interpreted.
- **Environment Isolation**: Always install the helper within a dedicated Conda environment to avoid conflicts with other bioinformatics packages that might have different dependency requirements for `setup.py`.
- **Source Reference**: If the Bioconda version is outdated, prefer the GitHub repository for the latest logic regarding barcode formatting.

## Reference documentation
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_pgx-pipe-helper_overview.md)
- [GitHub Repository (LUMC)](./references/github_com_LUMC_pgx-pipe-helper.md)