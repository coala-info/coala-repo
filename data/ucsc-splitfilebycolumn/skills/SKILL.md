---
name: ucsc-splitfilebycolumn
description: The `splitFileByColumn` utility is a high-performance tool from the UCSC Genome Browser "Kent" source tree designed for data partitioning.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---

# ucsc-splitfilebycolumn

## Overview
The `splitFileByColumn` utility is a high-performance tool from the UCSC Genome Browser "Kent" source tree designed for data partitioning. It reads a tab-separated input and creates a separate output file for every unique value encountered in a designated column. This is particularly useful in bioinformatics workflows for splitting genome-wide data into per-chromosome files or separating multiplexed data by sample identifiers.

## Usage Instructions

### Basic Syntax
The tool follows a simple positional argument structure:
```bash
splitFileByColumn <input_file> <column_index>
```
*   **input_file**: The text file to be split (typically tab-separated). Use `stdin` to pipe data into the tool.
*   **column_index**: The 1-based index of the column containing the values to use for filenames.

### Common Patterns

**Splitting a BED file by chromosome:**
If the chromosome name is in the first column:
```bash
splitFileByColumn input.bed 1
```
This will generate files like `chr1`, `chr2`, `chrX`, etc., in the current working directory.

**Processing piped data:**
```bash
grep "some_feature" large_data.tsv | splitFileByColumn stdin 3
```

### Expert Tips
1.  **1-Based Indexing**: Unlike many Unix tools that use 0-based indexing, `splitFileByColumn` uses 1-based indexing for columns.
2.  **File Permissions**: If you have just downloaded the binary from the UCSC server, ensure it is executable:
    ```bash
    chmod +x splitFileByColumn
    ```
3.  **Output Location**: The tool creates files in the current working directory. To output to a specific folder, change into that directory before running the command or ensure the column values themselves do not contain path separators unless intended.
4.  **Memory Efficiency**: The tool is designed to handle very large files efficiently by keeping file handles open for the various output files it creates.
5.  **Help Statement**: To see the most up-to-date internal documentation and versioning, run the binary with no arguments:
    ```bash
    splitFileByColumn
    ```

## Reference documentation
- [ucsc-splitfilebycolumn Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-splitfilebycolumn_overview.md)
- [UCSC Admin Executables Directory](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Linux x86_64 Binary List](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.v369.md)