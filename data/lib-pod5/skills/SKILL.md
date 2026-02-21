---
name: lib-pod5
description: `lib-pod5` is the core library providing Python bindings for the POD5 file format, a high-performance container for nanopore sequencing reads based on Apache Arrow.
homepage: https://github.com/nanoporetech/pod5-file-format
---

# lib-pod5

## Overview
`lib-pod5` is the core library providing Python bindings for the POD5 file format, a high-performance container for nanopore sequencing reads based on Apache Arrow. While `lib-pod5` provides the low-level extension modules for developers, most users interact with its functionality through the `pod5` Python package and CLI toolkit. This skill focuses on the practical application of these tools for managing raw signal data, converting formats, and optimizing data access for downstream basecalling or analysis.

## Installation
The library and its associated tools can be installed via Conda or Pip:
- **Conda**: `conda install bioconda::lib-pod5`
- **Pip**: `pip install pod5`

## Common CLI Patterns
The `pod5` package provides several essential utilities for data manipulation.

### Inspecting Data
Use `inspect` to view metadata and summary information about POD5 files.
- **Summarize file content**: `pod5 inspect summary <file.pod5>`
- **View specific read details**: `pod5 inspect reads <file.pod5>`

### Subsetting and Filtering
Extract specific reads from a larger POD5 file based on a list of Read IDs.
- **Basic subsetting**: `pod5 subset <input.pod5> --output <output_dir> --read-ids <ids.txt>`
- **Handling duplicates**: If your input contains duplicate read IDs, use the `--duplicate-ok` flag to prevent errors during the subsetting process.

### Merging Files
Combine multiple POD5 files into a single file for easier management or batch processing.
- **Merge directory**: `pod5 merge <input_dir>/*.pod5 --output <merged.pod5>`

### Viewing and Conversion
Convert POD5 data into a human-readable or tabular format (Apache Arrow/Parquet) for inspection.
- **View as table**: `pod5 view <file.pod5>`

## Expert Tips
- **Performance**: POD5 is designed for streaming. When writing custom scripts using the Python API, utilize the built-in writer options to manage buffer sizes, especially when working with high-throughput datasets.
- **Compression**: POD5 supports ZSTD and VBZ compression. If you encounter issues with uncompressed signal data in older versions, ensure you are using `lib-pod5` version 0.3.12 or later.
- **Memory Management**: Because POD5 uses Apache Arrow under the hood, it is highly efficient for random access. When subsetting very large datasets, providing a sorted list of Read IDs can sometimes improve performance.
- **Temporary Files**: Be aware that some operations may create temporary files. Ensure your environment has sufficient space in the working directory or the designated `TMPDIR`.

## Reference documentation
- [GitHub Repository: nanoporetech/pod5-file-format](./references/github_com_nanoporetech_pod5-file-format.md)
- [Bioconda: lib-pod5 Overview](./references/anaconda_org_channels_bioconda_packages_lib-pod5_overview.md)