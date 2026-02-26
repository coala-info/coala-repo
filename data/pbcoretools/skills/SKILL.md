---
name: pbcoretools
description: pbcoretools provides a suite of command-line utilities for validating, filtering, and managing PacBio genomic data formats and metadata. Use when user asks to validate PacBio data files, subsample or anonymize BAM files, or split and merge Dataset XML files for parallel processing.
homepage: https://github.com/mpkocher/pbcoretools
---


# pbcoretools

## Overview
The `pbcoretools` package is a collection of Python-based CLI utilities designed for the manipulation and validation of PacBio-specific genomic data formats. It serves as a bridge for handling metadata and file integrity within the PacBio ecosystem, providing essential tools for data preparation, quality control, and workflow parallelization.

## CLI Usage and Best Practices

### File Validation with `pbvalidate`
Use `pbvalidate` to ensure that PacBio data files (BAM, Dataset XML) conform to expected specifications and contain consistent metadata.
- **Integrity Checks**: It verifies that the number of records matches the metadata counts.
- **Metadata Validation**: Use it to check for the presence of required headers and indices (like `.pbi` files).

### BAM Manipulation with `bamsieve`
`bamsieve` is the primary tool for filtering and subsampling PacBio BAM files while maintaining metadata integrity.
- **Subsampling**: Extract a subset of reads from a larger BAM file.
- **Anonymization**: Use the anonymize option to strip or mask sensitive sequence information while preserving the file structure for testing.
- **Metadata Propagation**: When sieving, the tool ensures that the resulting output maintains the appropriate links to the original input dataset metadata.

### Dataset Management (Scatter and Gather)
For large-scale processing, `pbcoretools` provides utilities to split (scatter) and merge (gather) PacBio Dataset XML files.
- **Scattering**: Use `contig-scatter` to split a ContigSet or other dataset into smaller chunks for parallel processing. It handles corner cases like empty chunk files gracefully.
- **Gathering**: Use `contig-gather` or `txt-gather` to consolidate results from parallel tasks back into a single unified dataset or text file.
- **UUID Management**: The gathering process is designed to ensure that new, unique UUIDs are generated for consolidated datasets to prevent metadata collisions.

### Conversion Utilities
- **`bax2bam` Integration**: While often a separate binary, `pbcoretools` logic supports the creation of `.pbi` (PacBio Index) files during the conversion from legacy `bax.h5` formats to the modern BAM format.
- **`bam2bam`**: Used for internal BAM-to-BAM transformations, often requiring a reference FASTA file to be passed during the task execution.

## Expert Tips
- **Logging**: Most tools in this suite support standard logging flags. Use `-v` or `--verbose` to debug dataset metadata mismatches.
- **Index Files**: Always ensure `.pbi` files are present alongside BAM files; many `pbcoretools` utilities rely on these indices for fast random access and metadata retrieval.
- **Dataset XMLs**: Prefer passing Dataset XML files instead of raw BAM files to these tools to ensure that all associated metadata (chemistry, read groups, etc.) is correctly tracked.

## Reference documentation
- [Main Repository and README](./references/github_com_mpkocher_pbcoretools.md)
- [Commit History and Tool Evolution](./references/github_com_mpkocher_pbcoretools_commits_master.md)