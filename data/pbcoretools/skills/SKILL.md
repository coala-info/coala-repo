---
name: pbcoretools
description: pbcoretools is a collection of Python-based command-line utilities for managing, validating, and manipulating PacBio-specific genomic data formats. Use when user asks to create or split Dataset XML files, subset BAM files with bamsieve, validate file integrity using pbvalidate, or convert legacy BAX.H5 files to BAM format.
homepage: https://github.com/mpkocher/pbcoretools
---

# pbcoretools

## Overview
pbcoretools is a collection of Python-based command-line utilities designed to interface with PacBio's core APIs and data formats. This skill enables efficient handling of PacBio-specific files (BAM, Dataset XML, PBI) for tasks such as validating file integrity, subsetting data, and managing large-scale genomic datasets through scatter/gather patterns. It is the primary toolkit for bioinformatics applications requiring deterministic interaction with PacBio data structures.

## Core CLI Tools and Usage

### Dataset Management (`dataset`)
The `dataset` tool is the primary interface for creating and manipulating PacBio Dataset XML files.
- **Gathering**: Use to consolidate multiple chunked files into a single dataset.
  - Common pattern: `dataset gather <output.xml> <input1.xml> <input2.xml> ...`
  - Supports specific types like `ContigSet` and simple text gathering.
- **Scattering**: Use to split datasets into smaller chunks for parallel processing.
  - Common pattern: `dataset split --chunks <N> <input.xml>`
- **Metadata**: Always use the tool to update or propagate metadata to ensure UUIDs remain unique and valid across gathered datasets.

### BAM Manipulation (`bamsieve`)
Use `bamsieve` to create subsets of BAM files or to modify sequence data.
- **Subsetting**: Filter BAM files based on specific criteria (e.g., read length, quality).
- **Anonymization**: Use the `--anonymize` flag to obfuscate sequence data while preserving file structure and metadata for troubleshooting or sharing.
- **Metadata Propagation**: `bamsieve` automatically handles the propagation of input dataset metadata to the output file.

### File Validation (`pbvalidate`)
Use `pbvalidate` to ensure data integrity before starting long-running analysis pipelines.
- **Record Checking**: It verifies that the `numRecords` in the header matches the actual raw count in the file.
- **Format Compliance**: Validates that files adhere to PacBio's specific BAM and XML schema requirements.

### Conversion and Indexing
- **bax2bam**: Converts legacy BAX.H5 files to the PacBio BAM format. It is often used to generate `.pbi` (PacBio Index) files simultaneously.
- **bam2bam**: A task wrapper used for processing BAM files, including FASTA extraction for reference-based workflows.

## Best Practices
- **Indexing**: Always ensure `.pbi` files are present for BAM files to enable random access and efficient processing by other tools in the suite.
- **Logging**: Utilize the built-in logging behavior (inherited from `pbcommand`) to track tool execution and debug failures in complex pipelines.
- **UUID Integrity**: When merging datasets manually or via scripts, ensure new UUIDs are generated for the resulting XML to avoid collisions in downstream database systems.
- **Empty Chunks**: When scattering data, be prepared to handle "empty" chunk files if the number of records is less than the requested number of chunks.



## Subcommands

| Command | Description |
|---------|-------------|
| bamsieve | Tool for subsetting a BAM or PacBio DataSet file based on either a whitelist of hole numbers or a percentage of reads to be randomly selected. |
| pbvalidate | Utility for validating files produced by PacBio software against our own internal specifications. |

## Reference documentation
- [GitHub Repository Overview](./references/github_com_mpkocher_pbcoretools.md)
- [Commit History and Tool Details](./references/github_com_mpkocher_pbcoretools_commits_master.md)