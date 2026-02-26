---
name: ucsc-rowstocols
description: The `ucsc-rowstocols` tool transposes the rows and columns of a delimited text file. Use when user asks to transpose a file, rotate a data matrix, switch between wide and long data formats, or convert rows to columns.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---


# ucsc-rowstocols

## Overview
`rowsToCols` is a specialized command-line utility for transposing the axes of a delimited text file. It effectively rotates a data matrix 90 degrees, turning every row into a column and every column into a row. This is a common requirement in genomic data processing when switching between "wide" and "long" data formats or when a downstream tool expects samples as rows instead of columns.

## Command Line Usage

The tool follows the standard UCSC Kent utility pattern. Execute the command by providing the input file and the desired output path.

### Basic Transposition
To transpose a file using the default settings (typically tab-delimited):
```bash
rowsToCols input.txt output.txt
```

### Handling Permissions
If you have downloaded the binary directly from the UCSC server, ensure it has executable permissions before running:
```bash
chmod +x rowsToCols
./rowsToCols input.txt output.txt
```

## Best Practices and Expert Tips

### Memory Considerations
`rowsToCols` generally loads the entire input file into memory to perform the transposition. When working with extremely large genomic matrices (e.g., single-cell expression data with tens of thousands of cells and genes), ensure your environment has sufficient RAM to hold the entire dataset.

### Delimiter Consistency
The tool is optimized for tab-separated values (TSV), which is the standard for UCSC tools. If your input uses different delimiters, consider converting them to tabs first using `sed` or `awk` to ensure predictable behavior.

### Verification
After transposition, verify the dimensions of your data using `awk`.
*   **Check original dimensions:** `awk '{print NF}' input.txt | head -n 1` (columns) and `wc -l input.txt` (rows).
*   **Check transposed dimensions:** The new column count should match the old row count.

### Integration in Pipelines
Because `rowsToCols` reads from a file and writes to a file, it is best used as a discrete step in a shell script. If you need to process data through a stream, use `/dev/stdin` or `/dev/stdout` if your operating system supports it, though the tool is primarily designed for direct file-to-file operations.

## Reference documentation
- [ucsc-rowstocols - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_ucsc-rowstocols_overview.md)
- [Index of /admin/exe](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Index of /admin/exe/linux.x86_64.v369](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.v369.md)