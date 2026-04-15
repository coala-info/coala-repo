---
name: locus_processing
description: The locus_processing tool manages and validates locus definition files to ensure they conform to standardized JSON schemas. Use when user asks to validate locus metadata, manage SNP identifiers, process HGVS notations, or select preferred transcripts.
homepage: https://github.com/LUMC/locus_processing
metadata:
  docker_image: "quay.io/biocontainers/locus_processing:0.0.4--py_0"
---

# locus_processing

## Overview
The `locus_processing` tool provides a suite of utilities for managing and validating locus definition files. It is primarily used in bioinformatics pipelines to ensure that locus metadata—including transcripts, SNPs, and genomic coordinates—conforms to a standardized JSON schema. It also facilitates the retrieval of sequences and the conversion of variant notations.

## Installation and Setup
Install the package via the Bioconda channel:
```bash
conda install bioconda::locus_processing
```
The tool requires Python 3.5+ and depends on `marshmallow` for object serialization and `pyaml` for handling configuration.

## Core Capabilities
- **Schema Validation**: Validates locus definition files against a predefined JSON schema to ensure data integrity.
- **SNP Management**: Supports fetching rs IDs and sequences, as well as retrieving specific SNPs by their identifiers.
- **Transcript Selection**: Allows for the selection of preferred transcripts when applying HGVS notations.
- **Notation Conversion**: Extracts and processes `c.` (coding) and `p.` (protein) notations for variants within a defined locus.
- **Schema Generation**: Includes utilities to generate JSON schemas automatically using `marshmallow-jsonschema`.

## Common Tasks
- **Validating a Locus**: Use the CLI to check for unique SNP IDs and valid haplotype types within your definition files.
- **HGVS Processing**: Apply HGVS notations to a locus while specifying preferred transcripts to ensure consistent variant naming.
- **Data Export**: Use the "dump locus" methods to serialize processed locus objects back into a structured format.

## Expert Tips
- **Transcript Consistency**: Always verify transcript names when applying notations, as the tool includes specific validation checks for transcript existence.
- **Marshmallow Versioning**: If running in a custom environment, ensure `marshmallow` is pinned to a version compatible with the tool (historically 2.x) to avoid serialization errors.
- **Metadata Cleanup**: The tool has deprecated certain fields like `activity` in newer versions; ensure your input files focus on coordinates and identifiers.

## Reference documentation
- [Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_locus_processing_overview.md)
- [GitHub Repository Summary](./references/github_com_LUMC_locus_processing.md)
- [Commit History and Feature Log](./references/github_com_LUMC_locus_processing_commits_master.md)