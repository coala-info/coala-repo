---
name: ensembl-utils
description: The ensembl-utils skill provides a standardized suite of tools for managing Ensembl databases, retrieving genomic data, and processing bioinformatics workflows. Use when user asks to interface with Ensembl MySQL instances, fetch genomic features by ID or coordinates, or convert between Ensembl-specific and standard bioinformatics formats.
homepage: https://www.ensembl.org/
metadata:
  docker_image: "quay.io/biocontainers/ensembl-utils:0.8.0--pyhdfd78af_0"
---

# ensembl-utils

## Overview
The ensembl-utils skill enables efficient interaction with the Ensembl Python utility suite. This package is designed to provide a standardized set of general-purpose tools for Ensembl-related bioinformatics tasks, including database management, data retrieval, and common genomic data processing workflows. Use this skill to ensure correct CLI syntax and to leverage best practices for Ensembl data integration.

## Common CLI Patterns
The package typically provides several entry points for genomic data manipulation. Common patterns include:

- **Database Connectivity**: Use the standard Ensembl connection parameters (`--host`, `--port`, `--user`, `--database`) to interface with public or private Ensembl MySQL instances.
- **Data Fetching**: Utilize scripts for retrieving specific genomic features (genes, transcripts, variations) by stable ID or coordinate range.
- **Format Conversion**: Leverage utilities to convert between Ensembl-specific formats and standard bioinformatics formats like GFF3, GTF, or BED.

## Best Practices
- **Environment Setup**: Always ensure the tool is installed via bioconda (`conda install bioconda::ensembl-utils`) to manage dependencies like SQLAlchemy and BioPython automatically.
- **Public MySQL Server**: When querying public data, use `host: ensembldb.ensembl.org`, `user: anonymous`, and `port: 3306` (or `5306` for recent releases).
- **Logging**: Use the `--verbose` or `--log_level` flags during complex data migrations or large-scale fetches to monitor progress and catch connection timeouts.

## Reference documentation
- [Ensembl-utils Overview](./references/anaconda_org_channels_bioconda_packages_ensembl-utils_overview.md)