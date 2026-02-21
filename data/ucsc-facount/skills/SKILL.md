---
name: ucsc-facount
description: The `ucsc-facount` tool (part of the UCSC Kent Utilities, often invoked as `faCount`) is a high-performance command-line utility designed to scan FASTA files and report detailed nucleotide statistics.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---

# ucsc-facount

## Overview
The `ucsc-facount` tool (part of the UCSC Kent Utilities, often invoked as `faCount`) is a high-performance command-line utility designed to scan FASTA files and report detailed nucleotide statistics. It provides a tabular breakdown of sequence lengths, individual base counts (A, C, G, T, N), GC percentages, and the number of CpG dinucleotides. This tool is a standard in bioinformatics for quickly assessing the composition of genomic assemblies or specific regions of interest.

## Usage Patterns and Best Practices

### Basic Statistics
To get a standard report for one or more FASTA files, run the tool without additional flags. It will output a row for each sequence in the file and a total summary at the bottom.
```bash
faCount input.fasta
```

### Common CLI Options
While the tool is simple, these patterns are frequently used in genomic workflows:

*   **Tab-Separated Output**: Use the `-tab` flag to generate output that is easily parsed by downstream tools like R, Python (pandas), or AWK.
    ```bash
    faCount -tab input.fasta > stats.tsv
    ```
*   **Summary Only**: If you are processing a file with thousands of scaffolds and only need the aggregate statistics for the entire file, use the `-summary` flag.
    ```bash
    faCount -summary input.fasta
    ```
*   **Handling Multiple Files**: You can pass multiple FASTA files or use wildcards to process a batch of sequences.
    ```bash
    faCount *.fa
    ```

### Expert Tips
*   **CpG Calculation**: Note that `faCount` specifically counts the number of "CG" dinucleotides. This is essential for calculating CpG observed/expected ratios in epigenetics research.
*   **N-Base Tracking**: Use the 'N' column to quickly identify the "gap" content in draft genome assemblies.
*   **Permissions**: If you have downloaded the binary directly from the UCSC server rather than via Conda, ensure the execution bit is set: `chmod +x faCount`.
*   **Pipe Integration**: `faCount` can be integrated into pipelines. For example, to find the sequence with the highest GC content from the output:
    ```bash
    faCount -tab input.fasta | sort -k9 -nr | head -n 1
    ```

## Reference documentation
- [ucsc-facount Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-facount_overview.md)
- [UCSC Admin Executables Directory](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Linux x86_64 Binary List](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)