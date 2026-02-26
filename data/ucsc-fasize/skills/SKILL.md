---
name: ucsc-fasize
description: The `ucsc-fasize` tool calculates rapid sequence statistics from FASTA files. Use when user asks to summarize FASTA file statistics, get individual sequence sizes from a FASTA file, output FASTA statistics in a tab-separated format, or get combined FASTA statistics for multiple files.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---


# ucsc-fasize

## Overview
The `faSize` utility (distributed via the `ucsc-fasize` package) is a specialized tool from the UCSC Genome Browser "Kent" toolkit designed for rapid sequence statistics. It parses FASTA files to provide a summary of the total number of sequences, the total number of bases, and the count of non-N bases. It is significantly faster than general-purpose text processing tools for large genomic datasets.

## Usage Instructions

### Basic Command
To get a summary of a FASTA file, run:
```bash
faSize input.fa
```
This will output the total number of sequences, total bases, and the number of bases excluding 'N's.

### Common CLI Patterns
*   **Detailed Statistics**: Use the `-detailed` flag to get the size of every individual sequence in the file.
    ```bash
    faSize -detailed input.fa
```
*   **Tab-Separated Output**: Use the `-tab` flag to produce output that is easily parsed by other command-line tools or imported into spreadsheets.
*   **Working with Multiple Files**: You can pass multiple FASTA files as arguments to get a combined total.
    ```bash
    faSize chr1.fa chr2.fa chr3.fa
```

### Expert Tips
*   **Binary Discovery**: If you have downloaded the binary directly from the UCSC server rather than via Conda, ensure it has execution permissions: `chmod +x faSize`.
*   **Help Menu**: Like most UCSC Kent utilities, running the command with no arguments will display the full list of available options and version information.
*   **Pipe Integration**: `faSize` can be used in pipelines to validate that a sequence extraction or filtering step resulted in the expected total base count.
*   **Architecture Matching**: When downloading binaries manually from the UCSC index, ensure you match your system architecture (e.g., `linux.x86_64` vs `macOSX.arm64`) as indicated in the directory listings.

## Reference documentation
- [bioconda | ucsc-fasize overview](./references/anaconda_org_channels_bioconda_packages_ucsc-fasize_overview.md)
- [UCSC Admin Executables Index](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [UCSC Linux x86_64 Binaries](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)