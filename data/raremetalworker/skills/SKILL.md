---
name: raremetalworker
description: This tool processes rare metal data, including parsing, filtering, and analysis of various data formats. Use when Claude needs to work with rare metal datasets for tasks such as data cleaning, format conversion, or extracting specific metal information.
homepage: https://anaconda.org/channels/bioconda/packages/raremetalworker/overview
---


# raremetalworker

raremetalworker/SKILL.md
```yaml
name: raremetalworker
description: Processes rare metal data, including parsing, filtering, and analysis of various data formats. Use when Claude needs to work with rare metal datasets for tasks such as data cleaning, format conversion, or extracting specific metal information.
```
## Overview
The `raremetalworker` tool is designed for processing and analyzing data related to rare metals. It provides functionalities to parse, filter, and manipulate datasets, making it useful for data cleaning, format conversion, and extracting specific information about rare metals.

## Usage Instructions

The `raremetalworker` tool is primarily used via its command-line interface. Below are common patterns and expert tips for effective usage.

### Core Functionality

The tool's main purpose is to process rare metal data. While specific commands and options are not detailed in the provided documentation, general usage would involve specifying input files and desired operations.

### Best Practices and Expert Tips

*   **Input Data Formats**: Be aware of the expected input data formats for `raremetalworker`. If the documentation does not specify, assume common formats like CSV, TSV, or JSON, and be prepared to convert your data if necessary.
*   **Output Options**: Understand how to direct the output of `raremetalworker`. This typically involves specifying an output file path or piping the output to another command.
*   **Filtering and Selection**: If `raremetalworker` supports filtering, leverage this to extract only the relevant data. This can significantly speed up subsequent analysis and reduce memory usage. Look for options related to column selection, row filtering based on values, or specific metal identifiers.
*   **Error Handling**: Pay close attention to any error messages or warnings produced by the tool. These often provide crucial clues for troubleshooting issues with input data or command syntax.
*   **Command Chaining**: For complex workflows, consider chaining `raremetalworker` with other command-line tools using pipes (`|`). This allows for powerful data manipulation pipelines. For example, you might pipe the output of `raremetalworker` to a text processing tool like `grep` or `awk` for further refinement.

### Example CLI Patterns (Illustrative)

While specific commands are not available, a typical interaction might look like this:

```bash
# Hypothetical command to process a rare metal data file
raremetalworker --input data.csv --output processed_data.tsv --filter "metal_type=Lithium"

# Another hypothetical example for data conversion
raremetalworker --input raw_data.json --convert-to csv --output data.csv
```

**Note**: The above examples are illustrative and based on common CLI tool patterns. Actual command syntax and options for `raremetalworker` may differ. Refer to the tool's help (`raremetalworker --help`) or detailed documentation for precise usage.

## Reference documentation
- [Anaconda.org channels bioconda packages raremetalworker overview](./references/anaconda_org_channels_bioconda_packages_raremetalworker_overview.md)