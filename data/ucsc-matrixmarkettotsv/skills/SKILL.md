---
name: ucsc-matrixmarkettotsv
description: The ucsc-matrixmarkettotsv tool converts sparse matrices from Matrix Market format into tab-separated value (TSV) files. Use when user asks to 'convert Matrix Market files to TSV', 'flatten sparse matrices', or 'prepare sparse matrix data for downstream analysis'.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---


# ucsc-matrixmarkettotsv

## Overview

`ucsc-matrixmarkettotsv` is a high-performance command-line utility from the UCSC Genome Browser "Kent" toolset. It is designed to flatten sparse matrices stored in the Matrix Market format into a standard tab-separated text file. This is a critical step in bioinformatics workflows where data is stored compactly as coordinates (row, column, value) but needs to be read by downstream tools that expect a traditional matrix or table structure.

## Usage Instructions

### Basic Command Pattern
The tool follows a straightforward input-output syntax:

```bash
matrixMarketToTsv input.mtx output.tsv
```

### Installation and Setup
If the tool is not already in your PATH, you can install it via Bioconda or download the pre-compiled binary for your architecture:

*   **Conda**: `conda install bioconda::ucsc-matrixmarkettotsv`
*   **Manual Download**: Ensure the binary has execution permissions:
    ```bash
    chmod +x matrixMarketToTsv
    ./matrixMarketToTsv input.mtx output.tsv
    ```

## Expert Tips and Best Practices

### Managing File Size
Matrix Market files are sparse (only non-zero values are stored), while TSV files are typically dense. Converting a large sparse matrix to TSV can result in a massive increase in file size. 
*   **Check Dimensions**: Before converting, verify the matrix dimensions (usually found in the first non-comment line of the `.mtx` file) to estimate the resulting TSV size.
*   **Downstream Compatibility**: Only use this tool if your downstream analysis software cannot natively handle sparse formats (like `dgCMatrix` in R or `scipy.sparse` in Python).

### Integration with Kent Utilities
This tool is often used as part of a pipeline with other UCSC matrix utilities found in the same suite:
*   **matrixNormalize**: For scaling data after conversion.
*   **matrixClusterColumns**: For grouping related data points.

### Troubleshooting
*   **Permission Denied**: If running a downloaded binary, always check `chmod +x`.
*   **Help Statement**: Run the command with no arguments to see the built-in usage summary and version information.

## Reference documentation
- [ucsc-matrixmarkettotsv - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_ucsc-matrixmarkettotsv_overview.md)
- [Index of /admin/exe/linux.x86_64](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)
- [UCSC Genome Browser Binaries Overview](./references/hgdownload_cse_ucsc_edu_admin_exe.md)