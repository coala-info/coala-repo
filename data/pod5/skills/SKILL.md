---
name: pod5
description: POD5 is a high-performance file format and toolkit used to store, manage, and manipulate raw nanopore sequencing data. Use when user asks to convert FAST5 files to POD5, inspect file metadata, merge multiple datasets, or subset reads by ID.
homepage: https://github.com/nanoporetech/pod5-file-format
---


# pod5

## Overview

POD5 is a high-performance file format developed by Oxford Nanopore Technologies to store raw sequencing data. Built on Apache Arrow, it replaces the legacy FAST5 format by providing faster data access, better compression, and a streaming-friendly architecture. This skill provides the necessary command-line patterns and procedural knowledge to manipulate POD5 files and integrate them into bioinformatics pipelines.

## Installation

Install the core toolkit via pip:

```bash
pip install pod5
```

## Common CLI Workflows

### Converting FAST5 to POD5
The most common task is migrating legacy data to the modern format. Use the `convert fast5` command:

```bash
# Convert a directory of FAST5 files to a single POD5 file
pod5 convert fast5 ./input_fast5_dir/ --output converted_data.pod5

# Use multiple threads for faster processing
pod5 convert fast5 ./input_fast5_dir/ --output converted_data.pod5 --threads 8
```

### Inspecting Files
To view metadata, read counts, and file integrity:

```bash
# View a summary of the file content
pod5 inspect summary file.pod5

# Check for file corruption or missing indices
pod5 inspect debug file.pod5

# List all read IDs in a file
pod5 view file.pod5 --ids
```

### Merging and Subsetting
Manage large datasets by combining files or extracting specific reads:

```bash
# Merge multiple POD5 files into one
pod5 merge input_1.pod5 input_2.pod5 input_3.pod5 --output merged.pod5

# Extract specific reads based on a list of Read IDs
pod5 subset input.pod5 --output subset.pod5 --ids read_ids.txt
```

## Python API Usage

For custom analysis, use the `pod5` Python library to iterate over reads and access raw signal data.

```python
import pod5

# Reading raw signal data
with pod5.Reader("data.pod5") as reader:
    for read in reader.reads():
        read_id = read.read_id
        signal = read.signal
        sample_rate = read.sample_rate
        # Process signal data...
```

## Expert Tips

- **Performance**: Always specify `--threads` during conversion if working on a multi-core system; the default may not utilize all available resources.
- **Storage**: POD5 files are significantly more efficient than FAST5. If you are low on storage, converting and then archiving the original FAST5s is a standard practice.
- **Compatibility**: Because POD5 is based on Apache Arrow, you can often use Arrow-compatible tools in other languages (like R or Julia) to read the underlying tables if the Python API is not suitable for your environment.
- **Recursive Search**: When converting, use the `--recursive` flag if your FAST5 files are organized in nested subdirectories.



## Subcommands

| Command | Description |
|---------|-------------|
| pod5 | Tools for inspecting, converting, subsetting and formatting POD5 files |
| pod5 subset | Given one or more pod5 input files, take subsets of reads into one or more pod5 output files by a user-supplied mapping. |
| pod5_convert | File conversion tools |
| pod5_filter | Take a subset of reads using a list of read_ids from one or more inputs |
| pod5_merge | Merge multiple pod5 files |
| pod5_recover | Attempt to recover pod5 files. Recovered files are written to sibling files with the '_recovered.pod5` suffix |
| pod5_repack | Repack a pod5 files into a single output |
| pod5_update | Update a pod5 files to the latest available version |
| pod5_view | Write contents of some pod5 file(s) as a table to stdout or --output if given. |

## Reference documentation
- [POD5 File Format Overview](./references/github_com_nanoporetech_pod5-file-format.md)
- [Python Library Documentation](./references/github_com_nanoporetech_pod5-file-format_tree_master_python.md)