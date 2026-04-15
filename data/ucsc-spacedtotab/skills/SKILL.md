---
name: ucsc-spacedtotab
description: `ucsc-spacedtotab` converts whitespace-delimited data, especially from genomic pipelines, into strict tab-delimited format. Use when user asks to convert whitespace-delimited data to tab-delimited, prepare genomic data for database loading, or convert command output to TSV.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
metadata:
  docker_image: "quay.io/biocontainers/ucsc-spacedtotab:482--h0b57e2e_0"
---

# ucsc-spacedtotab

## Overview
The `spacedToTab` utility is a specialized tool from the UCSC Genome Browser "kent" source tree designed to sanitize whitespace-delimited data. While many general-purpose tools like `awk` or `sed` can handle whitespace conversion, this tool is optimized for the specific fixed-width or multi-space patterns frequently encountered in genomic data pipelines. It is particularly useful for preparing raw command-line outputs for ingestion into MySQL databases or downstream tools that require strict tab-delimited input.

## Usage Instructions

### Basic Syntax
The tool typically reads from standard input and writes to standard output.
```bash
spacedToTab < input_file > output.tsv
```

### Common Patterns
*   **Converting Command Output**: Pipe the output of other UCSC utilities directly into `spacedToTab` to create a clean TSV.
    ```bash
    someUcscTool | spacedToTab > clean_data.tsv
    ```
*   **Batch Processing**: Use in a loop to convert multiple legacy files.
    ```bash
    for f in *.txt; do spacedToTab < "$f" > "${f%.txt}.tsv"; done
    ```

### Expert Tips
*   **Handling Permission Denied**: If you have downloaded the binary directly from the UCSC server rather than via Conda, you must ensure the execution bit is set:
    ```bash
    chmod +x ./spacedToTab
    ```
*   **Fixed-Width vs. Variable Space**: Unlike a simple "replace space with tab" command, `spacedToTab` is designed to treat contiguous blocks of spaces as a single delimiter, making it more robust for human-readable tables where columns are aligned visually.
*   **Integration with `hgLoadSqlTab`**: This tool is often the first step in a pipeline before using `hgLoadSqlTab` to load data into a UCSC-style database, as `hgLoadSqlTab` requires strict tab separation.
*   **Verification**: Always verify the column count after conversion, especially if the input file contains empty fields represented by whitespace, as these can sometimes be collapsed depending on the specific input formatting.

## Reference documentation
- [ucsc-spacedtotab - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_ucsc-spacedtotab_overview.md)
- [Index of /admin/exe](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Index of /admin/exe/linux.x86_64.v369](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.v369.md)