---
name: radtk
description: radtk is a performant toolkit for processing and inspecting binary RAD files. Use when user asks to concatenate multiple RAD files, split a RAD file into multiple outputs, or view a textual representation of RAD file records.
homepage: https://github.com/COMBINE-lab/radtk
metadata:
  docker_image: "quay.io/biocontainers/radtk:0.2.0--ha6fb395_1"
---

# radtk

## Overview

`radtk` is a specialized toolkit developed by the COMBINE-lab for handling RAD files. It provides a performant, Rust-based interface to perform common operations on these binary formats without needing to write custom parsing scripts. Its primary utility lies in merging datasets from different sequencing runs (provided they share the same reference and tag sets) and providing transparency into the contents of the binary records through its viewing capabilities.

## Command Line Usage

The `radtk` utility follows a standard sub-command structure.

### Concatenating RAD Files (`cat`)
Use the `cat` command to merge multiple RAD files. This is essential when processing samples that have been split across multiple lanes or runs.

*   **Requirement**: All input files must have compatible headers. This means they must be built against the exact same reference and contain the same set of tags.
*   **Pattern**: `radtk cat <INPUT_FILES>... --output <OUTPUT_FILE>`

### Inspecting RAD Files (`view`)
Use the `view` command to transform the binary RAD format into a textual JSON representation. This is the primary method for searching for specific records or verifying the quantities of interest within a file.

*   **Pattern**: `radtk view <INPUT_FILE>`
*   **Tip**: Since the output is JSON, pipe the result to `jq` for advanced filtering or pretty-printing.
    *   Example: `radtk view sample.rad | jq '.'`

## Expert Tips and Best Practices

1.  **Header Validation**: Before attempting a large `cat` operation, verify that your upstream alignment tool (like `salmon` or `piscem`) used the same index for all files. `radtk cat` will fail if headers are incompatible to prevent data corruption.
2.  **Logging and Troubleshooting**: `radtk` uses the `tracing` framework. If you encounter issues, check if your environment supports `RUST_LOG` levels to get more verbose output during execution.
3.  **Performance**: As a Rust-based tool, `radtk` is designed for speed. When viewing very large RAD files, consider redirecting the output to a file rather than printing to the terminal to avoid performance bottlenecks in the terminal emulator.
4.  **Help Access**: Use the standard help flags to see the most up-to-date arguments for each sub-command:
    *   `radtk --help`
    *   `radtk cat --help`
    *   `radtk view --help`



## Subcommands

| Command | Description |
|---------|-------------|
| radtk view | view a text representation of the RAD file |
| radtk_cat | concatenate the records in a sequence of RAD files |
| radtk_split | split an input RAD file into multiple output files |

## Reference documentation
- [radtk README](./references/github_com_COMBINE-lab_radtk_blob_main_README.md)
- [radtk Project Configuration](./references/github_com_COMBINE-lab_radtk_blob_main_Cargo.toml.md)