---
name: bird_tool_utils_python
description: The `bird_tool_utils_python` library is a collection of opinionated utilities designed to standardize the user interface and internal logic of bioinformatic tools.
homepage: https://github.com/wwood/bird_tool_utils-python
---

# bird_tool_utils_python

## Overview

The `bird_tool_utils_python` library is a collection of opinionated utilities designed to standardize the user interface and internal logic of bioinformatic tools. It is particularly useful for developers who want to implement professional-grade command-line interfaces (CLI) with built-in logging, man-page support, and efficient sequence processing without reinventing common boilerplate code.

## Core Utilities and Best Practices

### Standardized Argument Parsing
Use `BirdArgparser` instead of the standard `argparse` to ensure consistency with the "bird" suite of tools.

- **Enhanced Help**: It automatically provides a `--full-help` flag which displays a formatted man page.
- **ROFF Support**: Use `--full-help-roff` to generate ROFF output, which can be converted to HTML for documentation.
- **Subcommands**: If a subcommand should execute without additional arguments, initialize the parser with `allow_no_args=True`.
- **Logging**: Logging arguments are included by default, reducing setup time for diagnostic output.

### Efficient Sequence Reading
For processing genomic data, use the `SeqReader` class. It provides pure-Python generator functions that are memory-efficient.

- **FASTA**: Use `SeqReader().readfa(file_handle)` to iterate over FASTA records.
- **FASTQ**: Use `SeqReader().readfq(file_handle)` for FASTQ records.

### Directory and File Management
The library provides context managers to handle environment state safely during execution.

- **Temporary Directories**: Use `in_tempdir` to ensure that intermediate files are cleaned up automatically after a process completes or fails.
- **Working Directory**: Use `in_working_directory` to temporarily switch the execution context to a specific path, ensuring the script returns to its original location afterward.

### Data Processing
- **Chunking**: Use `iterable_chunks(iterable, size)` to process large datasets in manageable batches, which is essential for memory-constrained bioinformatic pipelines.
- **Tables**: Use `table_roff` to generate ROFF-formatted tables specifically for use within `BirdArgparser` help messages.

## Installation
The package is primarily distributed via Bioconda:
```bash
conda install bioconda::bird_tool_utils_python
```

## Reference documentation
- [GitHub Repository Overview](./references/github_com_wwood_bird_tool_utils-python.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_bird_tool_utils_python_overview.md)