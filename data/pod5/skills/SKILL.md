---
name: pod5
description: POD5 is a high-performance file format designed by Oxford Nanopore Technologies for storing raw signal data.
homepage: https://github.com/nanoporetech/pod5-file-format
---

# pod5

## Overview
POD5 is a high-performance file format designed by Oxford Nanopore Technologies for storing raw signal data. Built on Apache Arrow, it allows for fast, streaming access to sequencing data and serves as the successor to the legacy FAST5 format. This skill provides guidance on using the `pod5` command-line interface (CLI) to manage these datasets, including subsetting reads, merging files, and inspecting metadata.

## Installation
The `pod5` toolkit can be installed via pip or conda:
- **Pip**: `pip install pod5`
- **Conda**: `conda install -c bioconda pod5`

## Common CLI Patterns

### Inspecting Data
Use the `inspect` command to validate file integrity or view summary information about the reads within a POD5 file.
- **Summarize reads**: `pod5 inspect reads <input.pod5>`
- **Check file health**: Use `inspect` to identify potential corruption or invalid signatures in the flatbuffer structure.

### Viewing Metadata
The `view` command allows you to export or view the internal metadata of a POD5 file in a tabular format, which is useful for identifying specific Read IDs or channel information.
- **Basic view**: `pod5 view <input.pod5>`
- **Tabular output**: Often used to pipe into tools like `grep` or `awk` to find specific sequencing parameters.

### Subsetting Reads
Subsetting is critical for extracting specific reads of interest (e.g., based on length or quality) from a large dataset.
- **Subset by Read ID**: `pod5 subset <input.pod5> --output <output_dir> --read-ids <read_ids.txt>`
- **Handling Duplicates**: Use the `--duplicate-ok` flag if your input list contains redundant Read IDs to prevent the tool from returning an error.

### Merging Files
To simplify downstream analysis, multiple POD5 files from a single run can be merged into a single archive.
- **Merge multiple files**: `pod5 merge <input_dir>/*.pod5 --output <merged.pod5>`

### Converting Legacy Formats
While POD5 is the current standard, older datasets may be in FAST5 format. The toolkit includes conversion utilities to migrate these to the more efficient POD5 format.
- **Convert FAST5 to POD5**: `pod5 convert fast5 <input_dir> --output <output_dir>`

## Expert Tips
- **Direct I/O**: For high-performance environments, check for writer options that support direct I/O to bypass filesystem caching when writing large signal datasets.
- **Memory Management**: When subsetting or merging extremely large datasets, ensure the temporary directory has sufficient space, as `pod5` may create intermediate files during the process.
- **Validation**: If you encounter "Invalid signature" or "flatbuffer size invalid" errors, use `pod5 inspect` to confirm if the file was truncated during transfer.

## Reference documentation
- [Oxford Nanopore Technologies Pod5 File Format Python API and Tools](./references/anaconda_org_channels_bioconda_packages_pod5_overview.md)
- [Pod5: a high performance file format for nanopore reads](./references/github_com_nanoporetech_pod5-file-format.md)
- [POD5 Issue Tracker and Command Usage](./references/github_com_nanoporetech_pod5-file-format_issues.md)