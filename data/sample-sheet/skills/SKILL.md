---
name: sample-sheet
description: The sample-sheet library provides a Pythonic interface for reading, editing, and generating Illumina Sample Sheets. Use when user asks to manage sample metadata, create or modify sample sheets programmatically, or convert sample sheets to JSON or Picard-compatible formats.
homepage: https://github.com/clintval/sample-sheet
metadata:
  docker_image: "quay.io/biocontainers/sample-sheet:0.13.0--pyhdfd78af_0"
---

# sample-sheet

## Overview
The `sample-sheet` library provides a Pythonic interface for managing Illumina Sample Sheets, serving as a robust alternative to manual CSV manipulation or the Illumina Experiment Manager. It supports the full lifecycle of a sample sheet, including reading existing files, editing metadata, and generating new sheets from scratch. This tool is essential for ensuring that sample metadata is correctly formatted for demultiplexing software and downstream analysis pipelines.

## Core Usage Patterns

### Reading and Accessing Data
The library can load sample sheets from a file path, a file-like object, or a string.
- **Load from file**: Use `SampleSheet("path/to/file.csv")`.
- **Flexible Input**: The library accepts `pathlib.Path` objects or active file handles.
- **Iteration**: You can iterate directly over the `SampleSheet` object to access individual samples.

### Creating and Modifying Sheets
- **De Novo Creation**: Initialize an empty `SampleSheet()` and populate it programmatically.
- **Adding Samples**: Use the `add_sample()` method to append new sample objects to the data section.
- **Custom Attributes**: Use the `add_attr()` method to add custom key-value pairs to the header or settings sections.
- **Header Management**: Access and modify standard Illumina headers (e.g., Investigator Name, Experiment Name) as object attributes.

### Exporting and Conversion
- **Roundtrip Writing**: Use the `.write(handle)` method to save the current state back to a valid Illumina CSV format.
- **JSON Export**: Use the library to convert complex sample sheets into JSON for use in web applications or NoSQL databases.
- **Picard Integration**: The library includes specific support for generating Picard-compatible basecalling parameters.

## Expert Tips and Best Practices

- **Validation**: The library performs automatic sanity checks on `Sample_ID` fields. Always wrap your parsing logic in try-except blocks to catch validation errors early in the pipeline.
- **Handling Non-Standard Sections**: While the library is designed for standard Illumina formats, use the `add_attr` method to handle custom application settings or data sections that may be required by specific sequencing centers.
- **Smart Open**: The library is compatible with `smart_open`, allowing you to read sample sheets directly from S3 buckets or other cloud storage providers if the environment is configured.
- **Unicode Support**: When dealing with international characters or special symbols in sample names, ensure your file handles are opened with `utf-8` encoding to prevent parsing failures.



## Subcommands

| Command | Description |
|---------|-------------|
| sample-sheet tojson | Convert a sample sheet to JSON format. |
| sample-sheet totable | Pretty print a sample sheet to terminal |

## Reference documentation
- [sample-sheet Overview](./references/anaconda_org_channels_bioconda_packages_sample-sheet_overview.md)
- [sample-sheet GitHub Repository](./references/github_com_clintval_sample-sheet.md)
- [sample-sheet Issues and Feature Requests](./references/github_com_clintval_sample-sheet_issues.md)