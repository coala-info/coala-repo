---
name: ucsc-coltransform
description: ucsc-coltransform performs rapid arithmetic modification of specific columns in tabular data. Use when user asks to normalize signal tracks, convert units, scale data, multiply a column, shift data, add a constant to a column, or apply combined arithmetic transformations.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
metadata:
  docker_image: "quay.io/biocontainers/ucsc-coltransform:482--h0b57e2e_0"
---

# ucsc-coltransform

## Overview
The `ucsc-coltransform` utility is a specialized command-line tool from the UCSC Genome Browser "kent" source tree designed for rapid, in-place arithmetic modification of tabular data. It is particularly useful in bioinformatics pipelines for normalizing signal tracks, converting units, or applying scaling factors to specific data columns without needing to write custom scripts or use heavy data-processing frameworks.

## Usage Instructions

### Basic Syntax
The tool follows a straightforward positional argument structure:
```bash
colTransform <file> <column_index> <multiplier> <add_constant>
```
*   **file**: The input tab-separated file (use `stdin` to pipe data).
*   **column_index**: The 1-based index of the column to transform.
*   **multiplier**: The value to multiply the column by (use `1.0` for no multiplication).
*   **add_constant**: The value to add to the column (use `0.0` for no addition).

### Common Patterns

**1. Scaling Data (Multiplication)**
To multiply the 4th column of a file by 10 (e.g., converting a 0-1 score to a 0-10 scale):
```bash
colTransform input.tab 4 10.0 0.0 > output.tab
```

**2. Shifting Data (Addition)**
To add a constant offset of 50 to the 2nd column:
```bash
colTransform input.tab 2 1.0 50.0 > output.tab
```

**3. Combined Transformation**
The tool applies multiplication *before* addition ($Result = (Value \times Multiplier) + Constant$). To multiply by 2 and then add 5:
```bash
colTransform input.tab 3 2.0 5.0 > output.tab
```

**4. Piping and Stream Processing**
`ucsc-coltransform` can be integrated into shell pipes for efficient processing:
```bash
cat data.bed | colTransform stdin 5 0.5 0.0 | someOtherTool
```

## Best Practices and Tips
*   **1-Based Indexing**: Unlike many Unix tools (like `awk`) that use 1-based indexing or others that use 0-based, ensure you verify the column count. `colTransform` typically expects 1-based indexing for the column argument.
*   **Floating Point Support**: The tool handles floating-point constants for both the multiplier and the addition constant.
*   **Tab-Separated Only**: The tool is optimized for tab-separated values (TSV). If your file uses spaces or other delimiters, convert it to tabs first using `tr ' ' '\t'` or `sed`.
*   **Permissions**: If running a freshly downloaded binary from the UCSC server, remember to set execution permissions: `chmod +x colTransform`.
*   **In-place limitations**: The tool does not support in-place editing of the source file. Always redirect output to a new file or pipe it.

## Reference documentation
- [ucsc-coltransform - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_ucsc-coltransform_overview.md)
- [Index of /admin/exe/linux.x86_64](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)